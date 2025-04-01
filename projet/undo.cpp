#include "undo.h"

Undo::Undo() {}

void Undo::store(int direction){}

void Undo::store_random(int a, int b) {}

void Undo::store_merged(int a, int b, int c, int d){} //current puis target

void Undo::pop_merged() {}

void Undo::pop_move() {}

void Undo::pop_random() {}
