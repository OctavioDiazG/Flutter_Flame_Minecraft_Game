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

  BlockData({
    required this.isCollidable, 
    required this.baseMiningSpeed, 
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

  static BlockData plants = BlockData(isCollidable: false, baseMiningSpeed: 0.00001);
  static BlockData soil = BlockData(isCollidable: true, baseMiningSpeed: 0.75);
  static BlockData wood = BlockData(isCollidable: false, baseMiningSpeed: 3);
  static BlockData leaf = BlockData(isCollidable: false, baseMiningSpeed: 0.35);
  static BlockData stone  = BlockData(isCollidable: true, baseMiningSpeed: 4);
  static BlockData woodPlank  = BlockData(isCollidable: true, baseMiningSpeed: 2.5);
  static BlockData unbreakable  = BlockData(isCollidable: true, baseMiningSpeed: 999999, breakable: false);


}