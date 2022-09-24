
#include <QCoreApplication>
#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QTimer>

void login(const QString &username, const QString &password) {
  QNetworkAccessManager *manager = new QNetworkAccessManager;
  QNetworkRequest request;
  request.setUrl(QUrl("http://192.168.0.16:28082/get"));
  request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
  request.setHeader(QNetworkRequest::ContentLengthHeader, 0);
  request.setRawHeader("username", username.toUtf8());
  request.setRawHeader("password", password.toUtf8());

  QNetworkReply *reply = manager->get(request);

  QObject::connect(reply, &QNetworkReply::finished, [=]() {
    qDebug() << reply->readAll();
    reply->deleteLater();
  });

  QEventLoop loop;
  QObject::connect(reply, &QNetworkReply::finished, [&loop]() {
    loop.quit();
  });

  loop.exec();
}

class Core : public QObject {
  Q_OBJECT

public:
  Core(QObject *parent = nullptr) : QObject(parent){};

public slots:
  void run() {
    login("admin", "admin");
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
