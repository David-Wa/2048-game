#ifndef BOARD_H
#define BOARD_H

#include "direction.h"
#include "tile.h"
#include <QList>
#include <QObject>
#include "damierdyn.h"
#include "undo.h"

class Board : public QObject{
    Q_OBJECT
public:
    Board(QObject* parent = nullptr);
    ~Board();
    void initialize(int size);
    void addRandomTile();
    void delRandomTile();
    bool canMove();
    bool moveTiles(Direction direction);
    bool invmoveTiles(Direction direction);
    bool isFull();
    bool contains2048();
    void setSize(int newsize);
    Tile* getTileAt(int row, int col) const;
    QList<Tile*> getEmptyTiles() const;
signals:
    void tileMerged(int value);

private:
   // Tile* m_grid[SIZE][SIZE];
    DamierDyn m_grid;
    int m_size;
    bool m_changed;
    Undo undo;

    // Méthodes privées pour implémenter les mouvements
    void moveUp();
    void moveRight();
    void moveDown();
    void moveLeft();
    void invmoveUp();
    void invmoveRight();
    void invmoveDown();
    void invmoveLeft();
};

#endif // BOARD_H
