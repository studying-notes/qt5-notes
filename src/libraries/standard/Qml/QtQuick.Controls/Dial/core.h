#ifndef DIAL__CORE_H
#define DIAL__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//DIAL__CORE_H
