#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include <QFileInfo>
#include <QCoreApplication>
#include "gamecontroller.h"
#include "menubutton.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    Bouton aButton ;
    // Créer l'objet QQmlApplicationEngine
    QQmlApplicationEngine engine;

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("vueObjetBtn", &aButton);

    GameController* controller = new GameController();
    engine.rootContext()->setContextProperty("gameController", controller);


    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/Projet/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}


