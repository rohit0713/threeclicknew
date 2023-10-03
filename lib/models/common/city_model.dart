class CityModel {
  bool? success;
  List<City>? data;

  CityModel({this.success, this.data});

  CityModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <City>[];
      json['data'].forEach((v) {
        data!.add(City.fromJson(v));
      });
    }
  }
}

class City {
  dynamic id;
  String? city;
  String? population;
  dynamic area;
  dynamic pD;
  dynamic brgy;
  String? clas;
  String? provinceId;
  String? createdAt;
  String? updatedAt;

  City(
      {this.id,
      this.city,
      this.population,
      this.area,
      this.pD,
      this.brgy,
      this.clas,
      this.provinceId,
      this.createdAt,
      this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['City'];
    population = json['Population'];
    area = json['Area'];
    pD = json['PD'];
    brgy = json['Brgy'];
    clas = json['Class'];
    provinceId = json['province_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
