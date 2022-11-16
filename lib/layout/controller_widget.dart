import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minecraft2d_game/widget/controller_button_widget.dart';

class ControllerWidget extends StatelessWidget {
  const ControllerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 75,
      left: 20,
      child: Row(
        children: [
          ControllerButtonWidget(path: "assets/controller/left_button.png", onPressed: (){log('leftB');},),
          ControllerButtonWidget(path: "assets/controller/center_button.png" , onPressed: (){log('centerB');}),
          ControllerButtonWidget(path: "assets/controller/right_button.png" , onPressed: (){log('rightB');}),
        ],
      ),
    );
  }
}