// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threeclick/api/api_client.dart';
import 'package:threeclick/constants/app_urls.dart';
import 'package:threeclick/custom/toast_message.dart';
import 'package:threeclick/models/common/login_data_model.dart';
import 'package:threeclick/models/common/server_error.dart';

class LoginProvider extends ChangeNotifier {
  final SharedPreferences _preferences;

  LoginDataModel _userData = LoginDataModel();
  LoginDataModel get userData => _userData;

  String? _token;
  String? get token => _token;

  bool _showLoader = false;
  bool get showLoader => _showLoader;

  bool get isUserLoggedIn {
    var userDetails = _preferences.getString("userDetails") ?? "";
    if (userDetails == "") {
      return false;
    } else {
      return true;
    }
  }

  LoginProvider(this._preferences) {
    _token = _preferences.getString("token");
    var userDetails = _preferences.getString("userDetails") ?? "";
    if (userDetails == "") {
    } else {
      Map<String, dynamic> userDetail = jsonDecode(userDetails);
      _userData = LoginDataModel.fromJson(userDetail);
    }
  }

  _setShowLoader(bool status) {
    _showLoader = status;
    notifyListeners();
  }

  setDataToPreferences(LoginDataModel data) {
    _preferences.setString("token", data.response?.token ?? "");
    _preferences.setString("userDetails", jsonEncode(data));
    notifyListeners();
  }

 

  Future<bool> loginApp(Map<String, dynamic> body,
      {Map<String, String>? headers, required BuildContext context}) async {
    _setShowLoader(true);
    try {
      var result = await ApiClient.postApi(
          body: body,
          context: context,
          url: appUrls.loginUrl,
          headers: headers);

      var loginData = LoginDataModel.fromJson(result.data);
      _preferences.setString("token", loginData.response?.token ?? "");

      _preferences.setString("userDetails", jsonEncode(loginData));
      Map<String, dynamic> userDetail =
          jsonDecode(_preferences.get("userDetails").toString());
      _userData = LoginDataModel.fromJson(userDetail);
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      if (e is ServerError) {
        showToast(e.message.toString());
        _setShowLoader(false);
        notifyListeners();
        return false;
      }
    }
    _setShowLoader(false);
    notifyListeners();
    return false;
  }

  Future<bool> logOut(
      {Map<String, String>? headers, required BuildContext context}) async {
    _setShowLoader(true);
    try {
      Map<String, dynamic> userDetail =
          jsonDecode(_preferences.get("userDetails").toString());
      _userData = LoginDataModel.fromJson(userDetail);
      _preferences.remove("userDetails");
      _preferences.remove("RouteList");
      _userData = LoginDataModel();
      _token = null;
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      if (e is ServerError) {
        // _errorMessage = e.message;
      }
    }
    _setShowLoader(false);
    notifyListeners();
    return false;
  }

  
}
