import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Cliente.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Visita.dart';

class Appuntamento {
  int id;
  DateUtils data;
  TimeOfDay orario;
  Visita visita;
  Cliente cliente;

  Appuntamento({required this.id, required this.data,required this.orario, required this.visita,required this.cliente});

  factory Appuntamento.fromJson(Map<String, dynamic> json) {
    return Appuntamento(
    id : json['id'],
    data : json['data'],
    orario : json['orario'],
    visita : json['visita'],
    cliente : json['cliente'],
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