#ifndef GAMECONTROLLER_H
#define GAMECONTROLLER_H

#include <QObject>
#include "direction.h"


// Déclarations anticipées
class Game;
class BoardModel;

class GameController : public QObject {
    Q_OBJECT
    Q_PROPERTY(BoardModel* boardModel READ boardModel NOTIFY boardModelChanged)
    Q_PROPERTY(int score READ getScore NOTIFY scoreChanged)
    Q_PROPERTY(int bestScore READ getBestScore NOTIFY bestScoreChanged)
    Q_PROPERTY(bool gameOver READ isGameOver NOTIFY gameOverChanged)
    Q_PROPERTY(bool gameWon READ isGameWon NOTIFY gameWonChanged)
    Q_PROPERTY(int difficultyLevel READ getDifficultyLevel WRITE setDifficultyLevel NOTIFY difficultyLevelChanged)

public:
    explicit GameController(QObject* parent = nullptr);
    ~GameController();
       void setSize(int newsize);
    // Accesseur pour les propriétés Qt
    BoardModel* boardModel() const;

    // Méthodes invocables depuis QML
    Q_INVOKABLE void newGame(int size);
    Q_INVOKABLE void move(int direction);
    Q_INVOKABLE int getScore();
    Q_INVOKABLE int getBestScore();
    Q_INVOKABLE bool isGameOver();
    Q_INVOKABLE bool isGameWon();
    Q_INVOKABLE void saveGame();
    Q_INVOKABLE void loadGame();
    Q_INVOKABLE int getDifficultyLevel() const { return m_difficultyLevel; }
    Q_INVOKABLE void setDifficultyLevel(int level);
    Q_INVOKABLE void undo();
    Q_INVOKABLE void redo();

signals:
    void boardModelChanged();
    void scoreChanged();
    void bestScoreChanged();
    void gameOverChanged();
    void gameWonChanged();
    void difficultyLevelChanged();

private:
    Game* m_game;
    BoardModel* m_boardModel;
    int m_size;
    int m_difficultyLevel;
};

#endif // GAMECONTROLLER_H
