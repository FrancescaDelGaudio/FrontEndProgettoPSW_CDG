import 'dart:developer';

import 'package:flutter/material.dart';

class Farmacia {
  int? id;
  String? nome;
  String? indirizzo;
  double budget;
  String? citta;
  String partitaIva;
  int numDipendenti;
  TimeOfDay orarioInizioVisite;
  TimeOfDay orarioFineVisite;
  String password;

  Farmacia(
      {this.id,
        this.nome,
        this.indirizzo,
        required this.budget,
        this.citta,
        required this.partitaIva,
        required this.numDipendenti,
        required this.orarioInizioVisite,
        required this.orarioFineVisite,
        required this.password});

  factory Farmacia.fromJson(Map<String, dynamic> json) {
    return Farmacia(
    id : json['id'],
    nome : json['nome'],
    indirizzo : json['indirizzo'],
    budget : json['budget'],
    citta : json['citta'],
    partitaIva : json['partitaIva'],
    numDipendenti : json['numDipendenti'],
    orarioInizioVisite : json['orarioInizioVisite'],
    password: json['password'],
    orarioFineVisite : json['orarioFineVisite'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : this.id,
    'nome' : this.nome,
    'indirizzo' : this.indirizzo,
    'budget' : this.budget,
    'citta' : this.citta,
    'partitaIva' : this.partitaIva,
    'numDipendenti' : this.numDipendenti,
    'orarioInizioVisite' : this.orarioInizioVisite,
    'password': this.password,
    'orarioFineVisite' : this.orarioFineVisite,
  };
}