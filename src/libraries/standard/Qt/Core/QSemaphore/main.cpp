#include <QCoreApplication>
#include <QDebug>
#include <QSemaphore>
#include <QTimer>

class Core : public QObject {
  Q_OBJECT

public:
  Core(QObject *parent = nullptr) : QObject(parent){};

public slots:
  void run() {
    QSemaphore sem(5);      // sem.available() == 5

    sem.acquire(3);         // sem.available() == 2
    sem.acquire(2);         // sem.available() == 0
    sem.release(5);         // sem.available() == 5
    sem.release(5);         // sem.available() == 10

    sem.tryAcquire(1);      // sem.available() == 9, returns true
    sem.tryAcquire(250);    // sem.available() == 9, returns false

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
