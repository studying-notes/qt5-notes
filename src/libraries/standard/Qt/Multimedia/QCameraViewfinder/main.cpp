#include <QApplication>
#include <QCamera>
#include <QCameraImageCapture>
#include <QCameraInfo>
#include <QCameraViewfinder>
#include <QCoreApplication>
#include <QTimer>

class Core : public QObject {
  Q_OBJECT

public:
  Core(QObject *parent = nullptr) : QObject(parent){};

public slots:
  void run() {
    auto camera = new QCamera;
    auto imageCapture = new QCameraImageCapture(camera);

    connect(imageCapture, &QCameraImageCapture::imageCaptured, [=](int id, const QImage &preview) {
      qDebug() << "Image captured";
    });

    connect(imageCapture, &QCameraImageCapture::imageSaved, [=](int id, const QString &fileName) {
      qDebug() << "Image saved to" << fileName;
      emit finished();
    });

    auto viewfinder = new QCameraViewfinder();
    viewfinder->show();
    camera->setViewfinder(viewfinder);
    camera->setCaptureMode(QCamera::CaptureStillImage);
    camera->start();

    QTimer::singleShot(3000, [=]() {
      camera->searchAndLock();

      if (imageCapture->isReadyForCapture()) {
        imageCapture->capture();
      }

      camera->unlock();
    });
  };

signals:
  void finished();
};

#include "main.moc"

int main(int argc, char *argv[]) {
  QApplication app(argc, argv);

  Core *core = new Core(&app);
  // Only for console app. This will run from the application event loop.
  QObject::connect(core, SIGNAL(finished()), &app, SLOT(quit()));
  QTimer::singleShot(0, core, SLOT(run()));

  return QApplication::exec();
}
