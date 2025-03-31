#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
<<<<<<< Updated upstream
#include "menubutton.h"

=======
#include <QDir>
#include <QFileInfo>
#include <QCoreApplication>
#include "gamecontroller.h"
#include "menubutton.h"
>>>>>>> Stashed changes

    int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
<<<<<<< Updated upstream
    Bouton aButton ;
=======
      Bouton aButton ;
>>>>>>> Stashed changes
    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("vueObjetBtn", &aButton);
    engine.loadFromModule("Projet", "InterfaceMenu");

<<<<<<< Updated upstream
=======
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

>>>>>>> Stashed changes
    return app.exec();
}



