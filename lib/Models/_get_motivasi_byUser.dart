// To parse this JSON data, do
//
//     final getMotivasiByUser = getMotivasiByUserFromJson(jsonString);

import 'dart:convert';

GetMotivasiByUser getMotivasiByUserFromJson(String str) => GetMotivasiByUser.fromJson(json.decode(str));

String getMotivasiByUserToJson(GetMotivasiByUser data) => json.encode(data.toJson());

class GetMotivasiByUser {
    GetMotivasiByUser({
        this.data,
    });

    List<Datum> data;

    factory GetMotivasiByUser.fromJson(Map<String, dynamic> json) => GetMotivasiByUser(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.nama,
        this.email,
        this.motivasi,
    });

    int id;
    String nama;
    String email;
    List<Motivasi> motivasi;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nama: json["nama"],
        email: json["email"],
        motivasi: List<Motivasi>.from(json["motivasi"].map((x) => Motivasi.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "email": email,
        "motivasi": List<dynamic>.from(motivasi.map((x) => x.toJson())),
    };
}

class Motivasi {
    Motivasi({
        this.id,
        this.isiMotivasi,
    });

    int id;
    String isiMotivasi;

    factory Motivasi.fromJson(Map<String, dynamic> json) => Motivasi(
        id: json["id"],
        isiMotivasi: json["isi_motivasi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "isi_motivasi": isiMotivasi,
    };
}
