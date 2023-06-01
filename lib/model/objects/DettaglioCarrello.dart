import 'package:progetto_cozza_del_gaudio/model/objects/Prodotto.dart';

class DettaglioCarrello{
  int id;
  int quantita;
  Prodotto prodotto;

  DettaglioCarrello({required this.id, required this.quantita, required this.prodotto});

  factory DettaglioCarrello.fromJson(Map<String, dynamic> json) {
    return DettaglioCarrello(
        id: json['id'],
        quantita: json ['quantita'],
        prodotto: json ['prodotto'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'quantita':quantita,
    'prodotto':prodotto,
  };
}