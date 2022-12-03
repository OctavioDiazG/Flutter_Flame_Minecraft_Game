import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/resources/structures.dart';

Structure cactus = Structure(
  structure: [
    [Blocks.cactus],
    [Blocks.cactus],
  ],
  maxOccurences: 0,
  maxWidth: 1
);

Structure deadBush = Structure(
  structure: [[Blocks.deadBush]], 
  maxOccurences: 2, 
  maxWidth: 1
);

Structure redFlower = Structure.getPlantStructureForBlock(Blocks.redFlower);
Structure whiteFlower = Structure.getPlantStructureForBlock(Blocks.whiteFlower);
Structure purpleFlower = Structure.getPlantStructureForBlock(Blocks.purpleFlower);
Structure yellowFlower = Structure.getPlantStructureForBlock(Blocks.yellowFlower);
Structure drippingWhiteFlower = Structure.getPlantStructureForBlock(Blocks.drippingWhiteFlower);