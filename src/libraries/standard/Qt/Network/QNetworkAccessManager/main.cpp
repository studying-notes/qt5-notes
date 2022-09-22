#include <QCoreApplication>
#include <QDebug>
#include <QFile>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QTimer>

class Core : public QObject {
  Q_OBJECT

public:
  Core(QObject *parent = nullptr) : QObject(parent){};

public slots:
  void run() {
    qDebug() << "SSL Library Build Version" << QSslSocket::sslLibraryBuildVersionString();

    QNetworkAccessManager *manager = new QNetworkAccessManager();

    connect(manager, &QNetworkAccessManager::finished, [=](QNetworkReply *reply) {
      qDebug() << "Reply received";
      qDebug() << reply->readAll();
      emit finished();
    });

    QNetworkRequest request;
    request.setUrl(QUrl("https://api.textin.com/robot/v1.0/api/passport"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "image/jpeg");
    request.setRawHeader("x-ti-app-id", "59dc5f9738d6dce87d630b6b2c380492");
    request.setRawHeader("x-ti-secret-code", "387c70861bdab85474c8b31f980b7e99");

    QFile file("C:/Users/Admin/Pictures/IMG_00000007.jpg");
    file.open(QIODevice::ReadOnly);
    QByteArray data = file.readAll();
    file.close();

    manager->post(request, data);
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
