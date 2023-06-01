class Cliente {
  int? id;
  String? citta;
  String codiceFiscale;
  String? cognome;
  DateTime? dataNascita;
  String? indirizzo;
  String? nome;
  String password;


  Cliente({this.id, required this.codiceFiscale,  this.citta,  this.dataNascita,  this.indirizzo,  this.nome,  this.cognome, required this.password});

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      codiceFiscale: json['codiceFiscale'],
      nome: json['nome'],
      cognome: json['cognome'],
      indirizzo: json['indirizzo'],
      dataNascita: json['dataNascita'],
      citta: json['citta'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'codiceFiscale': codiceFiscale,
    'nome': nome,
    'cognome': cognome,
    'indirizzo': indirizzo,
    'citta': citta,
    'dataNascita': dataNascita,
    'password': password,
  };

  @override
  String toString() {
    return codiceFiscale;
  }


}