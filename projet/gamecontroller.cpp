#include "gamecontroller.h"
#include "game.h"
#include "boardmodel.h"
#include "board.h"
#include <QDebug>

GameController::GameController(QObject* parent)
    : QObject(parent)
    , m_game(new Game())
    , m_boardModel(new BoardModel(this, m_game->getBoard()))
    , m_size(SIZE)
{
    qDebug() << "GameController créé";

    // Initialiser une nouvelle partie
    newGame(m_size);
}


void GameController::setSize(int newsize)
{    m_game->setSize(newsize);
    m_boardModel->setSize(newsize);
    m_size=newsize;
}


GameController::~GameController()
{
    delete m_game; // Si m_game n'a pas de parent Qt
}

BoardModel* GameController::boardModel() const
{
    return m_boardModel;
}

void GameController::newGame(int size)
{
    qDebug() << "GameController::newGame() - Démarrage d'une nouvelle partie";
    if (m_size!=size){
        setSize(size);}
    m_game->newGame(size);
    m_boardModel->refresh(size);

    emit scoreChanged();
    emit bestScoreChanged();
    emit gameOverChanged();
    emit gameWonChanged();
    emit boardModelChanged();

    // Afficher l'état initial du plateau pour débogage
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            int value = m_boardModel->getTileValue(i, j);
            if (value > 0) {
                qDebug() << "Tuile (" << i << "," << j << ") =" << value;
            }
        }
    }
}

void GameController::move(int direction)
{
    qDebug() << "GameController::move() - Direction:" << direction;

    // Convertir l'entier en Direction enum
    Direction dir;
    switch (direction) {
    case 0: dir = UP; qDebug() << "Direction: UP"; break;
    case 1: dir = RIGHT; qDebug() << "Direction: RIGHT"; break;
    case 2: dir = DOWN; qDebug() << "Direction: DOWN"; break;
    case 3: dir = LEFT; qDebug() << "Direction: LEFT"; break;
    default: qDebug() << "Direction invalide"; return;
    }

    // Effectuer le mouvement
    m_game->move(dir);

    // Mettre à jour le modèle
    m_boardModel->refresh(m_size);

    // Notifier les changements
    emit scoreChanged();
    emit bestScoreChanged();
    emit boardModelChanged();

    if (m_game->isGameOver()) {
        qDebug() << "GameController::move() - Jeu terminé";
        emit gameOverChanged();
    }

    if (m_game->isGameWon()) {
        qDebug() << "GameController::move() - Jeu gagné";
        emit gameWonChanged();
    }

    // Afficher l'état du plateau après le mouvement pour débogage
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            int value = m_boardModel->getTileValue(i, j);
            if (value > 0) {
                qDebug() << "Tuile (" << i << "," << j << ") =" << value;
            }
        }
    }
}

int GameController::getScore()
{
    return m_game->getScore();
}

int GameController::getBestScore()
{
    return m_game->getBestScore();
}

bool GameController::isGameOver()
{
    return m_game->isGameOver();
}

bool GameController::isGameWon()
{
    return m_game->isGameWon();
}

void GameController::saveGame()
{
    qDebug() << "GameController::saveGame() - Sauvegarde de la partie";
    m_game->saveGame();
}

void GameController::loadGame()
{
    qDebug() << "GameController::loadGame() - Chargement de la partie";
    m_game->loadGame();
    m_boardModel->refresh(m_size);

    emit scoreChanged();
    emit bestScoreChanged();
    emit gameOverChanged();
    emit gameWonChanged();
    emit boardModelChanged();
}
