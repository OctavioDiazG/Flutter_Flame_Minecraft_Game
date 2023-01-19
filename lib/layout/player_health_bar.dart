import 'package:flutter/material.dart';

class PlayerHealthBarWidget extends StatelessWidget {
  const PlayerHealthBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < 10; i++) {
      children.add(getHeartWidget(true));
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: children,
      ),
    );
  }

  Widget getHeartWidget(bool fullHeart) {
    return Stack(
      children: [
        Image.asset('assets/images/gui/empty_heart.png'),
        fullHeart 
          ? Image.asset('assets/images/gui/full_heart.png')
          : Container(),
      ],
    );
  }

}