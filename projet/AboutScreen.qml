import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: aboutScreen
    anchors.fill: parent
    color: "#FAF8EF" // Couleur de fond du jeu 2048

    // Composant bouton personnalisé pour la prévisualisation
    component PreviewButton: Rectangle {
        property string text: "Bouton"
        property color textColor: "#F9F6F2"
        property color bgColor: "#8F7A66"

        width: buttonText.width + 40
        height: 50
        radius: 5
        color: bgColor

        Text {
            id: buttonText
            text: parent.text
            font.family: "Helvetica"
            font.pixelSize: 18
            font.bold: true
            color: parent.textColor
            anchors.centerIn: parent
        }
    }

    // Titre de l'écran
    Text {
        id: titleText
        text: "À propos"
        font.family: "Helvetica"
        font.pixelSize: 48
        anchors.horizontalCenterOffset: 0
        font.bold: true
        color: "#776E65"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 8
    }

    // Logo du jeu
    Rectangle {
        id: gameLogo
        width: 100
        height: 100
        radius: 10
        color: "#EDC22E"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: titleText.bottom
        anchors.topMargin: 20

        Text {
            anchors.centerIn: parent
            text: "2048"
            font.family: "Helvetica"
            font.pixelSize: 32
            font.bold: true
            color: "#F9F6F2"
        }
    }

    // Conteneur pour les informations
    Rectangle {
        id: infoContainer
        width: Math.min(parent.width - 40, 400)
        height: 300
        color: "#BBADA0"
        radius: 6
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: gameLogo.bottom
        anchors.topMargin: -3
        anchors.horizontalCenterOffset: -7

        // Informations sur le jeu
        Flickable {
            anchors.fill: parent
            anchors.margins: 20
            contentWidth: width
            contentHeight: infoColumn.height
            clip: true

            ColumnLayout {
                id: infoColumn
                width: parent.width
                spacing: 15

                Text {
                    Layout.fillWidth: true
                    text: "Comment jouer :"
                    font.family: "Helvetica"
                    font.pixelSize: 18
                    font.bold: true
                    color: "#F9F6F2"
                }

                Text {
                    Layout.fillWidth: true
                    text: "• Utilisez les touches fléchées pour déplacer les tuiles.\n"
                         + "• Lorsque deux tuiles avec le même nombre se touchent, elles fusionnent en une seule!\n"
                         + "• Créez une tuile avec le nombre 2048 pour gagner."
                    font.family: "Helvetica"
                    font.pixelSize: 16
                    color: "#F9F6F2"
                    wrapMode: Text.WordWrap
                }

                Text {
                    Layout.fillWidth: true
                    text: "Version: 1.0.0"
                    font.family: "Helvetica"
                    font.pixelSize: 16
                    color: "#F9F6F2"
                }

                Text {
                    Layout.fillWidth: true
                    text: "© 2025 TBER Anas et WAGNER David droits réservés."
                    font.family: "Helvetica"
                    font.pixelSize: 16
                    color: "#F9F6F2"
                }

            }
        }
    }

}
