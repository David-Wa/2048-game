import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: gameScreen
    anchors.fill: parent

    // En-tête avec scores et bouton retour
    Rectangle {
        id: header
        width: parent.width
        height: 120
        color: "transparent"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        // Titre du jeu
        Text {
            id: gameTitleText
            text: "2048"
            font.family: "Helvetica"
            font.pixelSize: 40
            font.bold: true
            color: "#776E65"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        // Scoreboard
        ScoreBoard {
            id: scoreBoard
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        // Bouton pour revenir au menu
        GameButton {
            width: 100
            height: 40
            text: "Menu"
            anchors.left: gameTitleText.right
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            onClicked: gameWindow.showMainMenu()
        }
    }

    // Plateau de jeu
    GameBoard {
        id: gameBoard
        width: Math.min(parent.width - 40, 400)
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
        anchors.topMargin: 20

        // Gestion des touches clavier pour le jeu
        Keys.onPressed: function(event) {
            switch(event.key) {
                case Qt.Key_Up:
                case Qt.Key_W:
                    // Logique pour déplacer vers le haut
                    event.accepted = true;
                    break;
                case Qt.Key_Down:
                case Qt.Key_S:
                    // Logique pour déplacer vers le bas
                    event.accepted = true;
                    break;
                case Qt.Key_Left:
                case Qt.Key_A:
                    // Logique pour déplacer vers la gauche
                    event.accepted = true;
                    break;
                case Qt.Key_Right:
                case Qt.Key_D:
                    // Logique pour déplacer vers la droite
                    event.accepted = true;
                    break;
            }
        }
    }

    // Instructions
    Text {
        text: "Utilisez les flèches pour déplacer les tuiles"
        font.family: "Helvetica"
        font.pixelSize: 16
        color: "#776E65"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: gameBoard.bottom
        anchors.topMargin: 30
    }

    // Boutons d'action
    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        spacing: 20

        // Bouton Nouvelle Partie
        GameButton {
            text: "Nouvelle Partie"
            onClicked: {
                // Réinitialiser le jeu
            }
        }

        // Bouton Annuler
        GameButton {
            text: "Annuler"
            onClicked: {
                // Annuler le dernier mouvement
            }
        }
    }

    // Activer le focus pour capter les événements clavier
    Component.onCompleted: {
        gameBoard.forceActiveFocus();
    }
}
