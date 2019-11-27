import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:queimadas/focus_fire.dart';

class FocusFireService {

  CollectionReference get _focusFireStore => Firestore.instance.collection("focusFire");
  CollectionReference get _monitorFocusFire => Firestore.instance.collection("monitorFocusFire");

  Stream<QuerySnapshot> getFocusFire() => _focusFireStore.snapshots();
  Stream<QuerySnapshot> getMonitorFocusFire() => _monitorFocusFire.snapshots();


  toList(AsyncSnapshot<QuerySnapshot> snapshot){

    var lista = snapshot.data.documents.map(
            (document) => FocusFire.fromMap(document.data)
    ).toList();

    return lista;
  }


  Future<bool> saveMonitorFocus(FocusFire focus) async {
    var document = _monitorFocusFire.document(focus.country);
    var snapshot = await document.get();

    if(!snapshot.exists){
      document.setData(focus.toMap());
    }else{
      document.delete();
    }

  }


  Future<bool> saveFocusFire(FocusFire focus) async {

    var document = _focusFireStore.document(focus.country);
    var snapshot = await document.get();

    if(!snapshot.exists){
      
      document.setData(focus.toMap());
      return true;
    }

    return false;
  }

  Future<bool> isExist(FocusFire focus) async {
    var document = await _focusFireStore.document(focus.country).get();
    return document.exists;
  }



}