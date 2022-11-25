//import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:minecraft2d_game/layout/game_layout.dart';
//import 'package:minecraft2d_game/main_game.dart';



void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: GameLayout(),));
}

//GameWidget(game: MainGame())