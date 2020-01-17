import 'dart:async';

import 'package:queimadas/pages/progress_bloc.dart';

class BasicBloc {

  final progress =  ProgressBloc();

  void dispose() {
    progress.dispose();
  }

}