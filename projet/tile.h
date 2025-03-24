#ifndef TILE_H
#define TILE_H

class Tile{
public:
    int  getvalue();
    void setValue(int value);
    int  getRow();
    int  getCol();
    void setPosition(int row, int col);
    bool isMerged();
    void setMerged(bool merged);
    bool isEmpty();

private:
    int m_value;
    int m_row;
    int m_col;
    bool m_merged;


};

#endif // TILE_H
