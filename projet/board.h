#ifndef BOARD_H
#define BOARD_H

#include "direction.h"
#include "tile.h"
#include <QList>
#include <QObject>
#include "damierdyn.h"

class Board : public QObject{
    Q_OBJECT
public:
    Board(QObject* parent = nullptr);
    ~Board();
    void initialize(int size);
    void addRandomTile();
    bool canMove();
    bool moveTiles(Direction direction);
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


    // Méthodes privées pour implémenter les mouvements
    void moveUp();
    void moveRight();
    void moveDown();
    void moveLeft();
};

#endif // BOARD_H
