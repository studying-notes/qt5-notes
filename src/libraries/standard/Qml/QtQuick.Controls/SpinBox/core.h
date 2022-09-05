#ifndef SPIN_BOX__CORE_H
#define SPIN_BOX__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//SPIN_BOX__CORE_H
