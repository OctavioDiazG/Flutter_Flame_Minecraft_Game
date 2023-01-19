import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class PlayerHungerBarWidget extends StatelessWidget {
  const PlayerHungerBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
  
    return Obx((){
        List<Widget> children = [];

        double hunger = GlobalGameReference.instance.gameReference.worldData.playerData.playerHunger.value;

        for (int i = 10; i > 0; i--) {
          bool isFullHunger = false;

          if (GlobalGameReference.instance.gameReference.worldData.playerData.playerHunger.value >= i) {
            isFullHunger = true;
          }

          children.add(getHeartWidget(isFullHunger));
        }

        return Row(children: children,);
      }
    );
  }

  Widget getHeartWidget(bool fullHunger) {
    double width = GameMethods.instance.getScreenSize().width / 30;
    return SizedBox(
      width: width,
      height: width,
      child: FittedBox(
        child: Stack(
          children: [
            Image.asset('assets/images/gui/empty_hunger.png'),
            fullHunger 
              ? Image.asset('assets/images/gui/full_hunger.png')
              : Container(),
          ],
        ),
      ),
    );
  }

}