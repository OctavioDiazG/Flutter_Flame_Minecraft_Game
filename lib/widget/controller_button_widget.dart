import 'package:flutter/material.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/player_data.dart';

class ControllerButtonWidget extends StatefulWidget {
  final String path; //the path where my asset is located
  final VoidCallback onPressed;
  const ControllerButtonWidget({Key? key, required this.path, required this.onPressed}) : super(key: key);

  @override
  State<ControllerButtonWidget> createState() => _ControllerButtonWidgetState();
}

class _ControllerButtonWidgetState extends State<ControllerButtonWidget> {
  bool isPressed = false; //bool for the buttons
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTapDown: (_){  
          setState(() { //Redraw the widget when pressed
            isPressed = true;
            widget.onPressed();
          });
        },
        onTapUp: (_){
          setState(() { //Redraw the widget when pressed
            isPressed = false;
            GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState = ComponentMotionState.idle;
          });
        },
        child: Opacity(
          opacity: isPressed? 0.5 : 0.8,
          child: SizedBox(
            height: screenSize.width/20, 
            width: screenSize.width/20, 
            child: Image.asset(widget.path),
          ),
        ),
      ),
    );
  }
}