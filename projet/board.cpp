#include "board.h"
#include <QRandomGenerator>

Board::Board(QObject* parent)
    : QObject(parent)
    , m_size(SIZE)
    , m_changed(false)
    , m_grid(SIZE,SIZE)
    , m_difficultyLevel(1)


{   m_grid.init();
    initialize(m_size);
}

void Board::setSize(int newsize)
{ if (newsize!=m_size) {
    m_size=newsize;
        m_grid.redim(m_size,m_size);
    }
}

Board::~Board()
{
    // Nettoyer les tuiles
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            m_grid.del(i,j);
        }
    }
}

void Board::update_undo()
{
    // Créer une copie profonde de m_grid
    DamierDyn gridCopy = m_grid;  // Utilise le constructeur de copie
    list_m_grid.push(gridCopy);
}


void Board::initialize(int size)
{   if (m_size!=size){
        setSize(size);}
    // Initialiser toutes les tuiles avec des valeurs vides
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            m_grid.get(i,j)->setPosition(i, j);
            m_grid.get(i,j)->setValue(0); // 0 représente une case vide
        }
    }
    reset_undo();
    reset_redo();
    m_changed = false;
}



void Board::addRandomTile()
{
    QList<Tile*> emptyTiles = getEmptyTiles();

    if (emptyTiles.isEmpty()) return;

    // Choisir une tuile vide aléatoire
    int index = QRandomGenerator::global()->bounded(emptyTiles.size());
    Tile* tile = emptyTiles[index];

    // Probabilité d'obtenir un 4 selon le niveau de difficulté
    int fourProbability;
    switch(m_difficultyLevel) {
    case 1: // Facile
        fourProbability = 10; // 10% de chances d'avoir un 4
        break;
    case 2: // Moyen
        fourProbability = 25; // 25% de chances d'avoir un 4
        break;
    case 3: // Difficile
        fourProbability = 40; // 40% de chances d'avoir un 4
        break;
    default:
        fourProbability = 10; // Par défaut (facile)
    }

    // Générer un 2 ou un 4 selon la probabilité déterminée
    int value = (QRandomGenerator::global()->bounded(100) < fourProbability) ? 4 : 2;

    tile->setValue(value);

    //stocker la grille pour un retour arrière
    m_changed = true;
}


bool Board::canMove()
{
    // Vérifier s'il y a des cases vides
    if (!isFull()) return true;

    // Vérifier si des fusions sont possibles
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            int value = m_grid.get(i,j)->getValue();

            // Vérifier la tuile à droite
            if (j < m_size - 1 && value == m_grid.get(i,j+1)->getValue()) {
                return true;
            }

            // Vérifier la tuile en dessous
            if (i < m_size - 1 && value == m_grid.get(i+1,j)->getValue()) {
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
            m_grid.get(i,j)->setMerged(false);
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
            if (m_grid.get(i,j)->getValue() != 0) {
                int row = i;
                while (row > 0) {
                    Tile* current = m_grid.get(row,j);
                    Tile* target = m_grid.get(row-1,j);

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
            if (m_grid.get(i,j)->getValue() != 0) {
                int col = j;
                while (col < m_size - 1) {
                    Tile* current = m_grid.get(i,col);
                    Tile* target = m_grid.get(i,col+1);

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
            if (m_grid.get(i,j)->getValue() != 0) {
                int row = i;
                while (row < m_size - 1) {
                    Tile* current = m_grid.get(row,j);
                    Tile* target = m_grid.get(row+1,j);

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
            if (m_grid.get(i,j)->getValue() != 0) {
                int col = j;
                while (col > 0) {
                    Tile* current = m_grid.get(i,col);
                    Tile* target = m_grid.get(i,col-1);

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


void Board::setDifficultyLevel(int level)
{
    if (level >= 1 && level <= 3) {
        m_difficultyLevel = level;
    }
}


bool Board::isFull()
{
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            if (m_grid.get(i,j)->getValue() == 0) {
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
            if (m_grid.get(i,j)->getValue() == 2048) {
                return true;
            }
        }
    }
    return false;
}

Tile* Board::getTileAt(int row, int col) const
{
    if (row >= 0 && row < m_size && col >= 0 && col < m_size) {
        return m_grid.get(row,col);
    }
    return nullptr;
}

QList<Tile*> Board::getEmptyTiles() const
{
    QList<Tile*> emptyTiles;

    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            if (m_grid.get(i,j)->getValue() == 0) {
                emptyTiles.append(m_grid.get(i,j));
            }
        }
    }

    return emptyTiles;
}

void Board::undo()
{
    if(list_m_grid.size() > 1){
        // Assurons-nous que top() est valide avant d'y accéder
        DamierDyn topGrid = list_m_grid.top();
        list_m_grid.pop();
        m_grid_redo.push(topGrid);
        // Copier l'état précédent du jeu
        m_grid = list_m_grid.top();
    }
}

void Board::reset_undo()
{ while(!list_m_grid.empty()){
        list_m_grid.pop();
}
}

void Board::redo()
    {
        if(m_grid_redo.size() > 1){
            // Assurons-nous que top() est valide avant d'y accéder
            DamierDyn topGrid = m_grid_redo.top();
            m_grid_redo.pop();
            list_m_grid.push(topGrid);
            // Copier l'état précédent du jeu
            m_grid = m_grid_redo.top();
        }
}

void Board::reset_redo(){
    { while(!m_grid_redo.empty()){
            m_grid_redo.pop();
        }
    }}
