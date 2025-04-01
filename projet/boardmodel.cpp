#include "boardmodel.h"
#include "board.h"
#include "tile.h"


BoardModel::BoardModel(QObject* parent, Board* board)
    : QAbstractListModel(parent)
    , m_board(board)
    , m_size(SIZE)
    , m_changed(false)
    ,  m_grid(SIZE,SIZE)

{

    refresh(m_size);
}

void BoardModel::setSize(int newsize)
{   if (m_size!=newsize){
    m_size=newsize;
    m_grid.redim(m_size,m_size);
    m_board->setSize(newsize);}

}



BoardModel::~BoardModel()
{

}

int BoardModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_size * m_size; // Taille totale de la grille
}

QVariant BoardModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    int row = index.row() / m_size;
    int col = index.row() % m_size;

    Tile* tile = getTileAt(row, col);

    if (!tile)
        return QVariant();

    switch (role) {
    case ValueRole:
        return QVariant(tile->getValue());
    case RowRole:
        return QVariant(row);
    case ColRole:
        return QVariant(col);
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> BoardModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ValueRole] = "value";
    roles[RowRole] = "row";
    roles[ColRole] = "col";
    return roles;
}

int BoardModel::getTileValue(int row, int col) const
{
    Tile* tile = getTileAt(row, col);
    if (tile) {
        return tile->getValue();
    }
    return 0;
}

void BoardModel::initialize()
{
    // Réinitialiser le modèle
    beginResetModel();
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            if (m_board && m_board->getTileAt(i, j)) {
                m_grid.set(i,j,m_board->getTileAt(i, j));
            } else {
                m_grid.set(i,j, nullptr);
            }
        }
    }
    endResetModel();

    m_changed = true;
}

void BoardModel::refresh(int size)
{
    // Mettre à jour le modèle à partir du plateau
    beginResetModel();
    if (m_size!=size){
        setSize(size);}
    if (m_board) {
        for (int i = 0; i < m_size; i++) {
            for (int j = 0; j < m_size; j++) {
                m_grid.set(i,j, m_board->getTileAt(i, j));
            }
        }
    }
    endResetModel();
}

Tile* BoardModel::getTileAt(int row, int col) const
{
    if (row >= 0 && row < m_size && col >= 0 && col < m_size) {
        return m_grid.get(row,col);
    }
    return nullptr;
}
