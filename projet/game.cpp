#include "game.h"
#include "board.h"
#include <QSettings>
#include <QDebug>

Game::Game(QObject* parent)
    : QObject(parent)
    , m_board(new Board(this))
    , m_score(0)
    , m_bestScore(0)
    , m_gameOver(false)
    , m_gameWon(false)
    ,m_size(SIZE)
{
    // Charger le meilleur score depuis les settings
    QSettings settings("YourCompany", "2048Game");
    m_bestScore = settings.value("bestScore", 0).toInt();

    // Connecter le signal de fusion de tuiles à l'ajout de score
    connect(m_board, &Board::tileMerged, this, &Game::addScore);
}

Game::~Game()
{
    delete m_board;
}

void Game::setSize(int newsize)
{
    m_size=newsize;
    m_board->setSize(newsize);
}



void Game::newGame(int size)
{
    qDebug() << "Game::newGame() - Démarrage d'une nouvelle partie";

    // Réinitialiser le jeu
    if (m_size!=size){
        setSize(size);}
    m_board->initialize(m_size);
    m_score = 0;
    undo_score_empty();
    redo_score_empty();
    list_score_undo.push(m_score);
    m_gameOver = false;
    m_gameWon = false;

    // Ajouter les deux premières tuiles
    m_board->addRandomTile();
    m_board->addRandomTile();
    m_board->update_undo();
}

void Game::move(Direction direction)
{
    if (m_gameOver) return;

    qDebug() << "Game::move() - Direction:" << direction;

    // Déplacer les tuiles dans la direction spécifiée
    bool moved = m_board->moveTiles(direction);

    if (moved) {
        qDebug() << "Game::move() - Mouvement effectué";

        // Ajouter une nouvelle tuile aléatoire
        m_board->addRandomTile();
        m_board->update_undo();
        m_board->reset_redo();
        list_score_undo.push(m_score);
        redo_score_empty();
        // Vérifier l'état du jeu
        if (m_board->contains2048()) {
            m_gameWon = true;
            qDebug() << "Game::move() - Jeu gagné!";
        }

        if (!m_board->canMove()) {
            m_gameOver = true;
            qDebug() << "Game::move() - Jeu terminé!";
        }
    } else {
        qDebug() << "Game::move() - Aucun mouvement possible dans cette direction";
    }
}


void Game::redo_score_empty(){
    while(!list_score_redo.empty())
    {list_score_redo.pop();}
}

void Game::undo_score_empty(){while(!list_score_undo.empty()){list_score_undo.pop();}}

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
    qDebug() << "Game::addScore() - Ajout de" << points << "points";

    m_score += points;
    qDebug() << "Game::addScore() - Nouveau score:" << m_score;

    // Mettre à jour le meilleur score si nécessaire
    if (m_score > m_bestScore) {
        m_bestScore = m_score;
        qDebug() << "Game::addScore() - Nouveau meilleur score:" << m_bestScore;

        // Sauvegarder le meilleur score
        QSettings settings("YourCompany", "2048Game");
        settings.setValue("bestScore", m_bestScore);
    }
}

void Game::saveGame()
{
    QSettings settings("YourCompany", "2048Game");
    settings.setValue("score", m_score);
    settings.setValue("bestScore", m_bestScore);

    // Sauvegarder l'état du plateau
    // Sauvegarder chaque tuile
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            Tile* tile = m_board->getTileAt(i, j);
            if (tile) {
                settings.setValue(QString("tile_%1_%2").arg(i).arg(j), tile->getValue());
            }
        }
    }

    settings.setValue("gameOver", m_gameOver);
    settings.setValue("gameWon", m_gameWon);
}

void Game::loadGame()
{
    QSettings settings("YourCompany", "2048Game");
    m_score = settings.value("score", 0).toInt();
    m_bestScore = settings.value("bestScore", 0).toInt();

    // Charger l'état du plateau
    // Réinitialiser d'abord le plateau
    m_board->initialize(m_size);

    // Charger chaque tuile
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            int value = settings.value(QString("tile_%1_%2").arg(i).arg(j), 0).toInt();
            Tile* tile = m_board->getTileAt(i, j);
            if (tile) {
                tile->setValue(value);
            }
        }
    }

    m_gameOver = settings.value("gameOver", false).toBool();
    m_gameWon = settings.value("gameWon", false).toBool();
}


void Game::undo()
{
    m_board->undo();
    if (list_score_undo.size()>1)
    {list_score_redo.push(m_score);
    list_score_undo.pop();
        m_score=list_score_undo.top();}
}


void Game::redo(){
    m_board->redo();
    if (list_score_redo.size()>1)
    {     list_score_undo.push(m_score);
        list_score_redo.pop();
        m_score=list_score_redo.top();}
}
