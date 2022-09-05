#ifndef FILE_DIALOG__CORE_H
#define FILE_DIALOG__CORE_H

#include <QDebug>
#include <QObject>

class Core : public QObject {
  Q_OBJECT

public:
  explicit Core(QObject *parent = nullptr);

  Q_INVOKABLE static QString convertUrlToNativeFilePath( const QUrl& urlStylePath) ;
};

#endif//FILE_DIALOG__CORE_H
