#ifndef DAMIERDYN_H
#define DAMIERDYN_H



#include <iostream>
using namespace std;
#include "tile.h"
#include "direction.h"

class DamierDyn {
private :
    Tile ***tab;
    int nb_lignes;
    int nb_colonnes;
public :
    void set(int a, int b, Tile* val);
    Tile* get(int a, int b) const;
    void print();
    DamierDyn(int a=SIZE,int b=SIZE);
    ~DamierDyn();
    void init();
    void redim(int a,int b);
    void del(int a,int b);
    DamierDyn& operator=(const DamierDyn &A);
    void Free();
    void Alloc(int l, int c);
    DamierDyn(const DamierDyn& other);
} ;


/*Exemple:

   DamierDyn D1(4,5);      // Création d'un tableau initialisé à la valeur 0
        D1.Init(7) ;
        D1.Set(2,4, -2);
        DamierDyn D2(D1);       // Constructeur de recopie
        D1.Redim(6,2);          // Redimensionnement de D1
        D2 = D1; */               // Redimensionnement de D2 (à l'image de D1)



#endif // DAMIERDYN_H
