#ifndef UNDO_H
#define UNDO_H

#include "tile.h"

class Undo
{
public:
    Undo();
    void store(int direction);
    void store_random(int a, int b);
    void store_merged(int a, int b, int c, int d);
    void pop_move(); //pop de la pile des directions
    void pop_merged();
    void pop_random();
private:

};

#endif // UNDO_H
