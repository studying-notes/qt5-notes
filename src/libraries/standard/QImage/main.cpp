#include <QCoreApplication>
#include <QDebug>
#include <QFileInfo>
#include <QImage>
#include <QTimer>
#include <QTransform>

class Task : public QObject {
    Q_OBJECT
public:
    Task(QObject *parent = nullptr) : QObject(parent) {}

public slots:
    void run() {
        qInfo() << "Running...";

        QString assetsImagesPath = "assets/images/";

        // https://doc.qt.io/qt-5/qimage.html
        QFileInfo image(assetsImagesPath + "ToolkitPy_logo.png");
        QString originalImagePath = image.absoluteFilePath();

        QImage originalImage;
        if (originalImage.load(originalImagePath)) {
            QTransform rotateTransform;
            rotateTransform.rotate(180);
            QImage rotate180Image = originalImage.transformed(rotateTransform);
            rotate180Image.save(assetsImagesPath + "p_rotate180Image.jpg");

            QImage mirroredImage = originalImage.mirrored(true, true);
            mirroredImage.save(assetsImagesPath + "p_mirroredImage.jpg");
        } else {
            qCritical() << originalImagePath << "not found";
        }

        emit finished();

        qInfo() << "I thought I'd finished!";
    }

signals:
    void finished();
};

#include "main.moc"

int main(int argc, char *argv[]) {
    QCoreApplication a(argc, argv);

    // Task  parented to the application so that it will be deleted by the application.
    Task *task = new Task(&a);

    // This will cause the application to exit when the task signals finished.
    QObject::connect(task, SIGNAL(finished()), &a, SLOT(quit()));

    // This will run the task from the application event loop.
    QTimer::singleShot(0, task, SLOT(run()));

    return QCoreApplication::exec();
}
