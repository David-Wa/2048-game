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
                          vueObjetBtn.openMenu();  // Appel de la méthode C++ pour émettre openMenu
                      }
                  }
}}


    // La fenêtre qui sera ouverte lorsque le bouton est cliqué
        Window {
            id: menuWindow
            width: 300
            height: 200
            title: "Menu"

            Rectangle {
                width: parent.width
                height: parent.height
                color: "#f0f0f0"

                Text {
                    anchors.centerIn: parent
                    text: "Voici votre menu"
                    font.pixelSize: 20
                    font.family: "Tahoma"
                }
            }

            // Fermer le menu lorsqu'on clique sur la fenêtre
            MouseArea {
                anchors.fill: parent
                onClicked: menuWindow.close()
            }
        }

    }

