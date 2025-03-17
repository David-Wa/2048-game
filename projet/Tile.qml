import QtQuick

Rectangle {
    id: tile

    // Propriété pour la valeur de la tuile (2, 4, 8, etc.)
    property int value: 2

    // Rayon des coins arrondis
    radius: 3

    // Obtenir la couleur de fond en fonction de la valeur
    color: {
        switch(value) {
            case 2: return "#EEE4DA";
            case 4: return "#EDE0C8";
            case 8: return "#F2B179";
            case 16: return "#F59563";
            case 32: return "#F67C5F";
            case 64: return "#F65E3B";
            case 128: return "#EDCF72";
            case 256: return "#EDCC61";
            case 512: return "#EDC850";
            case 1024: return "#EDC53F";
            case 2048: return "#EDC22E";
            default: return "#CDC1B4";
        }
    }

    // Label pour afficher la valeur
    Text {
        anchors.centerIn: parent
        text: tile.value
        font.family: "Helvetica"
        font.pixelSize: {
            if (tile.value < 100) return tile.width * 0.5;
            else if (tile.value < 1000) return tile.width * 0.4;
            else return tile.width * 0.3;
        }
        font.bold: true
        color: tile.value <= 4 ? "#776E65" : "#F9F6F2"
    }

    // Animation d'apparition
    Component.onCompleted: {
        scaleAnim.start();
    }

    // Animation d'échelle pour l'apparition
    SequentialAnimation {
        id: scaleAnim

        // Commencer petit
        PropertyAction {
            target: tile
            property: "scale"
            value: 0.1
        }

        // Grossir jusqu'à taille normale avec un petit rebond
        NumberAnimation {
            target: tile
            property: "scale"
            to: 1.1
            duration: 100
            easing.type: Easing.OutQuad
        }

        NumberAnimation {
            target: tile
            property: "scale"
            to: 1.0
            duration: 50
            easing.type: Easing.InQuad
        }
    }
}
