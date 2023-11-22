import 'package:clearn_architecture_practice/util/orientation_mode.dart';
import 'package:flutter/services.dart';

class LockOrientationUseCase{
  void execute(orientationMode){
    switch (orientationMode){
      case OrientationMode.landscapeOnly:
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
        break;
      case OrientationMode.portraitOnly:
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ]);
        break;
      case OrientationMode.youNameIt:
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
          DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ]);
        break;
    }
  }
}