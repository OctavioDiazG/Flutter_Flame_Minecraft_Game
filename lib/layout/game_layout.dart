import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:minecraft2d_game/global/world_data.dart';
import 'package:minecraft2d_game/layout/controller_widget.dart';
import 'package:minecraft2d_game/layout/hunger_and_health_bar.dart';
import 'package:minecraft2d_game/main_game.dart';
import 'package:minecraft2d_game/screens/respawn_screen.dart';
import 'package:minecraft2d_game/widget/crafting/crafting_inventory.dart';
import 'package:minecraft2d_game/layout/item_bar.dart';
import 'package:minecraft2d_game/widget/inventroy/player_inventory.dart';

class GameLayout extends StatelessWidget {
   
  const GameLayout({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    //Random random = Random();
    //int randomSeed = Random().nextInt(1000000); //Random Generator 
    return Stack(
      children: [

        //This is the maing game
        GameWidget(game: MainGame(worldData: WorldData(seed: 437))), //set randomSeed in seed:

        //Every coming here will be in the HUD
        const ControllerWidget(),
        const ItemBarWidget(),
        const HungerAndHealthBarWidget(),
        const PlayerInventoryWidget(),
        const CraftingInventory(),
        const RespawnScreen(),
      ],
    );
  }
}