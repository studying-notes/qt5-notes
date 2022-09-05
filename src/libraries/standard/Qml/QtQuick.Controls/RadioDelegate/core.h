#ifndef RADIO_DELEGATE__CORE_H
#define RADIO_DELEGATE__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//RADIO_DELEGATE__CORE_H
