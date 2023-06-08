import 'package:flutter/material.dart';

import '../behaviors/AppLocalizations.dart';
import 'PersonalAreaCliente.dart';

class LayoutAuthAdmin extends StatefulWidget {
  final String title;


  LayoutAuthAdmin({required this.title}) : super();

  @override
  _LayoutAuthAdminState createState() => _LayoutAuthAdminState();
}

class _LayoutAuthAdminState extends State<LayoutAuthAdmin> {
  late String title;


  _LayoutState(String title) {
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
          backgroundColor: Colors.green,
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
            /*ViewPharmacies(),
            ViewBookings(),*/
            PersonalAreaCliente(),
            PersonalAreaCliente(),
          ],
        ),
      ),
    );
  }
}