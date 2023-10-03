// ignore_for_file: unnecessary_new

class ProvinceModel {
  bool? success;
  List<Province>? data;

  ProvinceModel({this.success, this.data});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Province>[];
      json['data'].forEach((v) {
        data!.add(Province.fromJson(v));
      });
    }
  }
}

class Province {
  int? id;
  String? name;

  Province({this.id, this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
