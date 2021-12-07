class LoginModel {
  bool isActive;
  String message;
  Data data;

  LoginModel({this.isActive, this.message, this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      isActive: json['is_active'],
      message: json['message'],
      data: json['data'] != null ? new Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_active'] = this.isActive;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String nama;
  String email;
  String profesi;
  String password;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.nama,
      this.email,
      this.profesi,
      this.password,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    profesi = json['profesi'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['email'] = this.email;
    data['profesi'] = this.profesi;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}