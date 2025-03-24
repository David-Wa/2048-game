import QtQuick

Window {
    color: "#ecaf49"

    Column {
        id: column
        width: 104
        height: 177
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        MenuButton {
            id: couleur
            buttonText: qsTr("Couleur")

            // Exemple de connexion à un signal
            onButtonClicked: {
                console.log("Le bouton a été cliqué depuis QML")
            }
        }

        MenuButton {
            id: taille
            buttonText: qsTr("Taille")
        }

        MenuButton {
            id: police
            buttonText: qsTr("Police")
        }

    }



    // Utilisation de MenuButton dans l'interface
       MenuButton {
           id: myButton
           buttonText: "Cliquez-moi"

           // Exemple de connexion à un signal
           onButtonClicked: {
               console.log("Le bouton a été cliqué depuis QML")
           }
       }

       // Bouton visuel avec un MouseArea
       Button {
           text: vueObjetBouton.buttonText  // Utilisation de la propriété vueObjetBouton passée du C++
           anchors.centerIn: parent
           onClicked: vueObjetBouton.triggerAction() // Appel de la méthode C++ depuis QML
       }

    Rectangle {
        id: rectangle
        x: 44
        y: 16
        width: 553
        height: 90
        color: "#ffffff"

        Text {
            id: _text
            text: qsTr("Menu")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 45
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }


}
