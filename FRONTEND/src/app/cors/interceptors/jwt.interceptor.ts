import { HttpInterceptorFn, HttpErrorResponse } from '@angular/common/http';
import { inject } from '@angular/core';
import { Router } from '@angular/router';
import { catchError, throwError } from 'rxjs';
import { AuthService } from '../../module/auth/service/auth-service';

export const jwtInterceptor: HttpInterceptorFn = (req, next) => {
  const router = inject(Router);
  const authService = inject(AuthService);
  
  // Le cookie est automatiquement envoyé par le navigateur
  // On s'assure juste que les cookies sont envoyés
  const clonedRequest = req.clone({
    withCredentials: true  // Envoie automatiquement les cookies
  });

  console.log('Requête avec cookies:', clonedRequest.url);

  return next(clonedRequest).pipe(
    catchError((error: HttpErrorResponse) => {
      // Si le token est expiré ou invalide (erreur 401)
      if (error.status === 401) {
        console.warn('⚠️ Token expiré ou invalide, déconnexion automatique');
        
        // Éviter les boucles infinies : ne pas intercepter les erreurs du logout
        if (req.url.includes('/auth/logout')) {
          return throwError(() => error);
        }
        
        // Déconnecter l'utilisateur et rediriger vers le login
        authService.logout().subscribe({
          next: () => {
            console.log('✅ Déconnexion effectuée, redirection vers login');
          },
          error: () => {
            // Même en cas d'erreur, nettoyer et rediriger
            authService.clearAuthData();
          }
        });
      }
      
      // Propager l'erreur pour que les composants puissent la gérer si nécessaire
      return throwError(() => error);
    })
  );
};
