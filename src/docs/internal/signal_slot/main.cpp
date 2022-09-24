#pragma once
#include <algorithm>
#include <functional>
#include <iostream>
#include <vector>

template<typename ObserverType>
class Subject {
public:
  void subscribe(ObserverType *obs) {
    auto o = std::find(m_observerList.begin(), m_observerList.end(), obs);
    if (m_observerList.end() == o) {
      m_observerList.push_back(obs);
    }
    std::cout << "subscribe: " << obs << std::endl;
  }

  void unsubscribe(ObserverType *obs) {
    m_observerList.erase(std::remove(m_observerList.begin(), m_observerList.end(), obs));
    std::cout << "unsubscribe: " << obs << std::endl;
  }

  template<typename FuncType>
  void publish(FuncType func) {
    for (auto obs : m_observerList) {
      func(obs);
    }
  }

private:
  std::vector<ObserverType *> m_observerList;
};

class AObserver {
public:
  virtual void onA() = 0;
  virtual ~AObserver() = default;
};

class B : public Subject<AObserver> {
public:
  void run() {
    std::cout << "B::run" << std::endl;
    //    publish(std::bind(&AObserver::onA, std::placeholders::_1));
    publish([](auto &&PH1) { PH1->onA(); });
  }
};

class A : public AObserver {
public:
  void onA() override {
    RunAway();
  }

  void RunAway() {
    std::cout << "A::RunAway" << std::endl;
  }
};

int main() {
  B b;
  A a;
  b.subscribe(&a);
  b.run();
  return 0;
}

//#include <QCoreApplication>
//#include <QDebug>
//#include <QNetworkAccessManager>
//#include <QNetworkReply>
//#include <QNetworkRequest>
//#include <QTimer>
//
//class Core : public QObject {
//  Q_OBJECT
//
//public:
//  Core(QObject *parent = nullptr) : QObject(parent){};
//
//public slots:
//  void run() {
//    emit finished();
//  };
//
//signals:
//  void finished();
//};
//
//#include "main.moc"
//
//int main(int argc, char *argv[]) {
//  QCoreApplication app(argc, argv);
//
//  Core *core = new Core(&app);
//  // Only for console app. This will run from the application event loop.
//  QObject::connect(core, SIGNAL(finished()), &app, SLOT(quit()));
//  QTimer::singleShot(0, core, SLOT(run()));
//
//  return QCoreApplication::exec();
//}
