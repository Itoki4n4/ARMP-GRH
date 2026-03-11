import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { BehaviorSubject, Observable, tap, catchError, of } from 'rxjs';
import { Router } from '@angular/router';
import { environment } from '../../../../environments/environment';
import { LoginCredentials, User, LoginResponse } from '../model/auth-model';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private currentUserSubject = new BehaviorSubject<User | null>(
    localStorage.getItem('currentUser') ? JSON.parse(localStorage.getItem('currentUser')!) : null
  );
  public currentUser$ = this.currentUserSubject.asObservable();

  constructor(private http: HttpClient, private router: Router) {}

  public currentUserValue(): User | null {
    return this.currentUserSubject.value;
  }

  // ⭐️ Ici c'est bien une MÉTHODE classique, pas un getter !
  public isAuthenticated(): boolean {
    return this.currentUserSubject.value !== null;
  }

  login(credentials: LoginCredentials): Observable<LoginResponse> {
    const headers = new HttpHeaders({ 'Content-Type': 'application/json', 'Accept': 'application/json' });
    return this.http.post<LoginResponse>(
      `${environment.apiUrl}/auth/login`,
      credentials,
      { headers, withCredentials: true }
    ).pipe(
      tap(response => {
        if (response.status === 'success' && response.user) {
          localStorage.setItem('currentUser', JSON.stringify(response.user));
          this.currentUserSubject.next(response.user);
        }
      }),
      catchError((error) => { throw error; })
    );
  }

  logout(): Observable<any> {
    const headers = new HttpHeaders({'Content-Type': 'application/json'});
    return this.http.post(
      `${environment.apiUrl}/auth/logout`, {},
      { headers, withCredentials: true }
    ).pipe(
      tap(() => { this.clearAuthData(); }),
      catchError(() => { this.clearAuthData(); return of(null); })
    );
  }

  clearAuthData(): void {
    localStorage.removeItem('currentUser');
    this.currentUserSubject.next(null);
    this.router.navigate(['/auth/login']);
  }
}
