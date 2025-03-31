import QtQuick
import QtQuick.Controls
import QtQuick.Window

// La fenêtre qui sera ouverte lorsque le bouton est cliqué
Window {
    id: colorWindow
    width: 300
    height: 200
    title: "Couleur du jeu"
    visible: true  // Initialement, la fenêtre est invisible

    Rectangle {
        width: parent.width
        height: parent.height
        color: "#f0f0f0"

        Text {
            text: "Voici votre menu"
            font.pixelSize: 20
            font.family: "Tahoma"
        }
    }

    Image {
                id: myImage
                x: 0
                y: 0
                source: "couleurs.jpg" // Remplace par ton image
                width: 300
                height: 160
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked: (mouse) => {
                        var color = imageSource.item.grab(1, 1, mouse.x, mouse.y).toImage().pixelColor(0, 0);
                        colorPreview.color = color;
                        label.text = "Couleur : " + color;
                    }
                }
            }


    ShaderEffectSource {
        id: imageSource
        sourceItem: myImage
        live: true
    }
}



