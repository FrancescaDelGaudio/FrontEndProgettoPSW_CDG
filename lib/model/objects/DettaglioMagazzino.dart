import 'package:progetto_cozza_del_gaudio/model/objects/Prodotto.dart';

class DettaglioMagazzino {
  int id;
  int quantita;
  Prodotto prodotto;

  DettaglioMagazzino({required this.id, required this.quantita, required this.prodotto});

  factory DettaglioMagazzino.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> prodotto= json['prodotto'];

    return DettaglioMagazzino(
    id : json['id'],
    quantita :json['quantita'],
    prodotto : Prodotto.fromJson(prodotto),
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'quantita' : quantita,
    'prodotto' :prodotto,
  };
}