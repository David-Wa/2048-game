#include "tile.h"

Tile::Tile()
    : m_value(0)
    , m_row(0)
    , m_col(0)
    , m_merged(false)
{
}

int Tile::getValue() const
{
    return m_value;
}

void Tile::setValue(int value)
{
    m_value = value;
}

int Tile::getRow() const
{
    return m_row;
}

int Tile::getCol() const
{
    return m_col;
}

void Tile::setPosition(int row, int col)
{
    m_row = row;
    m_col = col;
}

bool Tile::isMerged() const
{
    return m_merged;
}

void Tile::setMerged(bool merged)
{
    m_merged = merged;
}

bool Tile::isEmpty() const
{
    return m_value == 0;
}


Tile& Tile::operator=(const Tile& A)
{
    m_value=A.m_value;
    m_row=A.m_row;
    m_col=A.m_col;
    m_merged=A.m_merged;
    return *this;
}
