#include <QDir>
#include <QUrl>

#include "core.h"

Core::Core(QObject *parent) : QObject(parent) {}

QString Core::convertUrlToNativeFilePath(const QUrl& urlStylePath) {
  return QDir::toNativeSeparators(urlStylePath.toLocalFile());
}
