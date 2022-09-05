#ifndef CHECK_BOX_FLAT__CORE_H
#define CHECK_BOX_FLAT__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//CHECK_BOX_FLAT__CORE_H
