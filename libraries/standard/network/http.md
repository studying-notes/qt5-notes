---
date: 2022-02-22T09:08:38+08:00
author: "Rustle Karl"

title: "HTTP 请求"
url:  "posts/qt5/libraries/standard/network/http"  # 永久链接
tags: [ "Qt5", "C++" ]  # 标签
series: [ "Qt5 学习笔记" ]  # 系列
categories: [ "学习笔记" ]  # 分类

toc: true  # 目录
draft: false  # 草稿
---

在使用 internet 模块时需要在 pro 文件中添加对应的模块。

Qt 中使用 Http 协议与服务端通信的请求主要分为 GET 和 POST，GET 是从指定的资源请求数据，而 POST 是向指定的资源提交要被处理的数据。

常用的请求类型包括五类:

1. 多个独立参数 GET 请求
2. 参数数组 GET 请求
3. 上传参数数据 POST 请求
4. 上传参数和文件 POST 请求
5. 下载文件 GET 请求

下面通过简单的 Demo 描述五种请求的调用方式。

1. 多个独立参数 GET 请求

```c++
#include <QCoreApplication>
#include <QDebug>
#include <QJsonObject>
#include <QJsonParseError>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QTextCodec>

int main(int argc, char *argv[]) {
    QCoreApplication a(argc, argv);

#if (QT_VERSION <= QT_VERSION_CHECK(5, 0, 0))
#if _MSC_VER
    QTextCodec *codec = QTextCodec::codecForName("GBK");
#else
    QTextCodec *codec = QTextCodec::codecForName("UTF-8");
#endif
    QTextCodec::setCodecForLocale(codec);
    QTextCodec::setCodecForCStrings(codec);
    QTextCodec::setCodecForTr(codec);
#else
    QTextCodec *codec = QTextCodec::codecForName("UTF-8");
    QTextCodec::setCodecForLocale(codec);
#endif

    QNetworkRequest request;
    request.setUrl(QUrl("http://ip.geo.iqiyi.com/cityjson?format=json"));

    QNetworkAccessManager manager;
    QNetworkReply *reply = manager.get(request);

    QEventLoop eventLoop;
    QObject::connect(reply, SIGNAL(finished()), &eventLoop, SLOT(quit()));
    eventLoop.exec(QEventLoop::ExcludeUserInputEvents);

    if (reply->error() != QNetworkReply::NoError) {
        return reply->error();
    }

    QByteArray replyData = reply->readAll();
    QJsonParseError jsonParseError{};
    QJsonDocument jsonDoc(QJsonDocument::fromJson(replyData, &jsonParseError));
    if (jsonParseError.error != QJsonParseError::NoError) {
        return -1;
    }

    QJsonObject rootObj = jsonDoc.object();
    QString codeStr = rootObj.value("code").toString();
    if (codeStr.compare("A00000") == 0) {
        if (rootObj.contains("data")) {
            qDebug() << rootObj.value("data").toObject();
        }
    } else {
        return codeStr.toInt();
    }

    return QCoreApplication::exec();
}
```

2. 参数数组 GET 请求

```c++
int GetRequestWithArray(QVector<QString> m_filePathVector)
{
    QJsonArray array;
    for(int index=0; index<m_filePathVector.size(); ++index)
    {
        QJsonObject object;
        object.insert("index",QString::number(index));
        object.insert("path",m_filePathVector.at(index));
        array.append(object);
    }

    QJsonDocument document;
    document.setArray(array);
    QString arrayString = document.toJson(QJsonDocument::Compact);

    //生成对应的网络请求
    QNetworkRequest request;
    QString scheme = "http";
    QString serverAddr = "192.168.0.1";
    QString port = "80";
    QString requestHeader = scheme + QString("://") + serverAddr + QString(":") + port;
    QString fullRequest = requestHeader + QString("/api/vi/user/getarray?paramers=%1").arg(arrayString);
    request.setUrl(QUrl(fullRequest));

    //获取错误
    QNetworkAccessManager manager;
    QNetworkReply *reply = manager.get(request);
    QEventLoop eventLoop;
    QObject::connect(reply, SIGNAL(finished()),&eventLoop, SLOT(quit()));
    eventLoop.exec(QEventLoop::ExcludeUserInputEvents);
    if(reply->error() != QNetworkReply::NoError)
    {
        return reply->error();
    }

    //解析返回的Json结果
    QByteArray replyData = reply->readAll();
    QJsonParseError json_error;
    QJsonDocument jsonDoc(QJsonDocument::fromJson(replyData, &json_error));
    if(json_error.error != QJsonParseError::NoError)
    {
        return -1;
    }
    QJsonObject rootObj = jsonDoc.object();
    QString codeStr = rootObj.value("code").toString();
    if (codeStr.compare("200") == 0)
    {
        //返回代码为200的时候证明请求成功对包含的结构数据进行处理
        if(rootObj.contains("result"))
        {

        }
        return 0;
    }
    else
    {
        //请求失败对对应的处理
        return codeStr.toInt();
    }
}
```

3. 上传参数数据 POST 请求

```c++
int NormalPostRequest(QString paramer1, QString paramer2)
{
    //生成对应的网址请求
    QNetworkRequest request;
    QString scheme = "http";
    QString serverAddr = "192.168.0.1";
    QString port = "80";
    QString requestHeader = scheme + QString("://") + serverAddr + QString(":") + port;
    QString fullRequest = requestHeader + "/api/v1/user/postrequest";
    request.setUrl(QUrl(fullRequest));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    //获取对应的参数数据
    QByteArray data;
    data.append("paramer1=");
    data.append(paramer1.toUtf8());
    data.append("&paramer2=");
    data.append(paramer2.toUtf8());

    //发送请求
    QNetworkAccessManager manager;
    QNetworkReply *reply = manager.post(request,data);
    QEventLoop eventLoop;
    QObject::connect(reply, SIGNAL(finished()),&eventLoop, SLOT(quit()));
    eventLoop.exec(QEventLoop::ExcludeUserInputEvents);
    if(reply->error() != QNetworkReply::NoError)
    {
        return reply->error();
    }


    //解析返回的Json结果
    QByteArray replyData = reply->readAll();
    QJsonParseError json_error;
    QJsonDocument jsonDoc(QJsonDocument::fromJson(replyData, &json_error));
    if(json_error.error != QJsonParseError::NoError)
    {
        return -1;
    }
    QJsonObject rootObj = jsonDoc.object();
    QString codeStr = rootObj.value("code").toString();
    if (codeStr.compare("200") == 0)
    {
        //返回代码为200的时候证明请求成功对包含的结构数据进行处理
        if(rootObj.contains("result"))
        {

        }
        return 0;
    }
    else
    {
        //请求失败对对应的处理
        return codeStr.toInt();
    }
}        
```

4. 上传参数和文件 POST 请求

```c++
int PostRequestWithFile(QString paramer1, QString paramer2,QString filePath)
{

    //生成对应的网址请求
    QFileInfo fileInfo(filePath);
    QString fileName =fileInfo.fileName();

    QFile* inputFile = new QFile(filePath);
    inputFile->open(QIODevice::ReadOnly);

    //multipart请求
    QHttpMultiPart* multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);
    //文件块
    QHttpPart filePart;
    filePart.setHeader(QNetworkRequest::ContentDispositionHeader,
                                 QVariant(QString("form-data; name="uploadfile";filename="%1"").arg(fileName)));
    filePart.setBodyDevice(inputFile);
    inputFile->setParent(multiPart);
    multiPart->append(filePart);

    QHttpPart paramer1Part;
    paramer1Part.setHeader(QNetworkRequest::ContentDispositionHeader,QVariant("form-data; name="paramer1""));
    paramer1Part.setBody(paramer1.toUtf8());
    multiPart->append(paramer1Part);

    QHttpPart paramer2Part;
    paramer2Part.setHeader(QNetworkRequest::ContentDispositionHeader,QVariant("form-data; name="paramer2""));
    paramer2Part.setBody(paramer2.toUtf8());
    multiPart->append(paramer2Part);


    //生成对应的网址请求
    QNetworkRequest request;
    QString scheme = "http";
    QString serverAddr = "192.168.0.1";
    QString port = "80";
    QString requestHeader = scheme + QString("://") + serverAddr + QString(":") + port;
    QString fullRequest = requestHeader + "/api/v1/user/postrequestwithfile";
    request.setUrl(QUrl(fullRequest));

    //发送请求
    QNetworkAccessManager manager;
    QNetworkReply *reply = manager.post(request,multiPart);
    multiPart->setParent(reply);

    QEventLoop eventLoop;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)),&eventLoop, SLOT(quit()));
    eventLoop.exec(QEventLoop::ExcludeUserInputEvents);

    if(reply->error() != QNetworkReply::NoError)
    {
        return reply->error();
    }

    //解析返回的Json结果
    QByteArray replyData = reply->readAll();
    QJsonParseError json_error;
    QJsonDocument jsonDoc(QJsonDocument::fromJson(replyData, &json_error));
    if(json_error.error != QJsonParseError::NoError)
    {
        return -1;
    }
    QJsonObject rootObj = jsonDoc.object();
    QString codeStr = rootObj.value("code").toString();
    if (codeStr.compare("200") == 0)
    {
        //返回代码为200的时候证明请求成功对包含的结构数据进行处理
        if(rootObj.contains("result"))
        {

        }
        return 0;
    }
    else
    {
        //请求失败对对应的处理
        return codeStr.toInt();
    }
}
```

5. 下载文件 GET 请求

```c++
int DownloadFileFromWeb(QString fileUrl,QString&fileSavePath)
{
    QNetworkRequest request;
    QUrl url(fileUrl);
    QFileInfo fileInfo(url.path());
    QString fileName = fileInfo.fileName();
    QNetworkAccessManager *accessManager=new QNetworkAccessManager();
    request.setUrl(url);
    QNetworkReply *reply  = accessManager->get(request);
    QEventLoop loop;
    QObject::connect(accessManager, SIGNAL(finished(QNetworkReply*)), &loop, SLOT(quit()));
//如果需要下载进度需要关联对应的信号
//connect(reply, SIGNAL(downloadProgress(qint64, qint64)), this, SLOT(LoadProgress(qint64, qint64)));
    loop.exec(QEventLoop::ExcludeUserInputEvents);

    //获取下载返回值
    QVariant statusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    if (statusCode.toInt() != 200)
    {
        return -1;
    }

    //保存下载的文件
    QFile file(fileSavePath);
    if(!file.open(QIODevice::WriteOnly))
    {
        return -2;
    }
    file.write(reply->readAll());
    file.close();
    return 0;
}
```
