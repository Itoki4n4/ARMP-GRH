import { Routes } from '@angular/router';
import { authGuard } from './cors/guards/auth-guard';
import { LayoutComponent } from './shared/layout/layout.component';

export const routes: Routes = [
  // Redirection racine vers login
  {
    path: '',
    redirectTo: '/auth/login',
    pathMatch: 'full'
  },

  // Routes d'authentification (sans layout)
  {
    path: 'auth',
    loadChildren: () => import('./module/auth/auth.route').then(m => m.authRoutes)
  },

  // Routes avec layout (toutes les pages de l'application)
  {
    path: '',
    component: LayoutComponent,
    canActivate: [authGuard],
    children: [
      {
        path: 'home',
        loadComponent: () => import('./module/home/page/index').then(m => m.HomeComponent)
        // Note: Dashboard utilise des filtres dynamiques, donc pas de resolver
      },
      {
        path: 'postes',
        loadChildren: () => import('./module/poste/poste.route').then(m => m.posteRoutes)
      },
      {
        path: 'employes',
        loadChildren: () => import('./module/employe/employe.route').then(m => m.employeRoutes)
      },
      {
        path: 'directions',
        loadComponent: () => import('./module/home/page/index').then(m => m.HomeComponent) // TODO: Remplacer par DirectionsComponent
      },
      {
        path: 'affectations',
        loadChildren: () => import('./module/affectation/affectation.route').then(m => m.AFFECTATION_ROUTES)
      },
      {
        path: 'stagiaires',
        loadChildren: () => import('./module/stagiaire/stagiaire.route').then(m => m.STAGIAIRE_ROUTES)
      },
      {
        path: 'stages',
        loadChildren: () => import('./module/stage/stage.route').then(m => m.STAGE_ROUTES)
      },
      {
        path: 'etablissements',
        loadChildren: () => import('./module/etablissement/etablissement.route').then(m => m.ETABLISSEMENT_ROUTES)
      },
      {
        path: 'competences',
        loadChildren: () => import('./module/competence/competence.route').then(m => m.COMPETENCE_ROUTES)
      },
      {
        path: 'documents',
        loadChildren: () => import('./module/document/document.route').then(m => m.DOCUMENT_ROUTES)
      }
    ]
  },

  // Route 404
  {
    path: '**',
    redirectTo: '/home'
  }
];
