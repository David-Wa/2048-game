#include "game.h"
#include "board.h"
#include <QSettings>

Game::Game()
    : m_board(new Board())
    , m_score(0)
    , m_bestScore(0)
    , m_gameOver(false)
    , m_gameWon(false)
{
    // Charger le meilleur score depuis les settings
    QSettings settings("YourCompany", "2048Game");
    m_bestScore = settings.value("bestScore", 0).toInt();
}

Game::~Game()
{
    delete m_board;
}

void Game::newGame()
{
    // Réinitialiser le jeu
    m_board->initialize();
    m_score = 0;
    m_gameOver = false;
    m_gameWon = false;

    // Ajouter les deux premières tuiles
    m_board->addRandomTile();
    m_board->addRandomTile();
}

void Game::move(Direction direction)
{
    if (m_gameOver) return;

    // Déplacer les tuiles dans la direction spécifiée
    bool moved = m_board->moveTiles(direction);

    if (moved) {
        // Ajouter une nouvelle tuile aléatoire
        m_board->addRandomTile();

        // Vérifier l'état du jeu
        if (m_board->contains2048()) {
            m_gameWon = true;
        }

        if (!m_board->canMove()) {
            m_gameOver = true;
        }
    }
}

int Game::getScore() const
{
    return m_score;
}

int Game::getBestScore() const
{
    return m_bestScore;
}

bool Game::isGameOver() const
{
    return m_gameOver;
}

bool Game::isGameWon() const
{
    return m_gameWon;
}

Board* Game::getBoard() const
{
    return m_board;
}

void Game::addScore(int points)
{
    m_score += points;

    // Mettre à jour le meilleur score si nécessaire
    if (m_score > m_bestScore) {
        m_bestScore = m_score;
    }
}

void Game::saveGame()
{
    QSettings settings("YourCompany", "2048Game");
    settings.setValue("score", m_score);
    settings.setValue("bestScore", m_bestScore);

    // Sauvegarder l'état du plateau
    // Ceci est une simplification - vous devriez parcourir la grille
    // et sauvegarder chaque tuile dans un format approprié
}

void Game::loadGame()
{
    QSettings settings("YourCompany", "2048Game");
    m_score = settings.value("score", 0).toInt();
    m_bestScore = settings.value("bestScore", 0).toInt();

    // Charger l'état du plateau
    // Cette partie dépendrait de la façon dont vous avez sauvegardé le plateau
}
