import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/resources/structures.dart';
import 'package:minecraft2d_game/structures/plants.dart';
import 'package:minecraft2d_game/structures/trees.dart';

enum Biomes{ desert, birchForest }

class BiomeData{
  final Blocks primarySoil;
  final Blocks secondarySoil;
  final List<Structure> generatingStructures;

  BiomeData({required this.primarySoil, required this.secondarySoil, required this.generatingStructures});


  factory BiomeData.getBiomeDataFor(Biomes biome){
    switch (biome) {
      case Biomes.desert:
        return BiomeData(primarySoil: Blocks.sand, secondarySoil: Blocks.sand, generatingStructures: [
          cactus,
          deadBush,
        ]);
      case Biomes.birchForest:
        return BiomeData(primarySoil: Blocks.grass, secondarySoil: Blocks.dirt, generatingStructures: [
          birchTree, 
          redFlower, whiteFlower, purpleFlower, yellowFlower, drippingWhiteFlower, 
        ]);
    }
  }

}