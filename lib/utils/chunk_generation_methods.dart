import 'dart:math';
import 'package:fast_noise/fast_noise.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/resources/bioms.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/resources/structures.dart';
import 'package:minecraft2d_game/structures/plants.dart';
import 'package:minecraft2d_game/structures/trees.dart';
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
      chunkIndex >= 0 ? chunkWidth * (chunkIndex + 1) : chunkWidth * (chunkIndex.abs()), //-1
      1, 
      noiseType: NoiseType.Perlin, 
      frequency: 0.05,
      seed: chunkIndex >= 0 
        ? GlobalGameReference.instance.gameReference.worldData.seed 
        : GlobalGameReference.instance.gameReference.worldData.seed + 1, //Grab the seed reference from world_data
    );

    List<int> yValues = getYValuesFromRawNoise(rawNoise);

    yValues.removeRange(0, chunkIndex >= 0? chunkWidth * chunkIndex: chunkWidth * (chunkIndex.abs() - 1));

    chunk = generatePrimarySoil(chunk, yValues, biome);

    chunk = generateSecondarySoil(chunk, yValues, biome);

    chunk = generateStone(chunk);

    chunk = addStructureToChunk(chunk, yValues, biome);

    chunk = addOreToChunkList(chunk, Blocks.ironOre);



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

  List<List<Blocks?>> addStructureToChunk(List<List<Blocks?>> chunk, List<int> yValues, Biomes biome){
    
    BiomeData.getBiomeDataFor(biome).generatingStructures.asMap().forEach((key, Structure currentStructure) {
      int randomOcurrences = 1;

      if (currentStructure == birchTree) {
        randomOcurrences = Random().nextInt(3); //Random Generator 
      }
      if (currentStructure == cactus) {
        randomOcurrences = Random().nextInt(5); //Random Generator 
      } //TODO: Change if statement for switch

      for (int ocurrence = 0; ocurrence < currentStructure.maxOccurences + randomOcurrences; ocurrence++) {

        List<List<Blocks?>> structureList = List.from(currentStructure.structure.reversed);
  
        int xPositionOfStructure = Random().nextInt(chunkWidth - currentStructure.maxWidth);
        int yPositionOfStructure = (yValues[xPositionOfStructure + (currentStructure.maxWidth ~/ 2)]) - 1;
  
        for (int indexOfRow = 0; indexOfRow < currentStructure.structure.length; indexOfRow++) {
          List<Blocks?> rowOfBlocksInStructure = structureList[indexOfRow];
  
          rowOfBlocksInStructure.asMap().forEach((int index, Blocks? blockInStructure) {
          if (chunk[yPositionOfStructure - (indexOfRow)][xPositionOfStructure + index] == null) {
            chunk[yPositionOfStructure - indexOfRow][xPositionOfStructure + index] = blockInStructure; 
          }
          });
        }
      }
    });

    return chunk;
  }


  List<int> getYValuesFromRawNoise(List<List<double>> rawNoise){
    List<int> yValues = [];

    rawNoise.asMap().forEach((int index, List<double> value) {
      yValues.add((value[0] * 10).toInt().abs() + GameMethods.instance.freeArea);
    });

    return yValues;
  }

  List<List<Blocks?>> addOreToChunkList(List<List<Blocks?>> chunk, Blocks block ){
    List<List<double>> rawNoise = noise2(chunkHeight, chunkWidth,
      noiseType: NoiseType.Perlin, 
      frequency: 0.055, 
      seed: Random().nextInt(123124234)
    );
    List<List<int>> processedNoise = GameMethods.instance.processNoise(rawNoise);
    processedNoise.asMap().forEach((int rowOfProcessedNoiseIndex, List<int> rowOfProcessedNoise) {
      rowOfProcessedNoise.asMap().forEach((int index, int value) {
        if (value < 90 && chunk[rowOfProcessedNoiseIndex][index] == Blocks.stone) {
          chunk[rowOfProcessedNoiseIndex][index] = block;
        }
       });
     });
    return chunk;
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