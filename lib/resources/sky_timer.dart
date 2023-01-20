import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/utils/constant.dart';

enum SkyTimerEnum{
  morning,
  evening,
  night,
}

class SkyTimer{
  double skyTimerSeconds = 0;

  SkyTimerEnum skyTime = SkyTimerEnum.morning;

  void updateTimer(double dt){
    skyTimerSeconds += dt;
    if (skyTimerSeconds >= totalTimeInADay / 3) {
      if (skyTime == SkyTimerEnum.morning) {
        skyTime = SkyTimerEnum.evening;
        GlobalGameReference.instance.gameReference.skyComponent.parallax = GlobalGameReference.instance.gameReference.skyComponent.eveningSky.parallax;
      } else if (skyTime == SkyTimerEnum.evening) {
        skyTime = SkyTimerEnum.night;
        GlobalGameReference.instance.gameReference.skyComponent.parallax = GlobalGameReference.instance.gameReference.skyComponent.nightSky.parallax;
      } else if (skyTime == SkyTimerEnum.night) {
        skyTime = SkyTimerEnum.morning;
        GlobalGameReference.instance.gameReference.skyComponent.parallax = GlobalGameReference.instance.gameReference.skyComponent.morningSky.parallax;
      } 
      print("SkyTime: $skyTime");
      skyTimerSeconds = 0;
    }
  }
}

