#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include <QFileInfo>
#include <QCoreApplication>
#include "gamecontroller.h"
#include "menubutton.h"
#include "colorpicker.h"

int main(int argc, char *argv[])
{
    // Définir le style via une variable d'environnement avant de créer l'application
    qputenv("QT_QUICK_CONTROLS_STYLE", "Fusion");

    QGuiApplication app(argc, argv);

    Bouton aButton;

    // Créer une instance de ColorPicker
    ColorPicker colorPicker;

    // Créer l'objet QQmlApplicationEngine
    QQmlApplicationEngine engine;

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    // Enregistrer les objets pour les utiliser dans QML
    engine.rootContext()->setContextProperty("vueObjetBtn", &aButton);
    engine.rootContext()->setContextProperty("colorPicker", &colorPicker);

    // Créer et enregistrer le contrôleur de jeu
    GameController* controller = new GameController();
    engine.rootContext()->setContextProperty("gameController", controller);

    // Charger le fichier QML principal
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/Projet/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
