#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QUrl>

int main(int argc, char *argv[]) {
    qputenv("QT_QPA_PLATFORM", "wayland");
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [](QObject *obj, const QUrl &objUrl) {
        if (!obj) QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    
    engine.load(QUrl::fromLocalFile("main.qml"));
    return app.exec();
}
