import QtQuick

Window {
    x: 0
    width: 320
    height: 240
    opacity: 1
    visible: true
    color: "#b24dbe"
    title: qsTr("Hello World")

    Rectangle {
        id: rectangle
        x: 110
        y: 95
        width: 100
        height: 50
        visible: true
        color: "#00ffa5"


    MenuButton { id: color
        buttonText: "hello"
        // Connexion au signal 'openMenu' pour ouvrir une nouvelle fenêtre
        Connections {
            target: vueObjetBtn
            onOpenMenu: {
                menuWindow.visible = true;  // Ouvre la fenêtre du menu en la rendant visible
                            }
        }

    }}

    // La fenêtre qui sera ouverte lorsque le bouton est cliqué
        Window {
            id: menuWindow
            width: 300
            height: 200
            title: "Menu"
            visible: false  // Initialement, la fenêtre est invisible

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

