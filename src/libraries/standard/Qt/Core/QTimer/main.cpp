#include <QCoreApplication>
#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QTimer>

class Core : public QObject {
  Q_OBJECT

public:
  Core(QObject *parent = nullptr) : QObject(parent) {
    auto *baseTimer = new QTimer(this);

    connect(baseTimer, &QTimer::timeout, this, [this]() {
      qDebug() << "Time runs out";
      emit finished();
    });

    baseTimer->start(30000);
  };

public slots:
  void run(){
    QTimer::singleShot(1000, this, [](){
      qDebug() << "singleShot 1000";
    });
  };

signals:
  void finished();

private:
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
