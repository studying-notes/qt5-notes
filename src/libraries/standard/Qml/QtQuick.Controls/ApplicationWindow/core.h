#ifndef APPLICATION_WINDOW__CORE_H
#define APPLICATION_WINDOW__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//APPLICATION_WINDOW__CORE_H
