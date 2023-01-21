//import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:minecraft2d_game/layout/game_layout.dart';
//import 'package:minecraft2d_game/main_game.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  //load all images so can usedem form the cahe and not the memory
  //Blocks
  await Flame.images.load("sprite_sheets/blocks/block_breaking_sprite_sheet.png");
  await Flame.images.load('sprite_sheets/blocks/block_sprite_sheet.png');

  //player
  //await Flame.images.load('sprite_sheets/player/player_walking_sprite_sheet.png');
  await Flame.images.load('sprite_sheets/own_imports/new_player_walk.png'); //new player walk
  //await Flame.images.load('sprite_sheets/player/player_idle_sprite_sheet.png');
  await Flame.images.load('sprite_sheets/own_imports/new_player_idle.png'); //new player idle

  //items
  await Flame.images.load('sprite_sheets/item/item_sprite_sheet.png');

  //mobs
  await Flame.images.load('sprite_sheets/mobs/sprite_sheet_zombie.png'); //zombie image
  await Flame.images.load('sprite_sheets/mobs/sprite_sheet_spider.png'); //spider image

  
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: Scaffold(body: GameLayout()),));
}

//GameWidget(game: MainGame())