import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:threeclick/constants/app_urls.dart';
import 'package:threeclick/models/common/server_error.dart';

class ApiClient {
  static Future<dynamic> postApi(
      {BuildContext? context,
      required String url,
      required Map<String, dynamic> body,
      Map<String, String>? headers}) async {
    debugPrint('Url: ${appUrls.baseUrl}$url');
    debugPrint('body: $body');

    Response response = await post(
      Uri.parse(
        '${appUrls.baseUrl}$url',
      ),
      headers: headers,
      body: body,
    );
    debugPrint("data: ${response.body}");

    if (response.statusCode == 200) {
      // var data = ResponseModel.fromJson(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      // navigateRemoveUntil(context: context!, to: const Login());
    } else {
      throw ServerError(response.statusCode, jsonDecode(response.body));
    }
  }

  static Future<dynamic> getApi({
    required BuildContext context,
    required String url,
    Map<String, String>? headers,
  }) async {
    debugPrint('Url: ${appUrls.baseUrl}$url');
    debugPrint('Header: $headers');
    try {
      Response response = await get(
          Uri.parse(
            '${appUrls.baseUrl}$url',
          ),
          headers: headers);
      debugPrint("data: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        // navigateRemoveUntil(context: context, to: const Login());
      } else {
        // throw ServerError(
        //     response.statusCode, jsonDecode(response.body)['errors']);
      }
    } catch (e) {
      // showToast('Server Error.');
    }
  }

  static Future<dynamic> uploadFileWithAdditionalData(
      {required BuildContext context,
      required String url,
      required List<File?>? file,
      required List<String> fileKey,
      required Map<String, dynamic> body,
      Map<String, String>? headers}) async {
    debugPrint('Url: ${appUrls.baseUrl}$url');

    var request = MultipartRequest(
      'POST',
      Uri.parse(
        '${appUrls.baseUrl}$url',
      ),
    );
    // request.headers.addAll(headers!);
    if (file != null) {
      for (int i = 0; i < file.length; i++) {
        String fieldName = fileKey[i];
        String fileName = file[i]!.path.split('/').last;
        List<int> fileBytes = await file[i]!.readAsBytes();
        request.files.add(MultipartFile.fromBytes(
          fieldName,
          fileBytes,
          filename: fileName,
        ));
      }
    }

    body.forEach((key, value) {
      request.fields[key] = value;
    });
    debugPrint('body: $body');

    StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    debugPrint("data: $result");

    if (response.statusCode == 200) {
      return jsonDecode(result);
    } else if (response.statusCode == 401) {
      // navigateRemoveUntil(context: context, to: const Login());
    } else {
      throw ServerError(response.statusCode, jsonDecode(result)['message']);
    }
  }
}
