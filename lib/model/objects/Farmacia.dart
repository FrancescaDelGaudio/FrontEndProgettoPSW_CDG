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
  String? password;

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
        this.password});

  factory Farmacia.fromJson(Map<String, dynamic> json) {
    TimeOfDay orarioIn;
    List<dynamic> orarioInizio = json["orarioInizioVisite"];
    orarioIn = TimeOfDay(hour:orarioInizio[0], minute:orarioInizio[1]);
    TimeOfDay orarioFin;
    List<dynamic> orarioFine = json["orarioFineVisite"];
    orarioFin = TimeOfDay(hour:orarioFine[0], minute:orarioFine[1]);
    return Farmacia(
    id : json['id'],
    nome : json['nome'],
    indirizzo : json['indirizzo'],
    budget : json['budget'],
    citta : json['citta'],
    partitaIva : json['partitaIva'],
      numDipendenti : json['numDipendenti'],
    orarioInizioVisite : orarioIn,
    password: json['password'],
    orarioFineVisite : orarioFin,
    );
  }

  String parserizzaInizio() {
    String orario=this.orarioInizioVisite.toString();
    String firstPart=orario.split("(")[1];
    String secondPart=firstPart.split(")")[0];
    return secondPart;
  }

  String parserizzaFine() {
    String orario=this.orarioFineVisite.toString();
    String firstPart=orario.split("(")[1];
    String secondPart=firstPart.split(")")[0];
    return secondPart;
  }

  Map<String, dynamic> toJson() => {
    'id' : this.id,
    'nome' : this.nome,
    'indirizzo' : this.indirizzo,
    'budget' : this.budget,
    'citta' : this.citta,
    'partitaIva' : this.partitaIva,
    'numDipendenti' : this.numDipendenti,
    'orarioInizioVisite' : parserizzaInizio(),
    'password': this.password,
    'orarioFineVisite' : parserizzaFine(),
  };
}