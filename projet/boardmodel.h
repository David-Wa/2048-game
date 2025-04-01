#ifndef BOARDMODEL_H
#define BOARDMODEL_H

#include <QObject>
#include <QList>
#include <QAbstractListModel>
#include "direction.h"
#include "damierdyn.h"


// Déclarations anticipées
class Board;
class Tile;

class BoardModel : public QAbstractListModel {
    Q_OBJECT

public:
    // Définir les rôles pour QML
    enum TileRoles {
        ValueRole = Qt::UserRole + 1,
        RowRole,
        ColRole
    };

    explicit BoardModel(QObject* parent = nullptr, Board* board = nullptr);
    ~BoardModel();

    // Méthodes requises par QAbstractListModel
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    void initialize();
    void refresh();

    // Méthode accessible depuis QML
    Q_INVOKABLE int getTileValue(int row, int col) const;
    Q_INVOKABLE Tile* getTileAt(int row, int col) const;
    Q_INVOKABLE void setSize(int newsize);
private:
    Board* m_board;
    //Tile* m_grid[SIZE][SIZE];
    DamierDyn m_grid;
    int m_size;
    bool m_changed;
};

#endif // BOARDMODEL_H
