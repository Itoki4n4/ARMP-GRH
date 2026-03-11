import { Injectable } from '@angular/core';
import { Resolve, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { DashboardService, DashboardStats } from '../service/dashboard.service';

@Injectable({ providedIn: 'root' })
export class DashboardResolver implements Resolve<DashboardStats> {
  constructor(private dashboardService: DashboardService) {}

  resolve(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<DashboardStats> {
    // Récupérer les filtres depuis les query params
    const filters: Record<string, any> = {};
    
    if (route.queryParams['srvc_code']) {
      filters['srvc_code'] = route.queryParams['srvc_code'];
    }
    if (route.queryParams['period']) {
      filters['period'] = route.queryParams['period'];
    } else {
      filters['period'] = 'year'; // Par défaut
    }

    return this.dashboardService.getStats(filters);
  }
}

