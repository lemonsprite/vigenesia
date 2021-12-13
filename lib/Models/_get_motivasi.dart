// To parse this JSON data, do
//
//     final getMotivasi = getMotivasiFromJson(jsonString);

import 'dart:convert';

GetMotivasi getMotivasiFromJson(String str) => GetMotivasi.fromJson(json.decode(str));

String getMotivasiToJson(GetMotivasi data) => json.encode(data.toJson());

class GetMotivasi {
    GetMotivasi({
        this.data,
    });

    List<Data> data;

    factory GetMotivasi.fromJson(Map<String, dynamic> json) => GetMotivasi(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<Data>.from(data.map((x) => x.toJson())),
    };
}

class Data {
    Data({
        this.id,
        this.isiMotivasi,
        this.user,
    });

    int id;
    String isiMotivasi;
    User user;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        isiMotivasi: json["isi_motivasi"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "isi_motivasi": isiMotivasi,
        "user": user.toJson(),
    };
}

class User {
    User({
        this.id,
        this.nama,
        this.email,
    });

    int id;
    String nama;
    String email;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nama: json["nama"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "email": email,
    };
}
