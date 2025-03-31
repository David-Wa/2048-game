#include "boardmodel.h"
#include "board.h"
#include "tile.h"

BoardModel::BoardModel(QObject* parent, Board* board)
    : QAbstractListModel(parent)
    , m_board(board)
    , m_size(SIZE)
    , m_changed(false)
{
    // Initialiser la grille du modèle
    for (int i = 0; i < m_size; i++) {
        for (int j = 0; j < m_size; j++) {
            m_grid[i][j] = nullptr;
        }
    }

    refresh();
}

BoardModel::~BoardModel()
{

}

int BoardModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return SIZE * SIZE; // Taille totale de la grille
}

QVariant BoardModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    int row = index.row() / SIZE;
    int col = index.row() % SIZE;

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
                m_grid[i][j] = m_board->getTileAt(i, j);
            } else {
                m_grid[i][j] = nullptr;
            }
        }
    }
    endResetModel();

    m_changed = true;
}

void BoardModel::refresh()
{
    // Mettre à jour le modèle à partir du plateau
    beginResetModel();
    if (m_board) {
        for (int i = 0; i < m_size; i++) {
            for (int j = 0; j < m_size; j++) {
                m_grid[i][j] = m_board->getTileAt(i, j);
            }
        }
    }
    endResetModel();
}

Tile* BoardModel::getTileAt(int row, int col) const
{
    if (row >= 0 && row < m_size && col >= 0 && col < m_size) {
        return m_grid[row][col];
    }
    return nullptr;
}
