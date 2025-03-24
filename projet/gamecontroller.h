#ifndef GAMECONTROLLER_H
#define GAMECONTROLLER_H
#include <QObject>
#include <QString>

// Définition des constantes et types
const int SIZE = 4; // Taille du plateau
enum Direction { UP, RIGHT, DOWN, LEFT };


class Game;
class BoardModel;
class Board;
class Tile;


class GameController: public QObject{
    Q_OBJECT
    Q_PROPERTY(QString cptQML READ readCompteur NOTIFY cptChanged)

public:
    explicit GameController(QObject* parent = nullptr);
    ~GameController();

    // Accesseurs pour les propriétés Qt
    BoardModel* boardModel() const { return m_boardModel; }



    // Méthodes invocables depuis QML
    Q_INVOKABLE void newGame();
    Q_INVOKABLE void move(int direction);
    Q_INVOKABLE int getScore();
    Q_INVOKABLE int getBestScore();
    Q_INVOKABLE bool isGameOver();
    Q_INVOKABLE bool isGameWon();
    Q_INVOKABLE void saveGame();
    Q_INVOKABLE void loadGame();



signals:
    void boardModelChanged();
    void scoreChanged();
    void gameOverChanged();
    void gameWonChanged();


private:
Game* m_game;
BoardModel* m_boardModel;

};

#endif // GAMECONTROLLER_H
