import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:queimadas/Focus.dart';
import 'package:queimadas/ResponseApi.dart';
import 'package:queimadas/pages/listaFocus/datail_focus.dart';


class ListaFocusApi {

 static Future<ResponseApi<List<Focus>>> findFocus() async {

   try{

     var url = 'http://queimadas.dgi.inpe.br/queimadas/dados-abertos/api/focos/count';

     var headers = {
       "Content-Type" : "application/json"
     };

     var response = await http.get(url, headers: headers);

     print('Response status: ${response.statusCode}');

     if(response.statusCode == 200){
       List<Focus> resultado = Focus.createListFocusWithJson(response.body);
       return ResponseApi.ok(resultado);
     }

     return ResponseApi.error(response.body);

   }catch(error, exception) {
     print("Error: $error - Exception: $exception");
     return ResponseApi.error(error.toString());
   }
 }

 static Future<ResponseApi<List<DetailFocus>>> findFocusDetail(String pais) async {

   try{
     var url = "http://queimadas.dgi.inpe.br/queimadas/dados-abertos/api/focos/$pais";

     var params = {};
     var headers = {
       "Content-Type" : "application/json"
     };

     var response = await http.get(url, headers: headers);

     print('Response status: ${response.statusCode}');

     if(response.statusCode == 200){
       var mapResp = json.decode(response.body);

       var lista = mapResp.map<DetailFocus>((data) {
         return DetailFocus.fromJson(data);
       }).toList();

       return ResponseApi.ok(lista);
     }

     return ResponseApi.error(response.body.toString());

   }catch(error, exception){
     print("Erro: $error - Exeption: $exception");
     return ResponseApi.error(error.toString());
   }

 }



}
