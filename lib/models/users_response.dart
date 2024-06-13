// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);

import 'dart:convert';

import 'package:kchat/models/usuario.dart';

UsersResponse usersResponseFromJson(String str) => UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
    bool ok;
    List<Usuario> usuarios;
    int since;

    UsersResponse({
        required this.ok,
        required this.usuarios,
        required this.since,
    });

    UsersResponse copyWith({
        bool? ok,
        List<Usuario>? usuarios,
        int? since,
    }) => 
        UsersResponse(
            ok: ok ?? this.ok,
            usuarios: usuarios ?? this.usuarios,
            since: since ?? this.since,
        );

    factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        ok: json["ok"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
        since: json["since"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
        "since": since,
    };
}