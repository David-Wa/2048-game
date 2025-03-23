import QtQuick
import QtQuick.Window
import QtQuick.Controls

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
            font.pixelSize: 50
            font.bold: true
            color: "#776e65"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: scoreBox
            x: 372
            width: 100
            height: 60
            radius: 5
            color: "#bbada0"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 8
            anchors.topMargin: 17


        Text {
             id: scoreValue
             text: "0"
             font.family: "Arial"
             font.pixelSize: 20
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
        anchors.topMargin: 17
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

            Repeater {
                model: 16
                Cell {}
            }
        }

        Item {
            id: tilesContainer
            anchors.fill: gameGrid

            Repeater {
                id: tilesRepeater
                model: 16

                Tile {
                    id: tile
                    x: 10 + (index % 4) * (80 + 10)
                    y: 10 + Math.floor(index / 4) * (80 + 10)
                    value: 0
                    opacity: value === 0 ? 0 : 1

                }

            }
        }

    }

}
