import 'dart:convert';

ResCallback resCallbackFromJson(String str) => ResCallback.fromJson(json.decode(str));

String resCallbackToJson(ResCallback data) => json.encode(data.toJson());

class ResCallback {
    ResCallback({
        this.message,
        this.data,
    });

    String message;
    int data;

    factory ResCallback.fromJson(Map<String, dynamic> json) => ResCallback(
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
    };
}
