#ifndef QT_OBJECT__CORE_H
#define QT_OBJECT__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//QT_OBJECT__CORE_H
