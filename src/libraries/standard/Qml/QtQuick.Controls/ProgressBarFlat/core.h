#ifndef PROGRESS_BAR_FLAT__CORE_H
#define PROGRESS_BAR_FLAT__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//PROGRESS_BAR_FLAT__CORE_H
