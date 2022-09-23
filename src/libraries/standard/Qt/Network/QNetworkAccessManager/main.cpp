#include <QCoreApplication>
#include <QFile>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonParseError>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QTimer>

typedef std::uint64_t hash_t;

constexpr hash_t prime = 0x100000001B3ull;
constexpr hash_t basis = 0xCBF29CE484222325ull;

hash_t hash_(std::string_view str) {
  hash_t ret{basis};
  for (auto c : str) {
    ret ^= c;
    ret *= prime;
  }
  return ret;
}

constexpr hash_t hash(std::string_view str, hash_t last = basis) {
  return !str.empty() ? hash(str.substr(1), (str[0] ^ last) * prime) : last;
}

constexpr unsigned long long operator"" _hash(char const *p, size_t) {
  return hash(p);
}

class Core : public QObject {
  Q_OBJECT

public:
  Core(QObject *parent = nullptr) : QObject(parent){};

public slots:
  void run() {
    qDebug() << "SSL Library Build Version" << QSslSocket::sslLibraryBuildVersionString();

    auto *manager = new QNetworkAccessManager();

    connect(manager, &QNetworkAccessManager::finished, [=](QNetworkReply *reply) {
      qDebug() << "Reply received";
      QJsonObject responseJson;
      if (reply->error() == QNetworkReply::NoError) {
        QJsonParseError jsonError{};
        QJsonDocument jsonResponse = QJsonDocument::fromJson(reply->readAll(), &jsonError);
        if (jsonError.error == QJsonParseError::NoError) {
          responseJson = jsonResponse.object();
        }
      }

      QFile file("response.json");
      file.open(QIODevice::WriteOnly);
      file.write(QJsonDocument(responseJson).toJson());
      file.close();

      auto code = responseJson["code"].toInt();
      auto message = responseJson["message"].toString();

      if (code == 0) {
        qDebug() << "Success";
      } else {
        qDebug() << "Error" << message;
      }

      auto result = responseJson["result"].toObject();
      auto item_list = result["item_list"].toArray();

      for (auto item : item_list) {
        auto item_obj = item.toObject();
        auto key = item_obj["key"].toString();
        auto value = item_obj["value"].toString();
        switch (hash_(key.toStdString())) {
        case "passport_number"_hash:
          qDebug() << "Passport number" << value;
          break;
        case "name"_hash:
          qDebug() << "Name" << value;
          break;
        case "sex"_hash:
          qDebug() << "Sex" << value;
          break;
        case "birthday"_hash:
          qDebug() << "Birthday" << value;
          break;
        case "validity"_hash:
          qDebug() << "Validity" << value;
          break;
        case "passport_line1"_hash:
          qDebug() << "Passport line1" << value;
          break;
        case "passport_line2"_hash:
          qDebug() << "Passport line2" << value;
          break;
        case "country_code"_hash:
          qDebug() << "Country code" << value;
          break;
        case "head_portrait"_hash:
          QFile portrait("head_portrait.jpg");
          portrait.open(QIODevice::WriteOnly);
          portrait.write(QByteArray::fromBase64(value.toUtf8()));
          portrait.close();
          break;
        }
      }

      emit finished();
    });

    QNetworkRequest request;
    request.setUrl(QUrl("https://api.textin.com/robot/v1.0/api/passport"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "image/jpeg");
    request.setRawHeader("x-ti-app-id", "59dc5f9738d6dce87d630b6b2c380492");
    request.setRawHeader("x-ti-secret-code", "387c70861bdab85474c8b31f980b7e99");

    QFile file("C:/Users/Admin/Pictures/IMG_00000007.jpg");
    file.open(QIODevice::ReadOnly);
    QByteArray data = file.readAll();
    file.close();

    manager->post(request, data);
  };

signals:
  void finished();
};

#include "main.moc"

int main(int argc, char *argv[]) {
  QCoreApplication app(argc, argv);

  Core *core = new Core(&app);
  // Only for console app. This will run from the application event loop.
  QObject::connect(core, SIGNAL(finished()), &app, SLOT(quit()));
  QTimer::singleShot(0, core, SLOT(run()));

  return QCoreApplication::exec();
}
