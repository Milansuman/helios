#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebEngineQuick>

int main(int argc, char **argv){
    QtWebEngineQuick::initialize();
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    engine.load(":/qml/main.qml");

    return app.exec();
}