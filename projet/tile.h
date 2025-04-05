#ifndef TILE_H
#define TILE_H

class Tile {
public:
    Tile();
    int getValue() const;
    void setValue(int value);
    int getRow() const;
    int getCol() const;
    void setPosition(int row, int col);
    bool isMerged() const;
    void setMerged(bool merged);
    bool isEmpty() const;
    Tile& operator=(const Tile& A);


private:
    int m_value;
    int m_row;
    int m_col;
    bool m_merged;
};

#endif // TILE_H
