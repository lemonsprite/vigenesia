import 'dart:convert';

GetMotivasi getMotivasiFromJson(String str) => GetMotivasi.fromJson(json.decode(str));

String getMotivasiToJson(GetMotivasi data) => json.encode(data.toJson());

class GetMotivasi {
    GetMotivasi({
        this.data,
    });

    List<Datum> data;

    factory GetMotivasi.fromJson(Map<String, dynamic> json) => GetMotivasi(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.isiMotivasi,
        this.user,
    });

    int id;
    String isiMotivasi;
    User user;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    Nama nama;
    Email email;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nama: namaValues.map[json["nama"]],
        email: emailValues.map[json["email"]],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": namaValues.reverse[nama],
        "email": emailValues.reverse[email],
    };
}

enum Email { ADMIN_VIGENESIA_COM }

final emailValues = EnumValues({
    "admin@vigenesia.com": Email.ADMIN_VIGENESIA_COM
});

enum Nama { ADMIN }

final namaValues = EnumValues({
    "Admin": Nama.ADMIN
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
