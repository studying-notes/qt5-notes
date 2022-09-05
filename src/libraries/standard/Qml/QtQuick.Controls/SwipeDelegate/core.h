#ifndef SWIPE_DELEGATE__CORE_H
#define SWIPE_DELEGATE__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//SWIPE_DELEGATE__CORE_H
