import 'package:progetto_cozza_del_gaudio/UI/widgets/InputField.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/buttons/CircularIconButton.dart';
import 'package:progetto_cozza_del_gaudio/model/Model.dart';
import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Farmacia.dart';

import '../../model/objects/Cliente.dart';
import '../behaviors/AppLocalizations.dart';
import '../widgets/dialogs/MessageDialog.dart';


class PersonalAreaCliente extends StatefulWidget {
  PersonalAreaCliente() : super();

  @override
  _PersonalAreaClienteState createState() => _PersonalAreaClienteState();
}

class _PersonalAreaClienteState extends State<PersonalAreaCliente> {
  bool _loading = true;
  Cliente? _cliente;

  TextEditingController _cittaFiledController=TextEditingController();
  TextEditingController _indirizzoFiledController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(_cliente==null)
        _recuperaCliente();
    return Scaffold(
      backgroundColor: Colors.lightBlue,
        body: SingleChildScrollView(
         child: Center(
          child: Column(
            children: [
              _loading==true ?
                 CircularProgressIndicator():
              _cliente==null ?
                Text(
                    "Errore Interno"
                ):
                Text('Area Personale',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child:
                Text('Nome: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    title: Text(
                      _cliente!.nome ==null ? " " :
                      _cliente!.nome.toString(),
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                          color: Colors.blueAccent,
                    ),
                  ),
                ),
                ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child:
                Text('Cognome: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text(
                  _cliente!.cognome ==null ? " " :
                  _cliente!.cognome.toString(),
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 20.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                
                child:
                Text('Codice Fiscale: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text(
                  _cliente!.codiceFiscale ==null ? " " :
                  _cliente!.codiceFiscale,
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 20.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                
                child:
                Text('Citta: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.location_city,
                  color: Colors.black,
                ),
                title: Text(
                  _cliente!.citta==null ? " " :
                  _cliente!.citta!,
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 20.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
            CircularIconButton(icon: Icons.mode, onPressed: () {_mostraModificaCitta();},),
              const SizedBox(height: 40),

              Align(
                alignment: Alignment.centerLeft,
                
                child:
                Text('Indirizzo: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.broadcast_on_personal_rounded,
                  color: Colors.black,
                ),
                title: Text(
                  _cliente!.indirizzo ==null ? " " :
                  _cliente!.indirizzo!,
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 20.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
              CircularIconButton(icon: Icons.mode, onPressed: () {_mostraModificaIndirizzo();},),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child:
                Text('Data di Nascita: ',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              color: Colors.white,
              child: ListTile(
                leading: Icon(
                  Icons.date_range,
                  color: Colors.black,
                ),
                title: Text(
                  _cliente!.dataNascita ==null ? " " :
                  _cliente!.dataNascita.toString().split(" ")[0],
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 20.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
        ),
    );
  }


  void _recuperaCliente() async  {
    setState(() {
      _cliente=Cliente(codiceFiscale: "-1");
    });
    Model.sharedInstance.trovaCliente()?.then((result) {
      setState(() {
        _loading = false;
        _cliente = result;
      });
    });
  }

  void _mostraModificaCitta(){
    showDialog<String>(context: context, builder: (BuildContext context) => Dialog(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputField(
                labelText: "Modifica citta",
                controller: _cittaFiledController,
              ),
              CircularIconButton(
                icon: Icons.check,
                onPressed:() { _cambiaCitta(_cittaFiledController.text); },
              ),
              const SizedBox(height:15),
            ],
          ),
        )
    )
    );
  }

  void _mostraModificaIndirizzo(){
    showDialog<String>(context: context, builder: (BuildContext context) => Dialog(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputField(
              labelText: "Modifica indirizzo",
              controller: _indirizzoFiledController,
            ),
            CircularIconButton(
              icon: Icons.check,
              onPressed:() { _cambiaIndirizzo(_indirizzoFiledController.text); },
            ),
            const SizedBox(height:15),
          ],
        ),
      )
    )
    );
  }

  void _cambiaCitta(String citta) {
    Model.sharedInstance.modificaCitta(citta)?.then((result) {
      setState(() {
        _cliente = result;
        print(_cliente!.citta);
      });
    });
  }


  void _cambiaIndirizzo(String indirizzo) {
    Model.sharedInstance.modificaIndirizzo(indirizzo)?.then((result) {
      setState(() {
        _cliente = result;
      });
    });
  }
}