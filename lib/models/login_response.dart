// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:kchat/models/usuario.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    bool ok;
    Usuario usuario;
    String token;

    LoginResponse({
        required this.ok,
        required this.usuario,
        required this.token,
    });

    LoginResponse copyWith({
        bool? ok,
        Usuario? usuario,
        String? token,
    }) => 
        LoginResponse(
            ok: ok ?? this.ok,
            usuario: usuario ?? this.usuario,
            token: token ?? this.token,
        );

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        usuario: Usuario.fromJson(json["usuario"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": usuario.toJson(),
        "token": token,
    };
}
