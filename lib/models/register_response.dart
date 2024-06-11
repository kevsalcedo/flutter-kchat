// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:kchat/models/usuario.dart';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
    bool ok;
    Usuario usuario;
    String token;

    RegisterResponse({
        required this.ok,
        required this.usuario,
        required this.token,
    });

    RegisterResponse copyWith({
        bool? ok,
        Usuario? usuario,
        String? token,
    }) => 
        RegisterResponse(
            ok: ok ?? this.ok,
            usuario: usuario ?? this.usuario,
            token: token ?? this.token,
        );

    factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
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
