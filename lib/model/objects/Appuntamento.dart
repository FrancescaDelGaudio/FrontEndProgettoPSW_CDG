import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Cliente.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Visita.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Farmacia.dart';


class Appuntamento {
  int id;
  DateTime data;
  TimeOfDay orario;
  Visita visita;
  Cliente cliente;
  Farmacia farmacia;

  Appuntamento({required this.id, required this.data,required this.orario, required this.visita,required this.cliente,required this.farmacia});

  factory Appuntamento.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> farmacia= json['farmacia'];
    Map<String, dynamic> cliente= json['cliente'];
    Map<String, dynamic> visita= json['visita'];
    TimeOfDay orario;
    List<dynamic> orarioInizio = json["orario"];
    orario = TimeOfDay(hour:orarioInizio[0], minute:orarioInizio[1]);
    DateTime dt;
    List<dynamic> data = json["data"];
    dt = DateTime(data[0], data[1], data[2]);

    return Appuntamento(
      id : json['id'],
      data : dt,
      orario : orario,
      visita : Visita.fromJson(visita),
      cliente : Cliente.fromJson(cliente),
      farmacia: Farmacia.fromJson(farmacia),
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : this.id,
    'data' : this.data,
    'orario' : this.orario,
    'visita' : this.visita,
    'cliente' : this.cliente,
  };
}