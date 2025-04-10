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
    DamierDyn(int a=SIZE,int b=SIZE);
    ~DamierDyn();
    void init();
    void redim(int a,int b);
    void del(int a,int b);
    void Free();
    void Alloc(int l, int c);
    DamierDyn(const DamierDyn& other);
    DamierDyn& operator=(const DamierDyn& other);
} ;




#endif // DAMIERDYN_H
