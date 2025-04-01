#include "damierdyn.h"
#include "tile.h"

DamierDyn::DamierDyn(int a,int b) {
    nb_lignes=a;
    nb_colonnes=b;
    int i;
    tab=new Tile**[a];
    for(i=0;i<a;i++)
    {tab[i]= new Tile*[b];}
}

void DamierDyn::init() {
    int i,j;
    for (i=0;i<nb_lignes;i++)
    {
        for (j=0;j<nb_colonnes;j++)
        {
            tab[i][j]=new Tile();      }
    }
}


Tile* DamierDyn::get(int a,int b) const

{
    return tab[a][b];
}

void DamierDyn::set(int a, int b, Tile* val) {
            tab[a][b] = val;
}

void DamierDyn::redim(int a, int b) {
    nb_lignes=a;nb_colonnes=b;
    tab=new Tile**[nb_lignes];
    int i;
    for(i=0;i<nb_lignes;i++)
    {
        tab[i]=new Tile*[nb_colonnes];
        int j;
        for(j=0;j<nb_colonnes;j++)
        {
            tab[i][j]=new Tile();
        }
    }

}

DamierDyn::~DamierDyn() {delete[] tab;}





void DamierDyn::del(int a, int b) {
    // Vérifier si l'élément à l'indice donné est valide
    if (tab[a][b] != nullptr) {
        delete tab[a][b];  // Libérer la mémoire de la case
        tab[a][b] = nullptr;  // Prévenir les accès ultérieurs à cet emplacement
    } else {
        std::cerr << "Erreur : Tentative de suppression d'un pointeur nul !" << std::endl;
    }
}
