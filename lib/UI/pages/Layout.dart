import 'package:progetto_cozza_del_gaudio/UI/behaviors/AppLocalizations.dart';
import 'package:progetto_cozza_del_gaudio/UI/pages/Home.dart';
import 'package:progetto_cozza_del_gaudio/UI/pages/ClienteRegistrazione.dart';
import 'package:progetto_cozza_del_gaudio/UI/pages/FarmaciaRegistrazione.dart';
import 'package:progetto_cozza_del_gaudio/UI/pages/LogIn.dart';
import 'package:flutter/material.dart';



class Layout extends StatefulWidget {
  final String title;


  Layout({required this.title}) : super();

  @override
  _LayoutState createState() => _LayoutState(title);
}

class _LayoutState extends State<Layout> {
  late String title;


  _LayoutState(String title) {
    this.title = title;
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Text(title),
          backgroundColor: Colors.green,
          foregroundColor: Colors.black,
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.translate("home").toUpperCase(), icon: Icon(Icons.home_rounded)),
              Tab(text: AppLocalizations.of(context)!.translate("register_user").toUpperCase(), icon: Icon(Icons.search_rounded)),
              Tab(text: AppLocalizations.of(context)!.translate("register_pharmacy").toUpperCase(), icon: Icon(Icons.person_rounded)),
              Tab(text: AppLocalizations.of(context)!.translate("log_in").toUpperCase(), icon: Icon(Icons.animation)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Home(),
            ClienteRegistration(),
            FarmaciaRegistration(),
            LogIn(),
          ],
        ),
      ),
    );
  }


}