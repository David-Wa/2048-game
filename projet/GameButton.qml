import QtQuick
import QtQuick.Controls

Button {
    id: gameButton

    // Propriétés par défaut
    height: 50

    // Style personnalisé
    contentItem: Text {
        text: gameButton.text
        font.family: "Helvetica"
        font.pixelSize: 18
        font.bold: true
        color: "#F9F6F2"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        radius: 5
        color: gameButton.pressed ? "#8F7A66" : "#8F7A66"
        opacity: gameButton.pressed ? 0.8 : (gameButton.hovered ? 0.9 : 1.0)

        // Animation lors du survol
        Behavior on opacity {
            NumberAnimation { duration: 100 }
        }
    }

    // Effet de hover
    HoverHandler {
        onHoveredChanged: {
            cursorShape = Qt.PointingHandCursor
        }
    }
}
