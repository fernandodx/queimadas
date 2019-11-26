import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:queimadas/focus_fire.dart';
import 'package:queimadas/pages/firestore/focus_fire_service.dart';
import 'package:queimadas/response_api.dart';
import 'package:queimadas/pages/listaFocus/datail_focus.dart';
import 'package:queimadas/utils/prefs.dart';


class ListaFocusApi {

  static final String LAST_LIST_FOCUS_KEY = "last_list_focus";

 static Future<ResponseApi<List<FocusFire>>> findFocus() async {

   try{

     await Future.delayed(Duration(seconds: 1));

     var url = 'http://queimadas.dgi.inpe.br/queimadas/dados-abertos/api/focos/count';

     var headers = {
       "Content-Type" : "application/json"
     };

     var response = await http.get(url, headers: headers).timeout(Duration(seconds: 15));

     print('Response status: ${response.statusCode}');

     if(response.statusCode == 200){
       Prefs.putString(LAST_LIST_FOCUS_KEY, response.body);
       List<FocusFire> resultado = FocusFire.createListFocusWithJson(response.body);
       FocusFireService service =  FocusFireService();
       resultado.forEach((focusFire) {
        service.saveFocusFire(focusFire);
       });

       return ResponseApi.ok(result: resultado);
     }

     return ResponseApi.error(msg: response.body);

   }catch(error, exception) {
     print("Error: $error - Exception: $exception");
     return ResponseApi.error(msg: error.toString());
   }
 }

 static Future<List<FocusFire>> getLastListFocus() async{
   String lastListJson = await Prefs.getString(LAST_LIST_FOCUS_KEY);
   if(lastListJson != null && lastListJson.isNotEmpty){
     return FocusFire.createListFocusWithJson(lastListJson);
   }else{
     return [];
   }
 }


 static Future<ResponseApi<List<DetailFocus>>> findFocusDetail(String pais) async {

   try{
     var url = "http://queimadas.dgi.inpe.br/queimadas/dados-abertos/api/focos/$pais";

     var params = {};
     var headers = {
       "Content-Type" : "application/json"
     };

     var response = await http.get(url, headers: headers).timeout(Duration(seconds: 15));

     print('Response status: ${response.statusCode}');

     if(response.statusCode == 200){
       var mapResp = json.decode(response.body);

       var lista = mapResp.map<DetailFocus>((data) {
         return DetailFocus.fromJson(data);
       }).toList();

       return ResponseApi.ok(result: lista);
     }

     return ResponseApi.error(msg: response.body.toString());

   }catch(error, exception){
     print("Erro: $error - Exeption: $exception");
     return ResponseApi.error(msg: error.toString());
   }

 }



}
