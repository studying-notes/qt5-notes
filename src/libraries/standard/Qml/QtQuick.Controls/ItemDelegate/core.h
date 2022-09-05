#ifndef ITEM_DELEGATE__CORE_H
#define ITEM_DELEGATE__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//ITEM_DELEGATE__CORE_H
