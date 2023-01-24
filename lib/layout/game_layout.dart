import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minecraft2d_game/layout/controller_widget.dart';
import 'package:minecraft2d_game/layout/hunger_and_health_bar.dart';
import 'package:minecraft2d_game/layout/quit_and_save_button.dart';
import 'package:minecraft2d_game/main_game.dart';
import 'package:minecraft2d_game/screens/respawn_screen.dart';
import 'package:minecraft2d_game/utils/constant.dart';
import 'package:minecraft2d_game/widget/crafting/crafting_inventory.dart';
import 'package:minecraft2d_game/widget/inventroy/item_bar.dart';
import 'package:minecraft2d_game/widget/inventroy/player_inventory.dart';

class GameLayout extends StatelessWidget {
  final int seed;
  const GameLayout({Key? key, required this.seed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //This is the main game
          GameWidget(
            game: MainGame(
              worldData: Hive.box(worldDataBox).get(seed),
            ),
          ),

          //Everything coming here will be in the hud
          const ControllerWidget(),
          const ItemBarWidget(),
          const HungerAndHealthBar(),
          const PlayerInventoryWidget(),
          const CraftingInventory(),
          const RespawnScreen(),
          const QuitAndSaveButton()
        ],
      ),
    );
  }
}