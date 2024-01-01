import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qtecsolutiontask/components.dart';
import 'package:qtecsolutiontask/controllers/data_controller.dart';
import 'package:qtecsolutiontask/dev_function/dev_print.dart';
import 'package:qtecsolutiontask/services/user_message/snackbar.dart';

class HttpCall {
  final DataController _controller = Get.find();

  String _cookie = "";
  final Map<String, String> _header = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<http.Response> __catchCookie(Function function) async {
    http.Response res = await function();
    if (res.headers['set-cookie'] != null) _cookie = res.headers['set-cookie']!.split(';')[0].trim();
    return res;
  }

  //! Get
  Future<http.Response> get(String url,
      {bool isAuthServer = false, String? token, Map<String, String>? headerParameter, bool addCookie = false, String? link}) async {
    if (kDebugMode) showToast(title: null, message: url);

    final Map<String, String> header = {};

    header.addAll(headerParameter ?? _header); // adding head

    // if ((token) != null || _controller.localData.localDataModel.userData.value.token.isNotEmpty) {
    //   header.addAll({
    //     HttpHeaders.authorizationHeader: token ?? _controller.localData.localDataModel.userData.value.token // adding token
    //   });
    // }

    if (addCookie) {
      header.addAll({
        'Cookie': _cookie // adding cookie
      });
    }

    String sendLink = (link ?? (baseLink)) + url;
    devPrint("HttpCall: Requesting: Get------------------------------------------------------------- $sendLink");
    http.Response res = await __catchCookie(() async => await http.get(Uri.parse(sendLink), headers: header).timeout(apiCallTimeOut));
    devPrint(
        "HttpCall: Response: GET ------------------------------------------------------------ $sendLink --- Status Code: ${res.statusCode} --- Data: ${res.body}");

    return res;
  }

  // Future<http.Response> post(String url,
  //     {bool isAuthServer = false,
  //     String? token,
  //     Map<String, String>? headerParameter,
  //     bool addCookie = false,
  //     Map<String, dynamic>? body,
  //     String? link,
  //     bool doEncode = true}) async {
  //   if (kDebugMode) showToast(title: null, message: url);
  //
  //   final Map<String, String> header = {};
  //
  //   header.addAll(headerParameter ?? _header); // adding head
  //
  //   if ((token) != null || _controller.localData.localDataModel.userData.value.token.isNotEmpty) {
  //     header.addAll({
  //       HttpHeaders.authorizationHeader: token ?? _controller.localData.localDataModel.userData.value.token // adding token
  //     });
  //   }
  //
  //   if (addCookie) {
  //     header.addAll({
  //       'Cookie': _cookie // adding cookie
  //     });
  //   }
  //
  //   String sendLink = (link ?? (isAuthServer ? baseLinkAuth : baseLink)) + url;
  //   devPrint("HttpCall: Requesting: POST ------------------------------------------------------------ $sendLink Body: ${jsonEncode(body)}");
  //   http.Response res = await __catchCookie(() async =>
  //       await http.post(Uri.parse(sendLink), headers: doEncode ? header : null, body: doEncode ? jsonEncode(body) : body).timeout(apiCallTimeOut));
  //   devPrint(
  //       "HttpCall: Response: POST ------------------------------------------------------------ $sendLink --- Status Code: ${res.statusCode} --- Data: ${res.body}");
  //
  //   return res;
  // }
}
