#include <QBuffer>
#include <QCamera>
#include <QCameraImageCapture>
#include <QCameraInfo>
#include <QCoreApplication>
#include <QImageWriter>
#include <QTimer>

class Core : public QObject {
  Q_OBJECT

public:
  Core(QObject *parent = nullptr) : QObject(parent){};

public slots:
  void run() {
    auto camera = new QCamera;
    auto imageCapture = new QCameraImageCapture(camera);

    // 不保存图片
    imageCapture->setCaptureDestination(QCameraImageCapture::CaptureToBuffer);

    connect(imageCapture, &QCameraImageCapture::imageAvailable, [=](int id, const QVideoFrame &frame) {
      qDebug() << "Image available";
    });

    connect(imageCapture, &QCameraImageCapture::imageCaptured, [=](int id, const QImage &preview) {
      qDebug() << "Image captured:" << id;
      qDebug() << "Image size:" << preview.size();

      QImageWriter writer;
      writer.setFormat("jpg");
      writer.setQuality(100);
      QByteArray ba;
      QBuffer buffer(&ba);
      buffer.open(QIODevice::WriteOnly);
      writer.setDevice(&buffer);
      writer.write(preview);
      buffer.close();
    });

    connect(imageCapture, &QCameraImageCapture::imageSaved, [=](int id, const QString &fileName) {
      qDebug() << "Image saved to" << fileName;
      emit finished();
    });

    camera->setCaptureMode(QCamera::CaptureStillImage);
    camera->start();

    camera->searchAndLock();

    if (imageCapture->isReadyForCapture()) {
      imageCapture->capture();
    }

    camera->unlock();
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
