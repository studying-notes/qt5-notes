#ifndef PAGE_INDICATOR__CORE_H
#define PAGE_INDICATOR__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//PAGE_INDICATOR__CORE_H
