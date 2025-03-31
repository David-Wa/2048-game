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

        // Text affichant la propriété btnQML du C++ (vueObjetBtn)
              Text {
                  id: _text
                  anchors.centerIn: parent
                  text: "bouton"
                  font.pixelSize: 20
                  font.family: "Tahoma"

                  MouseArea {
                      anchors.fill: parent
                      onClicked: {
                          vueObjetBtn.buttonName=buttonText
                          vueObjetBtn.openMenu();  // Appel de la méthode C++ pour émettre openMenu
                      }
                  }
}}
}


