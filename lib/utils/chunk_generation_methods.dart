import 'dart:math';
import 'package:fast_noise/fast_noise.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/resources/bioms.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/constant.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class ChunkGenerationMethods{


  static ChunkGenerationMethods get instance{
    return ChunkGenerationMethods();
  }

  List<List<Blocks?>> generateNullChunk(){
    return List.generate(
      chunkHeight, (index) => List.generate(chunkWidth, (index) => null)
    );
  }

  List<List<Blocks?>> generateChunk(int chunkIndex){
    Biomes biome = Random().nextBool()? Biomes.desert : Biomes.birchForest;

    List<List<Blocks?>> chunk = generateNullChunk();

    //chunkWidth * 1 = 16, chunkWidth * 2 = 32 ...

    List<List<double>> rawNoise = noise2(
      chunkWidth * (chunkIndex + 1),
      1, 
      noiseType: NoiseType.Perlin, 
      frequency: 0.05,
      seed: GlobalGameReference.instance.gameReference.worldData.seed, //Grab the seed reference from world_data
    );

    List<int> yValues = getYValuesFromRawNoise(rawNoise);

    yValues.removeRange(0, chunkWidth * chunkIndex);

    chunk = generatePrimarySoil(chunk, yValues, biome);

    chunk = generateSecondarySoil(chunk, yValues, biome);

    chunk = generateStone(chunk);

    return chunk;
  }

  List<List<Blocks?>> generatePrimarySoil(List<List<Blocks?>> chunk, List<int> yValues, Biomes biome){
    yValues.asMap().forEach((int index, int value) {
      chunk[value][index] = BiomeData.getBiomeDataFor(biome).primarySoil;
    });
    return chunk;
  }

  List<List<Blocks?>> generateSecondarySoil(List<List<Blocks?>> chunk, List<int> yValues, Biomes biome){
    yValues.asMap().forEach((int index, int value) {
      for (int i = value + 1; i <= GameMethods.instance.maxSecondarySoilExtent; i++) {
        chunk[i][index] = BiomeData.getBiomeDataFor(biome).secondarySoil;
      }
    });

    return chunk;
  }

  List<List<Blocks?>> generateStone(List<List<Blocks?>> chunk){

    for (int index = 0; index < chunkWidth; index++) {
      for (int i = GameMethods.instance.maxSecondarySoilExtent + 1; i < chunk.length; i++) {
        chunk[i][index] = Blocks.stone;
      }
    }
    int x1 = Random().nextInt(chunkWidth ~/ 2); // ~ is the same to say .toInt()
    int x2 = x1 + Random().nextInt(chunkWidth ~/ 2);

    chunk[GameMethods.instance.maxSecondarySoilExtent].fillRange(x1, x2, Blocks.stone);

    return chunk;
  }


  List<int> getYValuesFromRawNoise (List<List<double>> rawNoise){
    List<int> yValues = [];

    rawNoise.asMap().forEach((int index, List<double> value) {
      yValues.add((value[0] * 10).toInt().abs() + GameMethods.instance.freeArea);
    });

    return yValues;
  }
}

/*

 chunk = [

  [Null, null, null, null],
  [Blocks.grass, Blocks.dirt],
  [],
  [],
  [],
  [],
  [],
  [null, null, null],
  [Blocks.stone, blocks.stone],
  [],
  [],
  [],

 ]

*/