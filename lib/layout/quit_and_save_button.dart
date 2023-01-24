import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/screens/menu_screen.dart';
import 'package:minecraft2d_game/utils/constant.dart';

class QuitAndSaveButton extends StatelessWidget {
  const QuitAndSaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () {
              //saving world
              Hive.box(worldDataBox).put(GlobalGameReference.instance.gameReference.worldData.seed, GlobalGameReference.instance.gameReference.worldData);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MenuScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.grey[800]!,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}