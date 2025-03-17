import QtQuick

Item {
    id: gameBoard

    // Propriété pour suivre l'état de la grille
    property var gridState: [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
    ]

    // Fond du plateau
    Rectangle {
        id: boardBackground
        anchors.fill: parent
        color: "#BBADA0"
        radius: 6

        // Grille de cellules vides
        Grid {
            id: cellGrid
            anchors.fill: parent
            anchors.margins: 10
            rows: 4
            columns: 4
            spacing: 10

            // Cellules vides (cases de fond)
            Repeater {
                model: 16

                Rectangle {
                    width: (cellGrid.width - cellGrid.spacing * 3) / 4
                    height: (cellGrid.height - cellGrid.spacing * 3) / 4
                    color: "#CDC1B4"
                    radius: 3
                }
            }
        }
    }

    // Conteneur pour les tuiles
    Item {
        id: tileContainer
        anchors.fill: boardBackground
        anchors.margins: 10

        // Les tuiles seront créées dynamiquement ici
    }

    // Fonction pour créer une tuile
    function createTile(row, col, value) {
        var tileComponent = Qt.createComponent("Tile.qml");
        if (tileComponent.status === Component.Ready) {
            var cellWidth = (cellGrid.width - cellGrid.spacing * 3) / 4;
            var cellHeight = (cellGrid.height - cellGrid.spacing * 3) / 4;

            var tile = tileComponent.createObject(tileContainer, {
                "width": cellWidth,
                "height": cellHeight,
                "x": col * (cellWidth + cellGrid.spacing),
                "y": row * (cellHeight + cellGrid.spacing),
                "value": value
            });

            return tile;
        }
    }

    // Fonction pour mettre à jour la grille visuelle à partir de gridState
    function updateGrid() {
        // Supprimer toutes les tuiles existantes
        for (var i = tileContainer.children.length - 1; i >= 0; i--) {
            tileContainer.children[i].destroy();
        }

        // Créer de nouvelles tuiles en fonction de gridState
        for (var row = 0; row < 4; row++) {
            for (var col = 0; col < 4; col++) {
                var value = gridState[row][col];
                if (value > 0) {
                    createTile(row, col, value);
                }
            }
        }
    }

    // Initialiser le jeu avec deux tuiles aléatoires
    Component.onCompleted: {
        // Placer deux tuiles de départ (à implémenter)
        addRandomTile();
        addRandomTile();
        updateGrid();
    }

    // Ajouter une tuile aléatoire (valeur 2 ou 4) à une position vide
    function addRandomTile() {
        var emptyCells = [];

        // Trouver toutes les cellules vides
        for (var row = 0; row < 4; row++) {
            for (var col = 0; col < 4; col++) {
                if (gridState[row][col] === 0) {
                    emptyCells.push({row: row, col: col});
                }
            }
        }

        if (emptyCells.length > 0) {
            // Choisir une cellule vide aléatoire
            var randomIndex = Math.floor(Math.random() * emptyCells.length);
            var cell = emptyCells[randomIndex];

            // 90% de chance pour une tuile de valeur 2, 10% pour une tuile de valeur 4
            var value = Math.random() < 0.9 ? 2 : 4;

            // Mettre à jour l'état de la grille
            gridState[cell.row][cell.col] = value;
        }
    }
}
