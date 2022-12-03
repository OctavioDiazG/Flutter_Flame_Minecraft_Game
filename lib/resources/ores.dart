

import 'package:minecraft2d_game/resources/blocks.dart';

class Ores{
  final Blocks block;
  final int rarity;

  Ores({required this.block, required this.rarity});

  static Ores coalOre = Ores(block: Blocks.coalOre, rarity: 90);
  static Ores ironOre = Ores(block: Blocks.ironOre, rarity: 70);
  static Ores goldOre = Ores(block: Blocks.goldOre, rarity: 60);
  static Ores diamondOre = Ores(block: Blocks.diamondOre, rarity: 50);



  
}