import 'package:flame/components.dart';
import 'package:minecraft2d_game/blocks/birch_leaf_block.dart';
import 'package:minecraft2d_game/blocks/coal_ore_block.dart';
import 'package:minecraft2d_game/blocks/crafting_table_block.dart';
import 'package:minecraft2d_game/blocks/diamond_ore_block.dart';
import 'package:minecraft2d_game/blocks/gold_ore_block.dart';
import 'package:minecraft2d_game/blocks/iron_ore_block.dart';
import 'package:minecraft2d_game/blocks/sand_block.dart';
import 'package:minecraft2d_game/blocks/stone_block.dart';
import 'package:minecraft2d_game/components/block_component.dart';
import 'package:minecraft2d_game/resources/items.dart';

enum Blocks{
  grass,
  dirt,
  stone,
  birchLog,
  birchLeaf,
  cactus,
  deadBush,
  sand,
  coalOre,
  ironOre,
  diamondOre,
  goldOre,
  grassPlant,
  redFlower,
  purpleFlower,
  drippingWhiteFlower,
  yellowFlower,
  whiteFlower,
  birchPlank,
  craftingTable,
  cobbleStone,
  bedrock,
  
}

class  BlockData {
  final bool isCollidable;
  final double baseMiningSpeed; //seconds
  final bool breakable;

  final Tools suitableTool;

  BlockData({
    required this.isCollidable, 
    required this.baseMiningSpeed, 
    required this.suitableTool, 
    this.breakable = true
  });

  factory BlockData.getBlockDataFor(Blocks block){
    switch (block) {
      case Blocks.grass:
        return soil;
      case Blocks.dirt:
        return soil;
      case Blocks.stone:
        return stone;
      case Blocks.birchLog:
        return wood;
      case Blocks.birchLeaf:
        return leaf;
      case Blocks.cactus:
        return plants;
      case Blocks.deadBush:
        return plants;
      case Blocks.sand:
        return soil;
      case Blocks.coalOre:
        return stone;
      case Blocks.ironOre:
        return stone;
      case Blocks.diamondOre:
        return stone;
      case Blocks.goldOre:
        return stone;
      case Blocks.grassPlant:
        return plants;
      case Blocks.redFlower:
        return plants;
      case Blocks.purpleFlower:
        return plants;
      case Blocks.drippingWhiteFlower:
        return plants;
      case Blocks.yellowFlower:
        return plants;
      case Blocks.whiteFlower:
        return plants;
      case Blocks.birchPlank:
        return woodPlank;
      case Blocks.craftingTable:
        return woodPlank;
      case Blocks.cobbleStone:
        return stone;
      case Blocks.bedrock:
        return unbreakable;
    }
  }

  static BlockComponent getParentForBlock(
      Blocks block, Vector2 blockIndex, int chunkIndex) {
    switch (block) {
      case Blocks.craftingTable:
        return CraftingTableBlock(
            chunkIndex: chunkIndex, blockIndex: blockIndex);

       case Blocks.birchLeaf:
        return BirchLeafBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      case Blocks.stone:
        return StoneBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      case Blocks.coalOre:
        return CoalOreBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      case Blocks.ironOre:
        return IronOreBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      case Blocks.diamondOre:
        return DiamondOreBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      case Blocks.goldOre:
        return GoldOreBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      case Blocks.sand:
        return SandBlock(blockIndex: blockIndex, chunkIndex: chunkIndex);

      default:
        return BlockComponent(
            block: block, blockIndex: blockIndex, chunkIndex: chunkIndex);
    }
  }

  static BlockData plants = BlockData(isCollidable: false, baseMiningSpeed: 0.00001, suitableTool: Tools.none);
  static BlockData soil = BlockData(isCollidable: true, baseMiningSpeed: 0.75, suitableTool: Tools.shovel);
  static BlockData wood = BlockData(isCollidable: false, baseMiningSpeed: 3, suitableTool: Tools.axe);
  static BlockData leaf = BlockData(isCollidable: false, baseMiningSpeed: 0.35, suitableTool: Tools.axe);
  static BlockData stone  = BlockData(isCollidable: true, baseMiningSpeed: 4, suitableTool: Tools.pickaxe);
  static BlockData woodPlank  = BlockData(isCollidable: true, baseMiningSpeed: 2.5, suitableTool: Tools.axe);
  static BlockData unbreakable  = BlockData(isCollidable: true, baseMiningSpeed: 1, breakable: false, suitableTool: Tools.none);


}