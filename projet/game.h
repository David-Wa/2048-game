#ifndef GAME_H
#define GAME_H

#include "direction.h"
#include <QObject>
#include <stack>

using namespace std;

// Déclaration anticipée
class Board;

class Game: public QObject {
    Q_OBJECT
public:
    Game(QObject* parent = nullptr);
    ~Game();

    void newGame(int size);
    void move(Direction direction);
    int getScore() const;
    int getBestScore() const;
    bool isGameOver() const;
    bool isGameWon() const;
    void saveGame();
    void loadGame();
    void undo();
    void reset_undo();

    // Accesseur pour le plateau
    Board* getBoard() const;

public slots:
    // Méthode pour incrémenter le score
    void addScore(int points);

    // Méthode pour mettre à jour le score en fonction de l'état du plateau
    //void updateScore();
    void setSize(int newsize);

private:
    Board* m_board;
    int m_score;
    int m_bestScore;
    bool m_gameOver;
    bool m_gameWon;
    int m_size;
    stack<int> list_score;
};

#endif // GAME_H
