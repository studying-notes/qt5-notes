// Generated by [Toolkit-Py](https://github.com/fujiawei-dev/toolkit-py) Generator
// Created at 2022-03-16 10:44:00.927840, Version 0.12.13
var HttpClient = /** @class */ (function () {
    function HttpClient() {
    }
    HttpClient.get = function (url, callback, params) {
        if (callback === void 0) { callback = function (responseText) {
            console.log(JSON.stringify(responseText));
        }; }
        if (params === void 0) { params = {}; }
        HttpClient.request(url, "GET", callback, params);
    };
    HttpClient.post = function (url, callback, params, data, json) {
        if (callback === void 0) { callback = function (responseText) {
            console.log(JSON.stringify(responseText));
        }; }
        if (params === void 0) { params = {}; }
        if (data === void 0) { data = {}; }
        if (json === void 0) { json = {}; }
        HttpClient.request(url, "POST", callback, params, data, json);
    };
    // I can't understand. Since all parameters must be passed, what is the meaning of default parameters?
    HttpClient.request = function (url, method, callback, params, data, json) {
        if (method === void 0) { method = "GET"; }
        if (callback === void 0) { callback = function (responseText) {
            console.log(JSON.stringify(responseText));
        }; }
        if (params === void 0) { params = {}; }
        if (data === void 0) { data = {}; }
        if (json === void 0) { json = {}; }
        method = method.toUpperCase();
        var query = [];
        for (var key in params) {
            if (params.hasOwnProperty(key)) {
                query.push(key + "=" + params[key]);
            }
        }
        for (var key in data) {
            if (data.hasOwnProperty(key)) {
                query.push(key + "=" + data[key]);
            }
        }
        if (query.length > 0) {
            url += "?" + query.join("&");
        }
        console.log(method + " " + url);
        var client = new XMLHttpRequest();
        client.onreadystatechange = function () {
            if (client.readyState === client.DONE) {
                var responseText = client.responseText.toString();
                console.log("response=" + responseText);
                callback(responseText);
            }
        };
        client.open(method, url, true);
        if (method !== "GET") {
            var requestBody = JSON.stringify(json);
            if (requestBody !== "{}") {
                client.setRequestHeader("Content-Type", "application/json");
                console.log("request=" + requestBody);
                client.send(requestBody);
            }
            else {
                client.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                client.send();
            }
        }
        else {
            client.send();
        }
    };
    return HttpClient;
}());
