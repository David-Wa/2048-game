#ifndef GAME_H
#define GAME_H



enum Direction { UP, RIGHT, DOWN, LEFT };

class Board;



class Game {
public:

    Game();
    ~Game();



    //Méthodes principales
    void newGame();
    void move(Direction direction);
    int  getScore();
    int  getBestScore();
    bool isGameOver();
    bool isGameWon();
    void saveGame();
    void loadGame();

    // Accesseur pour le plateau (pourrait être nécessaire pour BoardModel)
    Board* getBoard() const;

private:
    Board* m_board;
    int m_score;
    int m_bestscore;
    bool m_gameOver;
    bool m_gameWon;

};

#endif // GAME_H
