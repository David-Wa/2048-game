#ifndef BOARDMODEL_H
#define BOARDMODEL_H


#include <QObject>
#include <QList>


class Tile;
class Board;


const int SIZE = 4;
enum Direction { UP, RIGHT, DOWN, LEFT };




class BoardModel : public QObject{
    Q_OBJECT


public:

    //Constructeur et destructeur

    explicit BoardModel(QObject* parent = nullptr, Board* board = nullptr);
    ~BoardModel();


    //Méthodes principales
    void initialize();
    void addRandomTile();
    bool canMove();
    bool moveTiles(Direction direction);
    bool isFull();
    bool contains2048();
    Tile* getTileAt(int row, int col);
    QList<Tile*> getEmptyTiles();

    void refresh();

private:
    Tile* m_grid[SIZE][SIZE];
    int m_size;
    bool m_changed;
    Board* m_board;
};


#endif // BOARDMODEL_H
