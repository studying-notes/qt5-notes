// Generated by [Toolkit-Py](https://github.com/fujiawei-dev/toolkit-py) Generator
// Created at 2022-03-17 10:46:59.925306, Version 0.12.13

Qt.include("http_client.js")

function httpGetExample() {
    HttpClient.get(
        "http://httpbin.org/get",
        function (responseText) {
            console.log(responseText);
        },
        {"q": "typescript"}
    )
}

function httpPostExample() {
    HttpClient.post(
        "http://httpbin.org/post",
        function (responseText) {
            console.log(responseText);
        },
        {"q": "typescript"},
        {"image": "base64", "debug": debugMode},
        {"json": "This is a json object."}
    )
}
