#include <QCoreApplication>
#include <QDebug>
#include <QDir>
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

    QDir jpg("C:/Windows/Temp");
    QDir jpg1("C:/Windows/Temp/1.jpg");
    QDir jpg2("C:/Windows/Temp/2.jpg");

    qDebug() << jpg1;
    qDebug() << jpg2;
    qDebug()<< jpg1.dirName();

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
