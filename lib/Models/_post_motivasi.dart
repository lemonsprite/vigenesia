import 'dart:convert';

PostMotivasi postMotivasiFromJson(String str) => PostMotivasi.fromJson(json.decode(str));

String postMotivasiToJson(PostMotivasi data) => json.encode(data.toJson());

class PostMotivasi {
    PostMotivasi({
        this.message,
        this.data,
    });

    String message;
    Data data;

    factory PostMotivasi.fromJson(Map<String, dynamic> json) => PostMotivasi(
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.isiMotivasi,
        this.idUser,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    String isiMotivasi;
    String idUser;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        isiMotivasi: json["isi_motivasi"],
        idUser: json["id_user"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "isi_motivasi": isiMotivasi,
        "id_user": idUser,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
