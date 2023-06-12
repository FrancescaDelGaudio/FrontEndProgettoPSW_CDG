import 'package:progetto_cozza_del_gaudio/UI/behaviors/AppLocalizations.dart';
import 'package:flutter/material.dart';

import 'PersonalAreaCliente.dart';
import 'ViewBookings.dart';
import 'ViewPharmacies.dart';



class LayoutAuthCliente extends StatefulWidget {
  final String title;


  LayoutAuthCliente({required this.title}) : super();

  @override
  _LayoutAuthClienteState createState() => _LayoutAuthClienteState(title);
}

class _LayoutAuthClienteState extends State<LayoutAuthCliente> {
  late String title;


  _LayoutAuthClienteState(String title) {
    this.title = title;
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Text(title),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.black,
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: AppLocalizations.of(context)!
                  .translate("personal_area")
                  .toUpperCase(), icon: Icon(Icons.home_rounded)),
              Tab(text: AppLocalizations.of(context)!
                  .translate("pharmacies")
                  .toUpperCase(), icon: Icon(Icons.search_rounded)),
              Tab(text: AppLocalizations.of(context)!.translate(
                  "bookings").toUpperCase(),
                  icon: Icon(Icons.person_rounded)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PersonalAreaCliente(),
            ViewPharmacies(),
            ViewBookings(),
          ],
        ),
      ),
    );
  }


}