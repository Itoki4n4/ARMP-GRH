import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Router, NavigationEnd } from '@angular/router';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';
import { MatBadgeModule } from '@angular/material/badge';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatMenuModule } from '@angular/material/menu';
import { MatDividerModule } from '@angular/material/divider';
import { MatRippleModule } from '@angular/material/core';
import { AuthService } from '../../module/auth/service/auth-service';
import { Observable, filter } from 'rxjs';
import { trigger, state, style, transition, animate } from '@angular/animations';

interface MenuItem {
    label: string;
    icon: string;
    route?: string;
    badge?: number;
    children?: MenuItem[];
    expanded?: boolean;
}

@Component({
    selector: 'app-layout',
    standalone: true,
    imports: [
        CommonModule,
        RouterModule,
        MatSidenavModule,
        MatListModule,
        MatIconModule,
        MatToolbarModule,
        MatButtonModule,
        MatBadgeModule,
        MatTooltipModule,
        MatMenuModule,
        MatDividerModule,
        MatRippleModule
    ],
    templateUrl: './layout.component.html',
    styleUrls: ['./layout.component.scss'],
    animations: [
        trigger('slideInOut', [
            transition(':enter', [
                style({ height: 0, opacity: 0, overflow: 'hidden' }),
                animate('300ms cubic-bezier(0.4, 0, 0.2, 1)', style({ height: '*', opacity: 1 }))
            ]),
            transition(':leave', [
                style({ overflow: 'hidden' }),
                animate('300ms cubic-bezier(0.4, 0, 0.2, 1)', style({ height: 0, opacity: 0 }))
            ])
        ]),
        trigger('rotateIcon', [
            state('collapsed', style({ transform: 'rotate(0deg)' })),
            state('expanded', style({ transform: 'rotate(180deg)' })),
            transition('collapsed <=> expanded', animate('300ms cubic-bezier(0.4, 0, 0.2, 1)'))
        ])
    ]
})
export class LayoutComponent {
    breadcrumbs: { label: string; route?: string }[] = [];
    menuItems: MenuItem[] = [
        { label: 'Tableau de bord', icon: 'dashboard', route: '/home' },
        {
            label: 'Employés',
            icon: 'people',
            expanded: false,
            children: [
                { label: 'Créer', icon: 'person_add', route: '/employes/creer' },
                { label: 'Lister', icon: 'list', route: '/employes/lister' }
            ]
        },

        { label: 'Liste des postes', icon: 'work', route: '/postes/lister' },
        {
            label: 'Affectations',
            icon: 'assignment',
            expanded: false,
            children: [
                { label: 'Nouvelle Affectation', icon: 'add_circle', route: '/affectations/creer' },
                { label: 'Historique', icon: 'history', route: '/affectations' }
            ]
        },
        {
            label: 'Stages',
            icon: 'school',
            expanded: false,
            children: [
                { label: 'Stages', icon: 'event', route: '/stages' },
                { label: 'Stagiaires', icon: 'person', route: '/stagiaires' }
            ]
        },
        {
            label: 'Compétences',
            icon: 'psychology',
            expanded: false,
            children: [
                { label: 'Créer', icon: 'add_circle', route: '/competences/creer' },
                { label: 'Lister', icon: 'list', route: '/competences' }
            ]
        },
        {
            label: 'Demande de document',
            icon: 'description',
            expanded: false,
            children: [
                { label: 'Faire une demande', icon: 'add', route: '/documents/demande' },
                { label: 'Liste des demandes', icon: 'list', route: '/documents/demandes' }
            ]
        }
    ];

    currentUser$: Observable<any>;
    sidebarCollapsed = false;

    constructor(
        private authService: AuthService,
        private router: Router
    ) {
        this.currentUser$ = this.authService.currentUser$;

        // Auto-expand menu items si une route enfant est active et mettre à jour les breadcrumbs
        this.router.events.pipe(
            filter(event => event instanceof NavigationEnd)
        ).subscribe(() => {
            this.updateActiveStates();
            this.updateBreadcrumbs();
        });

        // Init breadcrumbs
        this.updateBreadcrumbs();
    }

    private updateBreadcrumbs(): void {
        const urlSegments = this.router.url.split('/').filter(s => s && !s.includes('?'));
        const breadcrumbs: { label: string; route?: string }[] = [];
        let currentPath = '';

        // Accueil toujours en premier
        breadcrumbs.push({ label: 'Accueil', route: '/home' });

        urlSegments.forEach((segment, index) => {
            currentPath += `/${segment}`;

            // On ignore le /home s'il est déjà là via segment
            if (segment === 'home') return;

            // Spécifique pour établissements -> Accueil > Stages > Etablissements
            if (segment === 'etablissements' && index === 0) {
                breadcrumbs.push({ label: 'Stages', route: '/stages' });
            }

            let label = this.getLabelForRoute(currentPath) || this.capitalize(segment);

            // Si c'est un ID (par exemple EMP001), on peut le laisser tel quel ou le préfixer
            if (segment.startsWith('EMP') || (!isNaN(Number(segment)) && segment.length > 2)) {
                label = segment;
            }

            breadcrumbs.push({
                label: label,
                route: index === urlSegments.length - 1 ? undefined : currentPath
            });
        });

        this.breadcrumbs = breadcrumbs;
    }

    private getLabelForRoute(route: string): string | null {
        for (const item of this.menuItems) {
            if (item.route === route) return item.label;
            if (item.children) {
                const child = item.children.find(c => c.route === route);
                if (child) return child.label;
            }
        }
        return null;
    }

    private capitalize(s: string): string {
        return s.charAt(0).toUpperCase() + s.slice(1);
    }

    logout(): void {
        this.authService.logout().subscribe({
            next: () => {
                this.router.navigate(['/auth/login']);
            },
            error: (err: any) => {
                console.error('Erreur lors de la déconnexion:', err);
                this.router.navigate(['/auth/login']);
            }
        });
    }

    isActiveRoute(route: string): boolean {
        return this.router.url === route;
    }

    toggleMenu(item: MenuItem): void {
        if (item.children) {
            const isExpanding = !item.expanded;

            if (isExpanding) {
                // Fermer tous les autres menus pour l'effet "accordéon"
                this.menuItems.forEach(menu => {
                    if (menu.children && menu !== item) {
                        menu.expanded = false;
                    }
                });
            }

            item.expanded = isExpanding;
        }
    }

    isChildActive(item: MenuItem): boolean {
        if (!item.children) return false;
        return item.children.some(child => child.route && this.router.url.startsWith(child.route));
    }

    updateActiveStates(): void {
        this.menuItems.forEach(item => {
            if (item.children) {
                const hasActiveChild = this.isChildActive(item);
                if (hasActiveChild && !item.expanded) {
                    item.expanded = true;
                }
            }
        });
    }

    getIconState(item: MenuItem): string {
        return item.expanded ? 'expanded' : 'collapsed';
    }

    toggleSidebar(): void {
        this.sidebarCollapsed = !this.sidebarCollapsed;
    }
}
