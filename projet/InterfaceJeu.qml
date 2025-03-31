import QtQuick
import QtQuick.Window
import QtQuick.Controls
import "."

Window {
    id: mainWindow
    width: 480
    height: 640
    visible: true
    title: "2048"
    color: "#FAF8EF"

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
            color: "#bbada0"
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter



            Text {
                id: bestScore
                text: "SCORE"
                font.family: "Arial"
                font.pixelSize: 10
                font.bold: true
                color: "#eee4da"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 5
            }

            Text {
                id: scoreValue
                text: "0"
                font.family: "Arial"
                font.pixelSize: 25
                font.bold: true
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
            }
        }

        Rectangle {
            id: bestScoreBox
            width: 80
            height: 50
            radius: 5
            color: "#bbada0"
            anchors.right: scoreBox.left
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            Text {
                id: bestScoreLabel
                text: "MEILLEUR"
                font.family: "Arial"
                font.pixelSize: 10
                font.bold: true
                color: "#eee4da"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 5
            }

            Text {
                id: bestScoreValue
                text: "0"
                font.family: "Arial"
                font.pixelSize: 25
                font.bold: true
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
            }
        }


    }

    Rectangle {
        id: gameGridBackground
        y: 141
        width: 450
        height: 450
        color: "#bbada0"
        radius: 5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
        anchors.topMargin: 20
        anchors.horizontalCenterOffset: 0

        Grid {
            id: gameGrid
            anchors.fill: parent
            anchors.centerIn: parent
            width: 430
            anchors.margins: 10
            anchors.leftMargin: 16
            anchors.rightMargin: 4
            anchors.topMargin: 14
            anchors.bottomMargin: 6
            anchors.verticalCenterOffset: -6
            anchors.horizontalCenterOffset: 4
            rows: 4
            columns: 4
            spacing: 10

            /*Repeater {
                model: 16
                Cell {}
            }*/
        }

        Item {
            id: tilesContainer
            anchors.fill: gameGrid

            Repeater {
                id: tilesRepeater
                model: 16

                /*Tile {
                    id: tile
                    x: 10 + (index % 4) * (80 + 10)
                    y: 10 + Math.floor(index / 4) * (80 + 10)
                    value: 0
                    opacity: value === 0 ? 0 : 1
                }*/
            }
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
            font.pixelSize: 12
            color: "white"
            wrapMode: Text.WordWrap
            width: parent.width - 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
        }
    }
}
