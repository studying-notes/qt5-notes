#ifndef SPIN_BOX_FLAT__CORE_H
#define SPIN_BOX_FLAT__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//SPIN_BOX_FLAT__CORE_H
