#include "board.h"
#include <QRandomGenerator>

Board::Board(QObject* parent)
    : QObject(parent)
    , m_size(SIZE)
    , m_changed(false)
{
    initialize();
}

Board::~Board()
{
    // Nettoyer les tuiles
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            delete m_grid[i][j];
        }
    }
}

void Board::initialize()
{
    // Initialiser toutes les tuiles avec des valeurs vides
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            m_grid[i][j] = new Tile();
            m_grid[i][j]->setPosition(i, j);
            m_grid[i][j]->setValue(0); // 0 représente une case vide
        }
    }

    m_changed = false;
}

void Board::addRandomTile()
{
    QList<Tile*> emptyTiles = getEmptyTiles();

    if (emptyTiles.isEmpty()) return;

    // Choisir une tuile vide aléatoire
    int index = QRandomGenerator::global()->bounded(emptyTiles.size());
    Tile* tile = emptyTiles[index];

    // 90% de chance d'avoir un 2, 10% de chance d'avoir un 4
    int value = (QRandomGenerator::global()->bounded(10) < 9) ? 2 : 4;

    tile->setValue(value);
    m_changed = true;
}

bool Board::canMove()
{
    // Vérifier s'il y a des cases vides
    if (!isFull()) return true;

    // Vérifier si des fusions sont possibles
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            int value = m_grid[i][j]->getValue();

            // Vérifier la tuile à droite
            if (j < m_size - 1 && value == m_grid[i][j+1]->getValue()) {
                return true;
            }

            // Vérifier la tuile en dessous
            if (i < m_size - 1 && value == m_grid[i+1][j]->getValue()) {
                return true;
            }
        }
    }

    return false;
}

bool Board::moveTiles(Direction direction)
{
    m_changed = false;

    // Réinitialiser l'état fusionné de toutes les tuiles
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            m_grid[i][j]->setMerged(false);
        }
    }

    // Déplacer les tuiles dans la direction spécifiée
    switch (direction) {
    case UP:
        moveUp();
        break;
    case RIGHT:
        moveRight();
        break;
    case DOWN:
        moveDown();
        break;
    case LEFT:
        moveLeft();
        break;
    }

    return m_changed;
}

void Board::moveUp()
{
    for (int j = 0; j < m_size; j++) {
        for (int i = 1; i < m_size; i++) {
            if (m_grid[i][j]->getValue() != 0) {
                int row = i;
                while (row > 0) {
                    Tile* current = m_grid[row][j];
                    Tile* target = m_grid[row-1][j];

                    if (target->getValue() == 0) {
                        // Déplacer vers la case vide
                        target->setValue(current->getValue());
                        current->setValue(0);
                        m_changed = true;
                        row--;
                    } else if (target->getValue() == current->getValue() && !target->isMerged()) {
                        // Fusionner avec la case de même valeur
                        int mergeValue = target->getValue() * 2;
                        target->setValue(mergeValue);
                        target->setMerged(true);
                        current->setValue(0);
                        m_changed = true;
                        emit tileMerged(mergeValue);
                        break;
                    } else {
                        break;
                    }
                }
            }
        }
    }
}

void Board::moveRight()
{
    for (int i = 0; i < m_size; i++) {
        for (int j = m_size - 2; j >= 0; j--) {
            if (m_grid[i][j]->getValue() != 0) {
                int col = j;
                while (col < m_size - 1) {
                    Tile* current = m_grid[i][col];
                    Tile* target = m_grid[i][col+1];

                    if (target->getValue() == 0) {
                        target->setValue(current->getValue());
                        current->setValue(0);
                        m_changed = true;
                        col++;
                    } else if (target->getValue() == current->getValue() && !target->isMerged()) {
                        int mergeValue = target->getValue() * 2;
                        target->setValue(mergeValue);
                        target->setMerged(true);
                        current->setValue(0);
                        m_changed = true;
                        emit tileMerged(mergeValue);
                        break;
                    } else {
                        break;
                    }
                }
            }
        }
    }
}

void Board::moveDown()
{
    for (int j = 0; j < m_size; j++) {
        for (int i = m_size - 2; i >= 0; i--) {
            if (m_grid[i][j]->getValue() != 0) {
                int row = i;
                while (row < m_size - 1) {
                    Tile* current = m_grid[row][j];
                    Tile* target = m_grid[row+1][j];

                    if (target->getValue() == 0) {
                        target->setValue(current->getValue());
                        current->setValue(0);
                        m_changed = true;
                        row++;
                    } else if (target->getValue() == current->getValue() && !target->isMerged()) {
                        int mergeValue = target->getValue() * 2;
                        target->setValue(mergeValue);
                        target->setMerged(true);
                        current->setValue(0);
                        m_changed = true;
                        emit tileMerged(mergeValue);
                        break;
                    } else {
                        break;
                    }
                }
            }
        }
    }
}

void Board::moveLeft()
{
    for (int i = 0; i < m_size; i++) {
        for (int j = 1; j < m_size; j++) {
            if (m_grid[i][j]->getValue() != 0) {
                int col = j;
                while (col > 0) {
                    Tile* current = m_grid[i][col];
                    Tile* target = m_grid[i][col-1];

                    if (target->getValue() == 0) {
                        target->setValue(current->getValue());
                        current->setValue(0);
                        m_changed = true;
                        col--;
                    } else if (target->getValue() == current->getValue() && !target->isMerged()) {
                        int mergeValue = target->getValue() * 2;
                        target->setValue(mergeValue);
                        target->setMerged(true);
                        current->setValue(0);
                        m_changed = true;
                        emit tileMerged(mergeValue);
                        break;
                    } else {
                        break;
                    }
                }
            }
        }
    }
}

bool Board::isFull()
{
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            if (m_grid[i][j]->getValue() == 0) {
                return false;
            }
        }
    }
    return true;
}

bool Board::contains2048()
{
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            if (m_grid[i][j]->getValue() == 2048) {
                return true;
            }
        }
    }
    return false;
}

Tile* Board::getTileAt(int row, int col) const
{
    if (row >= 0 && row < m_size && col >= 0 && col < m_size) {
        return m_grid[row][col];
    }
    return nullptr;
}

QList<Tile*> Board::getEmptyTiles() const
{
    QList<Tile*> emptyTiles;

    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            if (m_grid[i][j]->getValue() == 0) {
                emptyTiles.append(m_grid[i][j]);
            }
        }
    }

    return emptyTiles;
}
