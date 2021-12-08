import 'dart:convert';

AuthCallback authCallbackFromJson(String str) => AuthCallback.fromJson(json.decode(str));

String authCallbackToJson(AuthCallback data) => json.encode(data.toJson());

class AuthCallback {
    AuthCallback({
        this.user,
        this.token,
    });

    User user;
    String token;

    factory AuthCallback.fromJson(Map<String, dynamic> json) => AuthCallback(
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
    };
}

class User {
    User({
        this.nama,
        this.email,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    String nama;
    String email;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    factory User.fromJson(Map<String, dynamic> json) => User(
        nama: json["nama"],
        email: json["email"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nama": nama,
        "email": email,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
