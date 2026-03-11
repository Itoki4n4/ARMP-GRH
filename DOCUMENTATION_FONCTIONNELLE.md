# Documentation Fonctionnelle - Système d'Information SI-GRH (ARMP)

Ce document récapitule les fonctionnalités clés du système de gestion des ressources humaines, conçu avec une esthétique premium inspirée par ERPNext/HRMS.

php spark migrate:refresh
php spark migrate

## 1. Module : Gestion Administrative des Employés
*Ce module constitue le socle du système, permettant de gérer le cycle de vie administratif du personnel.*

*   **Annuaire du Personnel** :
    *   Tableau dynamique avec pagination et recherche intelligente.
    *   Filtres avancés par genre, statut et type de contrat.
    *   Exportation des données (en préparation).
*   **Onboarding / Création d'Employé** :
    *   Formulaire guidé (Stepper) pour une saisie structurée (Généralités, Coordonnées, Affectation initiale).
    *   Résumé de création interactif pour valider les données avant insertion.
*   **Fiche Profil 360°** :
    *   Design épuré type "Fiche de paie" avec sidebar de profil.
    *   Indicateur de statut (Actif, Retraité, Inactif).
    *   Affichage dynamique de l'année de départ à la retraite.
*   **Gestion des Compétences & Expertise** :
    *   Visualisation des compétences techniques avec jauges de niveau (sur 5).
    *   Classification par domaine d'expertise.
*   **Tableau de Bord RH (Dashboard)** :
    *   Statistiques en temps réel sur l'effectif total.
    *   Répartition par sexe et par typologie de contrat.

---

## 2. Module : Carrière & Mobilité
*Ce module gère l'évolution de l'employé au sein de l'organisation et son historique professionnel.*

*   **Parcours Professionnel (Timeline)** :
    *   Ligne du temps visuelle (Timeline) retraçant chaque étape de la carrière.
    *   Mise en évidence de l'affectation actuelle.
*   **Gestion des Affectations** :
    *   Mutation de poste ou transfert de service en quelques clics.
    *   Gestion des motifs d'affectation (Recrutement, Promotion, etc.).
    *   Suivi des rattachements hiérarchiques (Direction, Service).
*   **Référentiel des Contrats** :
    *   Gestion spécifique des types de contrats ARMP : **Fonctionnaire**, **EFA** (Emploi à durée indéterminée), **ELD** (Emploi à durée déterminée).
    *   Code couleur distinctif pour une identification visuelle rapide dans les listes.
*   **Gestion des Postes** :
    *   Catalogue des fonctions et missions associées à chaque poste de l'organisation.

---

## 3. Module : Gestion des Stages
*Ce module est dédié au suivi des stagiaires et de leur intégration temporaire.*

*   **Gestion des Stagiaires** :
    *   Base de données centralisée pour tous les stagiaires (académiques ou professionnels).
*   **Suivi des Stages** :
    *   Historique des périodes de stage passées et en cours.
    *   Affectation des stagiaires à des divisions ou services d'accueil spécifiques.
*   **Référentiel des Établissements** :
    *   Gestion de la liste des écoles, universités et centres de formation partenaires.

---

## 4. Fonctionnalités Transverses & Plateforme
*   **Gestion Documentaire** :
    *   Système de demande de documents administratifs (Attestations, certificats).
*   **Interface Premium (UX/UI)** :
    *   **Design HRMS** : Typographie "Inter", espacements aérés et couleurs professionnelles.
    *   **Sidebar Adaptative** : Menu rétractable avec mode icônes pour optimiser l'espace.
    *   **Navigation Intuitive** : Fil d'Ariane (Breadcrumbs) et en-tête fixe (Sticky Header).
*   **Sécurité & Accès** :
    *   Authentification sécurisée par jetons (JWT).
    *   Gestion des rôles utilisateurs (Admin, RH, Utilisateur).

---
*Dernière mise à jour : Janvier 2026*
