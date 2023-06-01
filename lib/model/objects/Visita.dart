class Visita {
  int? id;
  String? descrizione;
  String nome;
  int durata; //in minuti

  Visita({ this.id, this.descrizione,required this.nome,required this.durata});

  factory Visita.fromJson(Map<String, dynamic> json) {
    return Visita(
    id : json['id'],
    descrizione : json['descrizione'],
    nome : json['nome'],
    durata : json['durata'],
    );
    }

  Map<String, dynamic> toJson() => {
    'id' : this.id,
    'descrizione' : this.descrizione,
    'nome' : this.nome,
    'durata' : this.durata,
  };
}