import 'dart:async';

import 'package:provider/provider.dart';

enum TipoEvento {event1, event2}

class MainEventBus {

  final _eventBusController = StreamController<TipoEvento>.broadcast();

  Stream<TipoEvento> get stream => _eventBusController.stream;


  MainEventBus get(context) => Provider.of<MainEventBus>(context, listen: false);

  void sendEvent(TipoEvento tipo){
    _eventBusController.add(tipo);
  }


  void dispose() {
    _eventBusController.close();
  }





}

