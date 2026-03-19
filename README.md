# 2048 Project in C++ with Qt and QML

## Authors
- **Anas Tber**: anas.tber@etu.ec-lyon.fr
- **David Wagner**: david.wagner@etu.ec-lyon.fr

## Description
This project is a replica of the 2048 game developed in **C++** with **Qt** and **QML**. The goal is to faithfully reproduce the gameplay of the original game, without ads, and with additional features to enhance the user experience. A tutorial video titled "2048 tuto" as well as screenshots of the game are available in the "Démo" folder of the Git repository.

## Game Rules
The game is played exclusively with the **4 directional arrow keys**:
- Pressing an arrow key moves all tiles in the chosen direction.
- Two tiles of the same value merge when they meet, forming a new tile with the sum of their values (e.g. 2+2=4, 4+4=8, etc.).
- A new tile appears randomly on an empty cell after each move (value 2 in most cases, sometimes 4).
- The game ends when the grid is full and no move can merge tiles or free up a cell.

The goal is to obtain a tile with the value **2048** (or more) before the grid becomes stuck.

## Implemented Features
- Basic 2048 game with tile merging and random appearance of new tiles
- Intuitive graphical interface with QML
- Ability to choose grid size (4×4, 5×5, 6×6, 7×7, 8×8)
- Undo system
- Color customization (by clicking on a pixel in a photo) and font customization
- Adjustable difficulty levels (easy, medium, hard) affecting the probability of obtaining tiles with value 4
- Best score saving

## Main Data Structures

**DamierDyn:**
- Core structure managing a dynamic 3D array of Tile pointers (Tile***)
- Implements a resizable matrix with dynamic allocation/deallocation
- Includes a copy constructor and assignment operator for state management
- Enables tile manipulation via get, set, redim, and del methods

**stack\<DamierDyn\>:**
- Used to store the board state history
- Implements undo/redo functionality by keeping track of changes

**stack\<int\>:**
- Used in Game to store score history
- Synchronized with board states to ensure consistency during undo/redo

## Role of Each Class

**Tile:**
- Encapsulates individual tile data: value, position (row, col), merge state
- Provides getters and setters to modify state
- Includes an assignment operator to copy properties between tiles

**Board:**
- Contains the game grid (DamierDyn m_grid)
- Handles all tile movements (moveUp, moveDown, moveLeft, moveRight)
- Implements tile merging logic and detection of possible moves
- Adds random tiles with probability based on difficulty level
- Manages board state history for undo/redo

**BoardModel:**
- Adapts the data model for the QML interface (inherits from QAbstractListModel)
- Defines roles used by QML to access data (ValueRole, RowRole, ColRole)
- Converts the 2D grid structure into a 1D list for use in QML views
- Implements methods required by QAbstractListModel (rowCount, data, roleNames)

**Game:**
- Coordinates the overall game logic and maintains global state
- Manages the current score and best score, as well as their history
- Detects win/loss conditions
- Controls the difficulty level
- Implements game state saving/loading via QSettings

**GameController:**
- Acts as a bridge between the QML user interface and the C++ logic
- Exposes game properties and methods to QML via Q_PROPERTY and Q_INVOKABLE
- Translates user inputs into actions in the model
- Emits signals to notify the interface of state changes

**ColorPicker:**
- Utility class for customization
- Extracts the color of a pixel in an image for personalization

**Button (MenuButton):**
- Custom interface component
- Handles menu button interactions

**Direction (enum):**
- Defines constants for movement directions (UP, RIGHT, DOWN, LEFT)
- Standardizes movement types throughout the code

## Challenges Encountered
- Transitioning from a statically sized grid (array) to a grid as a DamierDyn instance. This could have been better anticipated, which would have made implementing the grid size change feature easier.
- Getting QML to find the path to execute resources (which differed from the actual file path), in particular the photo for the color change option, through the build folder.
- The undo feature: remembering to implement the copy constructor for DamierDyn and to overload the = operator for Tile.
- Saving the best score in QSettings.
- In general, using new Qt libraries required additional documentation to better understand them (QList, QImage, QDebug, QSettings, etc.)

## Technologies Used
- **Language**: C++
- **Framework**: Qt
- **Interface**: QML for display

## Compilation and Execution
### Prerequisites
- **Qt Creator** installed with Qt 6
- A compatible **C++ compiler** (GCC, Clang, MSVC...)

### Instructions
1. Clone the project repository:
```
   git clone https://gitlab.ec-lyon.fr/atber/2048-c.git
```
2. Open the "projet" folder in **Qt Creator**.
3. Compile and run.

## Authors and Credits
Project carried out as part of the C++ elective course *"Graphical Interface Programming in C++"*, second year of the general engineering curriculum at Centrale Lyon.

Developed by:
- **Anas Tber** — anas.tber@etu.ec-lyon.fr
- **David Wagner** — david.wagner@etu.ec-lyon.fr
