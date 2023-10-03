class LoginDataModel {
  Response? response;

  LoginDataModel({this.response});

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class Response {
  String? status;
  String? message;
  String? token;
  List<User>? user;

  Response({this.status, this.message, this.token, this.user});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? contactNo;
  dynamic age;
  String? gender;
  String? role;
  dynamic referCode;
  String? userimage;

  User(
      {this.id,
      this.name,
      this.email,
      this.contactNo,
      this.age,
      this.gender,
      this.role,
      this.referCode,
      this.userimage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    age = json['age'];
    gender = json['gender'];
    role = json['role'];
    referCode = json['refer_code'];
    userimage = json['userimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['contact_no'] = contactNo;
    data['age'] = age;
    data['gender'] = gender;
    data['role'] = role;
    data['refer_code'] = referCode;
    data['userimage'] = userimage;
    return data;
  }
}
