#include <QCamera>
#include <QCameraInfo>
#include <QCoreApplication>
#include <QTimer>

class Core : public QObject {
  Q_OBJECT

public:
  Core(QObject *parent = nullptr) : QObject(parent){};

public slots:
  void run() {
    QCamera *camera;
    QString cameraName = R"(@device:pnp:\\?\usb#vid_1bcf&pid_c002&mi_00#7&2827e01b&0&0000#{65e8773d-8f56-11d0-a3b9-00a0c9223196}\global)";

    const QList<QCameraInfo> cameras = QCameraInfo::availableCameras();
    for (const QCameraInfo &cameraInfo : cameras) {
      if (cameraInfo.deviceName() == cameraName) {
        qDebug() << "Found camera";
        camera = new QCamera(cameraInfo);
      }

      qDebug() << "------------------------------------------------------------------";
      qDebug() << "Camera name:" << cameraInfo.deviceName();
      qDebug() << "Camera description:" << cameraInfo.description();
    }

    qDebug() << "------------------------------------------------------------------";

    qDebug() << "Camera capture mode:" << camera->captureMode();
    qDebug() << "Camera lock status:" << camera->lockStatus();
    qDebug() << "Camera state:" << camera->state();
    qDebug() << "Camera status:" << camera->status();
    qDebug() << "------------------------------------------------------------------";

    camera->start();

    qDebug() << "Camera capture mode:" << camera->captureMode();
    qDebug() << "Camera lock status:" << camera->lockStatus();
    qDebug() << "Camera state:" << camera->state();
    qDebug() << "Camera status:" << camera->status();
    qDebug() << "------------------------------------------------------------------";

    camera->stop();

    emit finished();
  };

signals:
  void finished();
};

#include "main.moc"

int main(int argc, char *argv[]) {
  QCoreApplication app(argc, argv);

  Core *core = new Core(&app);
  // Only for console app. This will run from the application event loop.
  QObject::connect(core, SIGNAL(finished()), &app, SLOT(quit()));
  QTimer::singleShot(0, core, SLOT(run()));

  return QCoreApplication::exec();
}
