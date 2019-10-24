import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AddFocusFireBloc {


  final keyForm = GlobalKey<FormState>();
  final descricaoController = TextEditingController();
  final dataController = TextEditingController();

  String validatedFieldDefault(String value) {
    if(value == null || value.isEmpty){
      return "Campo Obrigatório";
    }
    return null;
  }

  onPressAdd() {
    if(!keyForm.currentState.validate()){
      return;
    }

    print("OK onPress ${descricaoController.text} - ${dataController.text}");

  }

  addImage() {


  }



}