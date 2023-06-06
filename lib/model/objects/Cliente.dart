class Cliente {
  int? id;
  String? citta;
  String codiceFiscale;
  String? cognome;
  DateTime? dataNascita;
  String? indirizzo;
  String? nome;
  String? password;


  Cliente({this.id, required this.codiceFiscale,  this.citta, this.dataNascita,  this.indirizzo,  this.nome,  this.cognome, this.password});

  factory Cliente.fromJson(Map<String, dynamic> json) {
    DateTime? dt;
    if(json["dataNascita"]!= null) {
      List<dynamic> data = json["dataNascita"];
      dt = DateTime(data[0], data[1], data[2]);
    }
    return Cliente(
      id: json['id'],
      codiceFiscale: json['codiceFiscale'],
      nome: json['nome'],
      cognome: json['cognome'],
      indirizzo: json['indirizzo'],
      dataNascita: dt,
      citta: json['citta'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'codiceFiscale': codiceFiscale,
    'nome': nome,
    'cognome': cognome,
    'indirizzo': indirizzo,
    'citta': citta,
    'dataNascita': dataNascita==null? null :dataNascita!.toIso8601String(),
    'password': password
  };

  @override
  String toString() {
    return codiceFiscale;
  }


}