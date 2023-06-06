import 'dart:convert';

import 'package:http/http.dart';
import 'package:progetto_cozza_del_gaudio/model/objects/Farmacia.dart';

import '../model/managers/RestManager.dart';
import '../model/support/Constants.dart';

class GetInformationParhmacy{
  RestManager _restManager = RestManager();

  Future<Farmacia> getInformationPharmacy() async {
    Response res = await get(Uri.parse("localhost:8081/farmacia"));
    try {
      print(res.statusCode);
      if(res.statusCode == 200){
        final body = jsonDecode(res.body);
        Farmacia far = Farmacia.fromJson(body);
        return far;
      }
      print(res.statusCode);
      throw Exception('error');
      //return Farmacia.fromJson(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_SF_SERVER, Constants.GET_INFORMATION_PHARMACY,),),);
    }
    catch (e) {
      print(res.statusCode);
      print('e');
      throw Exception(e);
    }
  }
}