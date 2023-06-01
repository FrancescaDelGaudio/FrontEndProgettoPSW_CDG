
class Prodotto {
  int? id;
  String nome;
  String? principioAttivo;
  double prezzoUnitario;
  String? formaFarmaceutica;
  int qtaInStock;


  Prodotto({ this.id, required this.nome, required this.qtaInStock, this.formaFarmaceutica,required this.prezzoUnitario ,this.principioAttivo});

  factory Prodotto.fromJson(Map<String, dynamic> json) {
    return Prodotto(
      id: json['id'],
      nome: json['nome'],
      principioAttivo: json['principioAttivo'],
      formaFarmaceutica: json['formaFarmaceutica'],
      qtaInStock: json['qtaInStock'],
      prezzoUnitario: json['prezzoUnitario'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'principioAttivo': principioAttivo,
    'formaFarmaceutica': formaFarmaceutica,
    'qtaInStock':qtaInStock,
    'prezzoUnitario':prezzoUnitario
  };

  @override
  String toString() {
    return nome;
  }


}