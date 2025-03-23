import QtQuick


Rectangle {
    id: tile
    width: 80
    height: 80
    radius: 5

    property int value: 0

    // Couleur et texte basés sur la valeur
    color: getBackgroundColor(value)

    Text {
        anchors.centerIn: parent
        text: value !== 0 ? value : ""
        font.family: "Arial"
        font.pixelSize: value < 1000 ? 36 : 24
        font.bold: true
        color: value <= 4 ? "#776e65" : "white"
    }


    // Fonction pour déterminer la couleur de fond en fonction de la valeur
    function getBackgroundColor(val) {
        switch(val) {
            case 0: return "#cdc1b4"; // Cellule vide
            case 2: return "#eee4da";
            case 4: return "#ede0c8";
            case 8: return "#f2b179";
            case 16: return "#f59563";
            case 32: return "#f67c5f";
            case 64: return "#f65e3b";
            case 128: return "#edcf72";
            case 256: return "#edcc61";
            case 512: return "#edc850";
            case 1024: return "#edc53f";
            case 2048: return "#edc22e";
            default: return "#3c3a32"; // Pour les valeurs supérieures
        }
    }
}
