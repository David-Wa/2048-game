import QtQuick 2.15

Item {
    id: button
    width: 100
    height: 50

    property alias buttonText: _text.text   // Alias pour manipuler le texte du bouton
    property color normalColor: "#ffffff"  // Couleur de base
    property color hoverColor: "#d3d3d3"   // Couleur lorsqu'on survole
    property color clickedColor: "#a9a9a9" // Couleur lorsqu'on clique

    Rectangle {
        id: rectangle
        color: normalColor
        radius: 10
        anchors.fill: parent

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            // Changement de couleur au survol
            onPressed: {
                rectangle.color = clickedColor
            }

            onReleased: {
                rectangle.color = hoverColor
                console.log("Button clicked!")
            }

            onClicked: {
                // Action à effectuer lors du clic (par exemple, changer le texte)
                buttonText = "Cliqué!"
            }

            onMouseAreaClicked: {
                // Change le texte lorsque le bouton est cliqué
                buttonText = "Action Réalisée"
            }
        }

        Text {
            id: _text
            anchors.centerIn: parent
            text: qsTr("Bouton")
            font.pixelSize: 20
            color: "#000000"
        }
    }
}
