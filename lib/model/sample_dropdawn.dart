import 'package:queimadas/focus_fire.dart';
import 'package:queimadas/widgets/app_dropdaw.dart';

class SampleDropdawn extends DropdownItem {

  String focusFire;
  int qtd;

  @override
  String labelShow() {
    return "$focusFire - $qtd";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SampleDropdawn &&
              runtimeType == other.runtimeType &&
              focusFire == other.focusFire;

  @override
  int get hashCode => focusFire.hashCode;






}