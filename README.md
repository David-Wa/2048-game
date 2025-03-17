# Projet 2048 en C++ avec Qt et QML

## Auteurs
- **Anas Tber**: anas.tber@etu.ec-lyon.fr
- **David Wagner** david.wagner@etu.ec-lyon.fr

## Description
Ce projet est une réplique du jeu 2048 développée en **C++** avec **Qt** et **QML**. L'objectif est de reproduire fidèlement le gameplay du jeu original, sans la publicité, et avec des fonctionnalités supplémentaires pour améliorer l'expérience utilisateur.

## Règles du jeu
Le jeu se joue exclusivement avec les **4 flèches directionnelles** :
- Appuyer sur une flèche déplace toutes les tesselles dans la direction choisie.
- Deux tesselles de même valeur fusionnent lorsqu'elles se rencontrent, formant une nouvelle tesselle avec la somme de leurs valeurs (ex: 2+2=4, 4+4=8, etc.).
- Une nouvelle tesselle apparaît aléatoirement sur une case vide après chaque déplacement (valeur 2 dans la plupart des cas, parfois 4).
- La partie se termine lorsque la grille est pleine et qu'aucun mouvement ne permet de fusionner ou de libérer une case.

Le but est d'obtenir une tesselle avec la valeur **2048** (ou plus) avant que la grille ne soit bloquée.

## Fonctionnalités implémentées: 
(à definir)


## Extensions et améliorations
(à definir)

## Technologies utilisées
- **Langage** : C++
- **Framework** : Qt 
- **Interface** : QML pour l'affichage

## Compilation et exécution
### Prérequis
- **Qt Creator** installé avec Qt 6
- **Compilateur C++** compatible (GCC, Clang, MSVC...)

### Instructions
1. Cloner le dépôt du projet :
   ```bash
   git clone https://gitlab.ec-lyon.fr/atber/2048-c.git
   cd 2048-game
   ```
2. Ouvrir le projet dans **Qt Creator**.
3. Compiler et exécuter depuis l'IDE 

## Auteurs et crédits
Projet réalisé dans le cadre de l'électif C++ "Programmation des interfaces graphiques en C++"

Développé par :
- **Anas Tber**   anas.tber@etu.ec-lyon.fr
- **David Wagner** david.wagner@etu.ec-lyon.fr

