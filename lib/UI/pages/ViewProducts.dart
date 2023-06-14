import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progetto_cozza_del_gaudio/UI/behaviors/AppLocalizations.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Prodotto.dart';

import '../../model/Model.dart';
import '../widgets/InputField.dart';
import '../widgets/buttons/CircularIconButton.dart';
import 'package:progetto_cozza_del_gaudio/UI/widgets/dialogs/ProdottoCard.dart';

class ViewProducts extends StatefulWidget {
  ViewProducts() : super();

  @override
  _ViewProductsState createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  bool _loading = true;
  bool _cercaPerNome=false;
  int _numberPage=0;
  List<Prodotto>? _prodotti;

  TextEditingController _nomeFiledController = TextEditingController();
  TextEditingController _principioAttivoFiledController = TextEditingController();
  TextEditingController _formaFarmaceuticaFiledController = TextEditingController();

  void initState() {  super.initState();
  WidgetsBinding.instance.addPostFrameCallback(    (timeStamp) {
    _recuperaProdotti();
  },
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
         SingleChildScrollView(
           child: Center(
             child: Column(
               children: [
                 _loading==true ?
                     CircularProgressIndicator()
                     :
                     _prodotti==null ?
                         Text(
                           AppLocalizations.of(context)!.translate("internal_server_error").toUpperCase()
                         )
                         :
                     Row(
                       children: [
                         const SizedBox(height: 20),
                         Flexible(
                           child:
                           InputField(
                             controller: _nomeFiledController,
                             labelText: AppLocalizations.of(context)!.translate("find_by_name").toUpperCase(),
                           ),
                         ),
                         Flexible(
                           child:
                           InputField(
                             controller: _principioAttivoFiledController,
                             labelText: AppLocalizations.of(context)!.translate("find_by_active_principle").toUpperCase(),
                           ),
                         ),Flexible(
                           child:
                           InputField(
                             controller: _formaFarmaceuticaFiledController,
                             labelText: AppLocalizations.of(context)!.translate("find_by_pharmaceutical_form").toUpperCase(),
                           ),
                         ),
                         CircularIconButton(
                           icon: Icons.search,
                           onPressed: () {_cercaAvanzata();},
                         )
                       ],
                     ),
                 const SizedBox(height: 20),
                 ListView.builder(
                   itemCount: _prodotti?.length ?? 0,
                   shrinkWrap: true,
                   itemBuilder: (context, index) {
                     return ProdottoCard(
                         prodotto: _prodotti![index]
                     );
                   },
                 ),
                 const SizedBox(height: 20),
                 _cercaPerNome==false ?
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     RawMaterialButton(
                       fillColor: Colors.blueAccent,
                       onPressed:(){ _retrocediDiPagina(); },
                       shape: LinearBorder(),
                       elevation: 2.0,
                       child: Icon(
                           Icons.arrow_back_ios
                       ),
                       padding: EdgeInsets.all(10),
                     ),
                     RawMaterialButton(
                       fillColor: Colors.blueAccent,
                       onPressed:(){ _avanzaDiPagina(); },
                       shape: LinearBorder(),
                       elevation: 2.0,
                       child: Icon(
                         Icons.arrow_forward_ios,
                       ),
                       padding: EdgeInsets.all(10),
                     ),
                   ],
                 ) :
                 RawMaterialButton(
                   fillColor: Colors.blueAccent,
                   onPressed:(){ _recuperaProdotti(); },
                   shape: LinearBorder(),
                   elevation: 2.0,
                   child: Icon(
                       Icons.reply_all
                   ),
                   padding: EdgeInsets.all(10),
                 ),

               ],
             ),
           ),
         )

    );
  }

  void _recuperaProdotti() async{
    Model.sharedInstance.visualizzaProdotti(_numberPage)?.then((result) {
      setState(() {
        _loading = false;
        _prodotti = result;
        _cercaPerNome=false;
      });
    });
  }

  void _avanzaDiPagina() async{
    setState(() {
      _numberPage+=1;
      _loading=true;
    });
    Model.sharedInstance.visualizzaProdotti(_numberPage)?.then((result) {
      setState(() {
        _loading = false;
        _prodotti = result;
      });
    });
  }

  void _retrocediDiPagina() async {
    if(_numberPage==0)
      return;
    setState(() {
      _numberPage-=1;
      _loading=true;
    });
    Model.sharedInstance.visualizzaProdotti(_numberPage)?.then((result) {
      setState(() {
        _loading = false;
        _prodotti = result;
      });
    });
  }

  void _cercaAvanzata() async{
    setState(() {
      _loading=true;
      _cercaPerNome=true;
    });

    Model.sharedInstance.visualizzaProdottiRicercaAvanzata(_nomeFiledController.text,_principioAttivoFiledController.text,_formaFarmaceuticaFiledController.text)?.then((result) {
      setState(() {
        _loading = false;
        _prodotti = result;
        _nomeFiledController.clear();
        _principioAttivoFiledController.clear();
        _formaFarmaceuticaFiledController.clear();
      });
    });

  }
}

