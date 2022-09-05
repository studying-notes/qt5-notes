#ifndef TEXT_FIELD_FLAT__CORE_H
#define TEXT_FIELD_FLAT__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);
};

#endif//TEXT_FIELD_FLAT__CORE_H
