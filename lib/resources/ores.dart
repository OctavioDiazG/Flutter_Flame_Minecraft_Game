

import 'package:minecraft2d_game/resources/blocks.dart';

class Ores{
  final Blocks block;
  final int rarity;

  Ores({required this.block, required this.rarity});

  static Ores coalOre = Ores(block: Blocks.coalOre, rarity: 60);
  static Ores ironOre = Ores(block: Blocks.ironOre, rarity: 50);
  static Ores goldOre = Ores(block: Blocks.goldOre, rarity: 40);
  static Ores diamondOre = Ores(block: Blocks.diamondOre, rarity: 30);



  
}