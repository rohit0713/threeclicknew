import 'dart:io';

import 'package:flutter/material.dart';
import 'package:threeclick/api/api_client.dart';
import 'package:threeclick/constants/app_urls.dart';
import 'package:threeclick/custom/toast_message.dart';
import 'package:threeclick/models/common/city_model.dart';
import 'package:threeclick/models/common/nationality_model.dart';
import 'package:threeclick/models/common/province_model.dart';
import 'package:threeclick/models/common/server_error.dart';

class RegistrationProvider extends ChangeNotifier {
  bool _showLoader = false;
  bool get showLoader => _showLoader;

  List<String> _nationality = [];
  List<String> get nationality => _nationality;

  List<Province> _province = [];
  List<Province> get province => _province;

  List<String> _provinceName = [];
  List<String> get provinceName => _provinceName;

  List<City> _city = [];
  List<City> get city => _city;

  List<String> _cityName = [];
  List<String> get cityName => _cityName;

  String _hashKey = '';
  String get hashKey => _hashKey;

  _setShowLoader(bool status) {
    _showLoader = status;
  }

  Future<bool> registration(
    Map<String, dynamic> body, {
    Map<String, String>? headers,
    required BuildContext context,
    required List<File> file,
    required List<String> fileKay,
  }) async {
    _setShowLoader(true);
    notifyListeners();
    try {
      await ApiClient.uploadFileWithAdditionalData(
        body: body,
        context: context,
        url: appUrls.registrationUrl,
        headers: headers,
        file: file,
        fileKey: fileKay,
      );

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

  Future<bool> getNationalityList({required BuildContext context}) async {
    _setShowLoader(true);
    _nationality = [];
    notifyListeners();
    try {
      var response = await ApiClient.getApi(
        context: context,
        url: appUrls.nationalityUrl,
      );
      var list = NationalityModel.fromJson(response);
      for (int i = 0; i < list.data!.length; i++) {
        _nationality.add(list.data?[i].nationality ?? '');
      }
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      if (e is ServerError) {}
    }
    _setShowLoader(false);
    notifyListeners();
    return true;
  }

  Future<bool> getProvinceList({required BuildContext context}) async {
    _setShowLoader(true);
    _province = [];
    _provinceName = [];
    notifyListeners();
    try {
      var response = await ApiClient.getApi(
        context: context,
        url: appUrls.provinceUrl,
      );
      var list = ProvinceModel.fromJson(response);
      for (int i = 0; i < list.data!.length; i++) {
        _province.add(list.data![i]);
        _provinceName.add(list.data![i].name ?? '');
      }
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      if (e is ServerError) {}
    }
    _setShowLoader(false);
    notifyListeners();
    return true;
  }

  Future<bool> getCityList(
      {required BuildContext context, required String id}) async {
    _setShowLoader(true);
    _city = [];
    _cityName = [];
    notifyListeners();
    try {
      var response = await ApiClient.getApi(
        context: context,
        url: '${appUrls.cityUrl}/$id',
      );
      var list = CityModel.fromJson(response);
      for (int i = 0; i < list.data!.length; i++) {
        _city.add(list.data![i]);
        _cityName.add(list.data?[i].city ?? '');
      }
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      if (e is ServerError) {}
    }
    _setShowLoader(false);
    notifyListeners();
    return true;
  }

  Future<bool> sendOtp(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    _hashKey = '';
    _setShowLoader(true);

    notifyListeners();
    try {
      var res = await ApiClient.postApi(
          context: context, url: appUrls.sendOtpUrl, body: body);
      _hashKey = res['hashkey'];
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      if (e is ServerError) {
        showToast(e.message['message'].toString());
      }
    }
    _setShowLoader(false);
    notifyListeners();
    return false;
  }

  Future<bool> verifyOtp(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    _setShowLoader(true);
    notifyListeners();
    try {
      await ApiClient.postApi(
          context: context, url: appUrls.otpVerificationUrl, body: body);
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      print("=====$e");
      if (e is ServerError) {
        showToast(e.message['message'].toString());
        _setShowLoader(false);
        notifyListeners();
        return false;
      }
    }
    _setShowLoader(false);
    notifyListeners();
    return false;
  }

  Future<bool> getReferral(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    try {
      await ApiClient.postApi(
          context: context, url: appUrls.referralUrl, body: body);
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      if (e is ServerError) {
        showToast(e.message['message'].toString());

        notifyListeners();
        return false;
      }
    }
    notifyListeners();
    return false;
  }
}
