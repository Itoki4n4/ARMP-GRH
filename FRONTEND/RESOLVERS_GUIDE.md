# Guide d'utilisation des Resolvers Angular

## 📋 Résumé

Des resolvers ont été créés pour toutes les pages de liste afin de précharger les données avant l'activation de la route. Cela améliore les performances et l'expérience utilisateur.

## ✅ Resolvers créés

1. **EmployeResolver** - `/employes/lister`
2. **AffectationResolver** - `/affectations`
3. **StagiaireResolver** - `/stagiaires`
4. **StageResolver** - `/stages`
5. **CompetenceResolver** - `/competences`
6. **EtablissementResolver** - `/etablissements`
7. **PostesResolver** - `/postes/lister` (déjà existant)

## 🔧 Comment utiliser les données résolues dans les composants

### Exemple : ListerEmployesComponent

**Avant (sans resolver) :**
```typescript
ngOnInit(): void {
  this.loadEmployes();
}

loadEmployes() {
  this.employeService.list().subscribe(employes => {
    this.employes = employes;
  });
}
```

**Après (avec resolver) :**
```typescript
import { ActivatedRoute } from '@angular/router';

constructor(
  private route: ActivatedRoute,
  // ... autres services
) {}

ngOnInit(): void {
  // Récupérer les données préchargées depuis le resolver
  const resolvedData = this.route.snapshot.data;
  if (resolvedData['employes']) {
    this.employes = resolvedData['employes'];
  }
  
  // OU utiliser l'observable pour les mises à jour
  this.route.data.subscribe(data => {
    if (data['employes']) {
      this.employes = data['employes'];
    }
  });
}
```

### Exemple : ListerAffectationsComponent

```typescript
import { ActivatedRoute } from '@angular/router';

constructor(
  private route: ActivatedRoute,
  // ... autres services
) {}

ngOnInit(): void {
  // Les affectations sont déjà chargées par le resolver
  const resolvedData = this.route.snapshot.data;
  if (resolvedData['affectations']) {
    this.affectations = resolvedData['affectations'];
  }
}
```

## 📝 Filtres et Query Params

Les resolvers récupèrent automatiquement les filtres depuis les query params de l'URL.

**Exemple d'URL avec filtres :**
```
/employes/lister?srvc_code=1&statut=actif&q=dupont
```

Le resolver `EmployeResolver` récupérera automatiquement ces paramètres et les passera au service.

## 🔄 Rechargement des données

Si vous devez recharger les données après une action (création, modification, suppression), vous pouvez :

1. **Recharger manuellement** :
```typescript
this.employeService.list(filters).subscribe(employes => {
  this.employes = employes;
});
```

2. **Naviguer avec les mêmes query params** :
```typescript
this.router.navigate(['/employes/lister'], { 
  queryParams: this.currentFilters 
});
```

## ⚠️ Notes importantes

1. **Dashboard (Home)** : N'utilise pas de resolver car les filtres changent dynamiquement via l'interface utilisateur.

2. **Query Params** : Les resolvers lisent les query params au moment de la résolution. Si vous changez les filtres dans le composant, vous devrez recharger manuellement ou naviguer avec les nouveaux params.

3. **Performance** : Les resolvers bloquent la navigation jusqu'à ce que les données soient chargées. Cela garantit que les données sont disponibles immédiatement lors de l'affichage du composant.

## 📂 Structure des fichiers

```
FRONTEND/src/app/module/
├── employe/
│   └── resolver/
│       └── employe.resolver.ts
├── affectation/
│   └── resolver/
│       └── affectation.resolver.ts
├── stagiaire/
│   └── resolver/
│       └── stagiaire.resolver.ts
├── stage/
│   └── resolver/
│       └── stage.resolver.ts
├── competence/
│   └── resolver/
│       └── competence.resolver.ts
├── etablissement/
│   └── resolver/
│       └── etablissement.resolver.ts
└── poste/
    └── resolver/
        └── poste-resolver.ts (existant)
```

## 🚀 Prochaines étapes

Pour chaque composant de liste, vous devez :

1. ✅ Importer `ActivatedRoute` depuis `@angular/router`
2. ✅ Récupérer les données depuis `route.snapshot.data` ou `route.data`
3. ✅ Supprimer les appels API dans `ngOnInit()` pour les données résolues
4. ✅ Garder les appels API pour les rechargements manuels après actions CRUD

