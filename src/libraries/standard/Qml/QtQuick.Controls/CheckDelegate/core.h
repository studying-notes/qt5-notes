#ifndef CHECK_DELEGATE__CORE_H
#define CHECK_DELEGATE__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//CHECK_DELEGATE__CORE_H
