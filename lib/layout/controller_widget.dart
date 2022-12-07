import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/player_data.dart';
import 'package:minecraft2d_game/widget/controller_button_widget.dart';

class ControllerWidget extends StatelessWidget {
  const ControllerWidget({super.key});

  @override
  Widget build(BuildContext context) {

    PlayerData playerData = GlobalGameReference.instance.gameReference.worldData.playerData;

    return Positioned(
      bottom: 75,
      left: 20,
      child: Row(
        children: [
          ControllerButtonWidget( //Left Movement Button
            path: "assets/controller/left_button.png", 
            onPressed: (){
              playerData.componentMotionState = ComponentMotionState.walkingLeft;
            }),
          ControllerButtonWidget( //Center Movement Button
            path: "assets/controller/center_button.png",
            onPressed: (){
              log('centerB');
              //playerData.componentMotionState = ComponentMotionState.jump; //JUMP ANIM
            }),
          ControllerButtonWidget( //Right Movement Button
            path: "assets/controller/right_button.png",
            onPressed: (){
              playerData.componentMotionState = ComponentMotionState.walkingRight;
            }),
        ],
      ),
    );
  }
}