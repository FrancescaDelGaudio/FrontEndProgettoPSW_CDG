
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/objects/DettaglioMagazzino.dart';
import '../widgets/dialogs/DettaglioMagazzinoCard.dart';

class VisualizzaMagazzinoByCliente extends StatefulWidget {
  int id;
  List<DettaglioMagazzino> magazzino;
  String nome;

  VisualizzaMagazzinoByCliente({required this.id,required this.magazzino,required this.nome}) : super();

  @override
  _VisualizzaMagazzinoByClienteState createState() => _VisualizzaMagazzinoByClienteState(id,magazzino,nome);
}

class _VisualizzaMagazzinoByClienteState extends State<VisualizzaMagazzinoByCliente> {
  late List<DettaglioMagazzino> listaDM;
  late int id;
  late String nome;

  _VisualizzaMagazzinoByClienteState(int id, List<DettaglioMagazzino> magazzino, String nome) {
    this.listaDM = magazzino;
    this.id=id;
    this.nome=nome;
  }

  TextEditingController _cityFiledController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  "Magazzino di "+nome,
                  style: TextStyle(
                    fontFamily: "Pacifico",
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  itemCount: listaDM?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return DettaglioMagazzinoCard(
                        dettaglioMagazzino: listaDM![index]
                    );
                  },
                ),
              ],
            ),
        ),
        ),
    );
  }

}