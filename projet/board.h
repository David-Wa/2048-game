#ifndef BOARD_H
#define BOARD_H

#include "direction.h"
#include "tile.h"
#include <QList>
#include <QObject>
#include "damierdyn.h"
#include <stack>

class Board : public QObject{
    Q_OBJECT
public:
    Board(QObject* parent = nullptr);
    ~Board();
    void initialize(int size);
    void addRandomTile();
    bool canMove();
    bool moveTiles(Direction direction);
    bool invmoveTiles(Direction direction);
    bool isFull();
    bool contains2048();
    void setSize(int newsize);
    void setDifficultyLevel(int level);
    Tile* getTileAt(int row, int col) const;
    QList<Tile*> getEmptyTiles() const;
    void undo();
    void redo();
    void reset_undo();
    void reset_redo();
    void update_undo();
signals:
    void tileMerged(int value);

private:
   // Tile* m_grid[SIZE][SIZE];
    DamierDyn m_grid;
    int m_size;
    bool m_changed;
    int m_difficultyLevel;  // 1=facile, 2=moyen, 3=difficile
    stack<DamierDyn> list_m_grid;
    stack<DamierDyn> m_grid_redo;

    // Méthodes privées pour implémenter les mouvements
    void moveUp();
    void moveRight();
    void moveDown();
    void moveLeft();
};

#endif // BOARD_H
