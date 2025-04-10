# Projet 2048 en C++ avec Qt et QML

## Auteurs
- *Anas Tber*: anas.tber@etu.ec-lyon.fr
- *David Wagner* david.wagner@etu.ec-lyon.fr

## Description
Ce projet est une réplique du jeu 2048 développée en *C++* avec *Qt* et *QML*. L'objectif est de reproduire fidèlement le gameplay du jeu original, sans la publicité, et avec des fonctionnalités supplémentaires pour améliorer l'expérience utilisateur. Une vidéo tuto intitulée "2048 tuto" ainsi que des captures d'écran du jeu sont disponibles dans le dossier "Démo" du répo Git.

## Règles du jeu
Le jeu se joue exclusivement avec les *4 flèches directionnelles* :
- Appuyer sur une flèche déplace toutes les tesselles dans la direction choisie.
- Deux tesselles de même valeur fusionnent lorsqu'elles se rencontrent, formant une nouvelle tesselle avec la somme de leurs valeurs (ex: 2+2=4, 4+4=8, etc.).
- Une nouvelle tesselle apparaît aléatoirement sur une case vide après chaque déplacement (valeur 2 dans la plupart des cas, parfois 4).
- La partie se termine lorsque la grille est pleine et qu'aucun mouvement ne permet de fusionner ou de libérer une case.

Le but est d'obtenir une tesselle avec la valeur *2048* (ou plus) avant que la grille ne soit bloquée.

## Fonctionnalités implémentées: 
- Jeu de base 2048 avec fusion de tuiles et apparition aléatoire de nouvelles tuiles
- Interface graphique intuitive avec QML
- Possibilité de choisir la taille de la grille (4x4, 5x5, 6x6, 7x7, 8x8)
- Système d'annulation (Undo)
- Personnalisation des couleurs (en cliquant sur le pixel d'une photo) et des polices
- Niveaux de difficulté ajustables (facile, moyen, difficile) modifiant la probabilité d'obtenir des tuiles de valeur 4
- Sauvegarde du meilleur score



## Structures de données principales

• DamierDyn :

Structure fondamentale qui gère un tableau dynamique 3D de pointeurs de Tile (Tile***)
Implémente une matrice redimensionnable avec allocation/désallocation dynamique
Inclut un constructeur de copie et un opérateur d'affectation pour la gestion d'états
Permet la manipulation des tuiles via des méthodes get, set, redim et del


stack<DamierDyn> :

Utilisé pour stocker l'historique des états du plateau
Implémente les fonctionnalités undo/redo en gardant trace des modifications


stack<int> :

Utilisé dans Game pour stocker l'historique des scores
Synchronisé avec les états du plateau pour assurer la cohérence lors des undo/redo


## Rôle de chaque classe

• Tile :

Encapsule les données d'une tuile individuelle: valeur, position (row, col), état de fusion
Fournit des accesseurs et mutateurs pour modifier l'état
Inclut un opérateur d'affectation pour copier les propriétés entre tuiles


• Board :

Contient la grille de jeu (DamierDyn m_grid)
Gère tous les mouvements de tuiles (moveUp, moveDown, moveLeft, moveRight)
Implémente la logique de fusion des tuiles et détection des mouvements possibles
Ajoute des tuiles aléatoires avec la probabilité basée sur le niveau de difficulté
Gère l'historique des états du plateau pour undo/redo


• BoardModel :

Adapte le modèle de données pour l'interface QML (hérite de QAbstractListModel)
Définit les rôles utilisés par QML pour accéder aux données (ValueRole, RowRole, ColRole)
Convertit la structure de grille 2D en liste 1D pour l'utilisation dans les vues QML
Implémente les méthodes requises par QAbstractListModel (rowCount, data, roleNames)


• Game :

Coordonne la logique générale du jeu et maintient l'état global
Gère le score actuel et le meilleur score, ainsi que leur historique
Détecte les conditions de victoire/défaite
Contrôle le niveau de difficulté
Implémente la sauvegarde/chargement de l'état du jeu via QSettings


• GameController :

Fait le pont entre l'interface utilisateur QML et la logique C++
Expose les propriétés et méthodes du jeu à QML via Q_PROPERTY et Q_INVOKABLE
Traduit les entrées utilisateur en actions dans le modèle
Émet des signaux pour notifier l'interface des changements d'état


• ColorPicker :

Classe utilitaire pour la personnalisation
Extrait la couleur d'un pixel dans une image pour la personnalisation


• Bouton (MenuButton) :

Composant d'interface personnalisé
Gère les interactions avec les boutons du menu


• Direction (enum) :

Définit les constantes pour les directions de mouvement (UP, RIGHT, DOWN, LEFT)
Normalise les types de mouvements dans le code



## Difficultés rencontrées
- Le passage d'une grille (tableau) dont la taille est définie statiquement à la grille comme instance de DamierDyn. Cela aurait pu être mieux anticipé ce qui aurait facilité l'implémentation de la fonctionnalité de changement de taille de la grille.
- Réussir à faire en sorte que QML trouve le chemin pour exécuter les ressources (qui était différent du chemin d'existence), en particulier la photo pour l'option de changement de couleur, grâce au dossier build.
- La fonctionnalité undo : penser à implémenter le constructeur de recopie de DamierDyn et surcharger l'opérateur = de Tile.
- Sauvegarde du meilleur score dans QSettings
- En général, l'utilisation de nouvelles bibliothèques QML a nécessité une documentation extérieure pour mieux les comprendre (QList, QImage, QDebug, QSettings, etc)



## Technologies utilisées
- *Langage* : C++
- *Framework* : Qt 
- *Interface* : QML pour l'affichage


## Compilation et exécution
### Prérequis
- *Qt Creator* installé avec Qt 6
- *Compilateur C++* compatible (GCC, Clang, MSVC...)




### Instructions
1. Cloner le dépôt du projet :
   
   git clone https://gitlab.ec-lyon.fr/atber/2048-c.git
   
2. Ouvrir le dossier "projet" dans *Qt Creator*.
3. Compiler et exécuter 



## Auteurs et crédits
Projet réalisé dans le cadre de l'électif C++ "Programmation des interfaces graphiques en C++", deuxième année du cursus ingénieur généraliste de Centrale Lyon.

Développé par :
- *Anas Tber*   anas.tber@etu.ec-lyon.fr
- *David Wagner*  david.wagner@etu.ec-lyon.fr




