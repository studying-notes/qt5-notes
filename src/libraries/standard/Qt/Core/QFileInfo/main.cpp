#include <QCoreApplication>
#include <QDebug>
#include <QDir>
#include <QFileInfo>
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
    //    QFileInfo info1("C:/Windows/Temp/1.jpg");
    //    qDebug() << info1.isSymLink();
    //    qDebug() << info1.absoluteFilePath();
    //    qDebug() << info1.size();
    //    qDebug() << info1.symLinkTarget();

    QDir jpg("C:/Windows/Temp");
    QFileInfo jpg1("C:/Windows/Temp/1.jpg");
    QFileInfo jpg2("C:/Windows/Temp/2.jpg");
    qDebug() << (jpg1.dir() == jpg);

    //    QFileInfo info2(info1.symLinkTarget());
    //    qDebug() << info2.isSymLink();
    //    qDebug() << info2.absoluteFilePath();
    //    qDebug() << info2.size();

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
