import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: gameOverScreen
    anchors.fill: parent
    color: "#FAF8EF"  // Couleur de fond du jeu 2048

    // Propriétés pour les résultats du jeu - avec valeurs par défaut pour prévisualisation
    property int finalScore: 4856
    property int bestScore: 10204
    property bool isVictory: true // changer à false pour prévisualiser l'état de défaite

    // Définition du bouton pour la prévisualisation
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

    // Fond semi-transparent
    Rectangle {
        anchors.fill: parent
        color: "#BBADA0"
        opacity: 0.85
    }

    // Conteneur principal
    Rectangle {
        width: Math.min(parent.width - 40, 400)
        height: 400
        color: "#FAF8EF"
        radius: 10
        anchors.centerIn: parent

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            // Titre selon la condition de fin de jeu
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: isVictory ? "Victoire !" : "Partie terminée"
                font.family: "Helvetica"
                font.pixelSize: 48
                font.bold: true
                color: isVictory ? "#EDC22E" : "#776E65"
            }

            // Image ou texte de statut
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 80
                height: 80
                radius: 40
                color: isVictory ? "#EDC22E" : "#776E65"

                Text {
                    anchors.centerIn: parent
                    text: isVictory ? "👑" : "😢"
                    font.pixelSize: 40
                }
            }

            // Message selon le résultat
            Text {
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                text: isVictory ?
                      "Félicitations ! Vous avez atteint 2048 !" :
                      "Aucun mouvement possible. Essayez encore !"
                font.family: "Helvetica"
                font.pixelSize: 18
                color: "#776E65"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            // Score final
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 200
                height: 60
                radius: 5
                color: "#BBADA0"

                Column {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "SCORE FINAL"
                        font.family: "Helvetica"
                        font.pixelSize: 13
                        color: "#EEE4DA"
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: finalScore
                        font.family: "Helvetica"
                        font.pixelSize: 25
                        font.bold: true
                        color: "white"
                    }
                }
            }

            // Meilleur score
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 200
                height: 60
                radius: 5
                color: "#BBADA0"

                Column {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "MEILLEUR SCORE"
                        font.family: "Helvetica"
                        font.pixelSize: 13
                        color: "#EEE4DA"
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: bestScore
                        font.family: "Helvetica"
                        font.pixelSize: 25
                        font.bold: true
                        color: "white"
                    }
                }
            }

            // Boutons
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 20

                // Bouton Nouvelle Partie
                PreviewButton {
                    text: "Nouvelle Partie"
                }

                // Bouton Menu Principal
                PreviewButton {
                    text: "Menu Principal"
                }
            }

            // Partager le score (lien fictif)
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Partager votre score"
                font.family: "Helvetica"
                font.pixelSize: 16
                font.underline: true
                color: "#8F7A66"
            }
        }
    }

    // Pour prévisualiser différents états en mode Design
    // Commentez/décommentez ces lignes pour voir différents états
    Component.onCompleted: {
        // État de victoire (par défaut)
        // isVictory = true;
        // finalScore = 4856;

        // État de défaite
        // isVictory = false;
        // finalScore = 1024;
    }
}
