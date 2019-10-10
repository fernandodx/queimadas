import 'package:http/http.dart' as http;

class LoremIpsumApi {

  final url = "https://loripsum.net/api";

  Future<String> findTextRandom() async {

    String msg;

    try{
      var response =  await http.get(url);

      if(response.statusCode == 200){

        msg = response.body;
        msg = msg.replaceAll("<p>", "").replaceAll("</p>", "");

      }else{
        msg = "Erro status: ${response.statusCode}";
      }
    }catch(exception){
       print(exception);
       msg = "ERROR: $exception";
    }

    return msg;

  }





}