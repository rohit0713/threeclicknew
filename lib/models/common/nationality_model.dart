class NationalityModel {
  bool? success;
  List<Nationality>? data;

  NationalityModel({this.success, this.data});

  NationalityModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Nationality>[];
      json['data'].forEach((v) {
        data!.add(Nationality.fromJson(v));
      });
    }
  }
}

class Nationality {
  int? id;
  String? nationality;

  Nationality({this.id, this.nationality});

  Nationality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nationality = json['nationality'];
  }
}
