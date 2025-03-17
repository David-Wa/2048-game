import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: optionsScreen
    anchors.fill: parent

    // Titre de l'écran
    Text {
        id: titleText
        text: "Options"
        font.family: "Helvetica"
        font.pixelSize: 48
        font.bold: true
        color: "#776E65"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 60
    }

    // Conteneur pour les options
    Rectangle {
        id: optionsContainer
        width: Math.min(parent.width - 40, 400)
        height: 280
        color: "#BBADA0"
        radius: 6
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: titleText.bottom
        anchors.topMargin: 40

        // Options
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 25

            // Option Son
            RowLayout {
                width: parent.width
                Text {
                    text: "Son"
                    font.family: "Helvetica"
                    font.pixelSize: 18
                    color: "#F9F6F2"
                }

                Item { Layout.fillWidth: true } // Spacer

                Switch {
                    id: soundSwitch
                    checked: true
                    // Dans un vrai jeu, on lierait ça à la configuration
                }
            }

            // Option Musique
            RowLayout {
                width: parent.width
                Text {
                    text: "Musique"
                    font.family: "Helvetica"
                    font.pixelSize: 18
                    color: "#F9F6F2"
                }

                Item { Layout.fillWidth: true } // Spacer

                Switch {
                    id: musicSwitch
                    checked: true
                }
            }

            // Option Animations
            RowLayout {
                width: parent.width
                Text {
                    text: "Animations"
                    font.family: "Helvetica"
                    font.pixelSize: 18
                    color: "#F9F6F2"
                }

                Item { Layout.fillWidth: true } // Spacer

                Switch {
                    id: animationsSwitch
                    checked: true
                }
            }

            // Sélection de thème
            RowLayout {
                width: parent.width
                Text {
                    text: "Thème"
                    font.family: "Helvetica"
                    font.pixelSize: 18
                    color: "#F9F6F2"
                }

                Item { Layout.fillWidth: true } // Spacer

                ComboBox {
                    id: themeComboBox
                    model: ["Classique", "Sombre", "Coloré"]
                    currentIndex: 0
                }
            }
        }
    }

    // Boutons d'action
    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 60
        spacing: 20

        // Bouton Sauvegarder
        GameButton {
            text: "Sauvegarder"
            onClicked: {
                // Sauvegarder les paramètres
                // Dans un vrai jeu, on sauvegarderait dans QSettings
                gameWindow.showMainMenu()
            }
        }

        // Bouton Annuler
        GameButton {
            text: "Annuler"
            onClicked: gameWindow.showMainMenu()
        }
    }
}
