import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: mainWindow
    width: 480
    height: 640
    visible: true
    title: "2048"
    color: "#FAF8EF"

    // Dimensions de la grille et des tuiles
    property int cellSize: 80
    property int cellSpacing: 10
    property int gridMargin: 10

    Item {
        id: keyboardFocus
        focus: true
        anchors.fill: parent

        // Gestion des touches clavier
        Keys.onPressed: function(event) {
            console.log("Touche pressée:", event.key);
            if (event.key === Qt.Key_Up) {
                console.log("Déplacement vers le haut");
                gameController.move(0); // UP
                event.accepted = true;
            } else if (event.key === Qt.Key_Right) {
                console.log("Déplacement vers la droite");
                gameController.move(1); // RIGHT
                event.accepted = true;
            } else if (event.key === Qt.Key_Down) {
                console.log("Déplacement vers le bas");
                gameController.move(2); // DOWN
                event.accepted = true;
            } else if (event.key === Qt.Key_Left) {
                console.log("Déplacement vers la gauche");
                gameController.move(3); // LEFT
                event.accepted = true;
            }
        }

        // Pour tester si les événements clavier sont capturés
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("Clic détecté - Focus sur l'élément des touches");
                keyboardFocus.forceActiveFocus();
            }
        }
    }

    Rectangle {
        id: header
        x: 0
        width: parent.width
        height: 100
        color: "#FAF8EF"
        anchors.top: parent.top
        anchors.topMargin: 9

        Text {
            id: gameTitle
            text: "2048"
            font.pixelSize: 40
            font.bold: true
            color: "#776e65"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.topMargin: 40
            anchors.verticalCenter: parent.verticalCenter
        }

        Button {
            id: newGameButton
            text: "Nouvelle partie"
            width: 120
            height: 40
            anchors.top: gameTitle.bottom
            anchors.topMargin: 3
            anchors.horizontalCenter: gameTitle.horizontalCenter
            z: 1

            onClicked: {
                console.log("Bouton nouvelle partie cliqué");
                gameController.newGame();
            }

            contentItem: Text {
                text: newGameButton.text
                font: newGameButton.font
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: "#8f7a66"
                radius: 5
            }
        }

        Rectangle {
            id: scoreBox
            x: 372
            width: 80
            height: 50
            radius: 5
            color: "#7B1113"
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: scoreLabel
                text: "SCORE"
                font.family: "Arial"
                font.pixelSize: 13
                font.bold: true
                color: "#eee4da"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 5
            }

            Text {
                id: scoreValue
                text: gameController.getScore()
                font.family: "Arial"
                font.pixelSize: 25
                font.bold: true
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
            }
        }

        Rectangle {
            id: bestScoreBox
            width: 80
            height: 50
            radius: 5
            color: "#00008B"
            anchors.right: scoreBox.left
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: bestScoreLabel
                text: "MEILLEUR"
                font.family: "Arial"
                font.pixelSize: 13
                font.bold: true
                color: "#eee4da"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 5
            }

            Text {
                id: bestScoreValue
                text: gameController.getBestScore()
                font.family: "Arial"
                font.pixelSize: 25
                font.bold: true
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
            }
        }
    }

    Rectangle {
        id: gameGridBackground
        width: 4 * cellSize + 5 * cellSpacing
        height: 4 * cellSize + 5 * cellSpacing
        color: "#bbada0"
        radius: 5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
        anchors.topMargin: 20

        Grid {
            id: gameGrid
            anchors.fill: parent
            anchors.margins: gridMargin
            rows: 4
            columns: 4
            spacing: cellSpacing

            Repeater {
                model: 16
                Cell {
                    width: cellSize
                    height: cellSize
                }
            }
        }

        Item {
            id: tilesContainer
            anchors.fill: gameGrid
            anchors.margins: 0

            Repeater {
                id: tilesRepeater
                model: 16

                Tile {
                    width: cellSize
                    height: cellSize
                    x: (index % 4) * (cellSize + cellSpacing)
                    y: Math.floor(index / 4) * (cellSize + cellSpacing)
                    value: {
                        var row = Math.floor(index / 4);
                        var col = index % 4;
                        var tileValue = gameController.boardModel.getTileValue(row, col);
                        return tileValue;
                    }
                    opacity: value === 0 ? 0 : 1
                }
            }
        }
    }

    Connections {
        target: gameController

        function onScoreChanged() {
            console.log("Score changé:", gameController.getScore());
            scoreValue.text = gameController.getScore();
        }

        function onBestScoreChanged() {
            console.log("Meilleur score changé:", gameController.getBestScore());
            bestScoreValue.text = gameController.getBestScore();
        }

        function onGameOverChanged() {
            console.log("État du jeu changé - Game Over:", gameController.isGameOver());
            if (gameController.isGameOver()) {
                gameOverDialog.visible = true;
            }
        }

        function onGameWonChanged() {
            console.log("État du jeu changé - Victoire:", gameController.isGameWon());
            if (gameController.isGameWon()) {
                gameWonDialog.visible = true;
            }
        }

        function onBoardModelChanged() {
            console.log("Modèle du plateau changé");
            tilesRepeater.model = 0;
            tilesRepeater.model = 16;
        }
    }

    Dialog {
        id: gameOverDialog
        title: "Game Over"
        standardButtons: Dialog.Ok
        anchors.centerIn: parent
        visible: false
        modal: true

        onAccepted: {
            gameController.newGame();
            close();
        }

        Text {
            text: "Partie terminée! Votre score: " + gameController.getScore()
        }
    }

    Dialog {
        id: gameWonDialog
        title: "Victoire!"
        standardButtons: Dialog.Ok
        anchors.centerIn: parent
        visible: false
        modal: true

        onAccepted: {
            close();
        }

        Text {
            text: "Félicitations! Vous avez atteint 2048!"
        }
    }

    Rectangle {
        id: controlsArea
        width: parent.width
        height: 100
        color: "#8f7a66"
        anchors.top: gameGridBackground.bottom
        anchors.topMargin: 20

        Text {
            id: instructions
            text: "Utilisez les flèches pour déplacer les tuiles. Les tuiles de même valeur fusionnent lorsqu'elles se touchent. Obtenez 2048 pour gagner!"
            font.family: "Arial"
            font.pixelSize: 16
            color: "white"
            wrapMode: Text.WordWrap
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
        }
    }

    // Forcer le focus sur l'élément qui gère les touches au démarrage
    Component.onCompleted: {
        keyboardFocus.forceActiveFocus();
        console.log("Fenêtre initialisée, focus défini sur l'élément de clavier");
    }
}
