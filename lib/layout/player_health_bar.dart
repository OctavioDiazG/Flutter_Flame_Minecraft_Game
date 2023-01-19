import 'package:flutter/material.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class PlayerHealthBarWidget extends StatelessWidget {
  const PlayerHealthBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    double health = 10;

    for (int i = 10; i > 0; i--) {
      bool isFullHeart = false;

      if (health >= i) {
        isFullHeart = true;
      }

      children.add(getHeartWidget(isFullHeart));
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: children,
      ),
    );
  }

  Widget getHeartWidget(bool fullHeart) {
    double width = GameMethods.instance.getScreenSize().width / 30;
    return SizedBox(
      width: width,
      height: width,
      child: FittedBox(
        child: Stack(
          children: [
            Image.asset('assets/images/gui/empty_heart.png'),
            fullHeart 
              ? Image.asset('assets/images/gui/full_heart.png')
              : Container(),
          ],
        ),
      ),
    );
  }

}