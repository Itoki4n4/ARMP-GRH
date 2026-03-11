import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';

export interface DashboardStats {
    kpi: {
        total_employes: number;
        total_postes: number;
        postes_vacants: number;
        taux_occupation: number;
        alertes_contrats: number;
    };
    charts: {
        contrats: { name: string; value: number }[];
        evolution: { month: string; count: number }[];
        ages: { name: string; value: number }[];
        sexe: { name: string; value: number }[];
    };
    lists: {
        fin_contrats: any[];
        dernieres_affectations: any[];
    };
}

@Injectable({
    providedIn: 'root'
})
export class DashboardService {
    private apiUrl = `${environment.apiUrl}/dashboard`;

    constructor(private http: HttpClient) { }

    getStats(filters?: any): Observable<DashboardStats> {
        return this.http.get<DashboardStats>(this.apiUrl, { params: filters });
    }
}
