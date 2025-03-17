import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: mainMenu
    anchors.fill: parent

    // Titre du jeu
    Text {
        id: titleText
        text: "2048"
        font.family: "Helvetica"
        font.pixelSize: 72
        font.bold: true
        color: "#776E65"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 60
    }

    // Sous-titre
    Text {
        id: subtitleText
        text: "Fusionnez les tuiles et atteignez 2048 !"
        font.family: "Helvetica"
        font.pixelSize: 18
        color: "#776E65"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: titleText.bottom
        anchors.topMargin: 20
    }

    // Conteneur pour les boutons du menu
    ColumnLayout {
        width: 200
        spacing: 15
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: subtitleText.bottom
        anchors.topMargin: 60

        // Bouton Jouer
        GameButton {
            Layout.fillWidth: true
            text: "Jouer"
            onClicked: gameWindow.startGame()
        }

        // Bouton Options
        GameButton {
            Layout.fillWidth: true
            text: "Options"
            onClicked: gameWindow.showOptions()
        }

        // Bouton À propos
        GameButton {
            Layout.fillWidth: true
            text: "À propos"
            onClicked: gameWindow.showAbout()
        }

        // Bouton Quitter
        GameButton {
            Layout.fillWidth: true
            text: "Quitter"
            onClicked: Qt.quit()
        }
    }

    // Information de copyright
    Text {
        text: "© 2025 Votre Nom"
        font.family: "Helvetica"
        font.pixelSize: 12
        color: "#BBADA0"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
    }
}
