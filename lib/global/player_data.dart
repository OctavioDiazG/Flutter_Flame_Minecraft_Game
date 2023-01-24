

import 'package:get/get.dart';

class PlayerData{
  Rx<double> playerHealth = 10.0.obs;
  Rx<double> playerHunger = 10.0.obs;
  //State idle, walking
  ComponentMotionState componentMotionState = ComponentMotionState.idle;

  Rx<bool> playerIsDead = false.obs;
}

enum ComponentMotionState{
  walkingLeft, 
  walkingRight, 
  idle,
  jumping,
} //compare value 

