// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.iduser,
        this.nama,
        this.profesi,
        this.email,
        this.password,
        this.roleId,
        this.isActive,
        this.tanggalInput,
        this.modified,
    });

    String iduser;
    String nama;
    String profesi;
    String email;
    String password;
    String roleId;
    String isActive;
    DateTime tanggalInput;
    DateTime modified;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        iduser: json["iduser"],
        nama: json["nama"],
        profesi: json["profesi"],
        email: json["email"],
        password: json["password"],
        roleId: json["role_id"],
        isActive: json["is_active"],
        tanggalInput: DateTime.parse(json["tanggal_input"]),
        modified: DateTime.parse(json["modified"]),
    );

    Map<String, dynamic> toJson() => {
        "iduser": iduser,
        "nama": nama,
        "profesi": profesi,
        "email": email,
        "password": password,
        "role_id": roleId,
        "is_active": isActive,
        "tanggal_input": "${tanggalInput.year.toString().padLeft(4, '0')}-${tanggalInput.month.toString().padLeft(2, '0')}-${tanggalInput.day.toString().padLeft(2, '0')}",
        "modified": "${modified.year.toString().padLeft(4, '0')}-${modified.month.toString().padLeft(2, '0')}-${modified.day.toString().padLeft(2, '0')}",
    };
}
