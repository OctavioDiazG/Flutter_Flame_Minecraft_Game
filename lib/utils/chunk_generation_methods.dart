import 'dart:developer';

import 'package:fast_noise/fast_noise.dart';
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

  List<List<Blocks?>> generateChunk(){
    List<List<Blocks?>> chunk = generateNullChunk();

    List<List<double>> rawNoise = noise2(
      chunkWidth, 
      1, 
      noiseType: NoiseType.Perlin, 
      frequency: 0.05,
      seed: 7686987,
    );

    //log(getYValuesFromRawNoise(rawNoise).toString());
    List<int> yValues = getYValuesFromRawNoise(rawNoise);

    yValues.asMap().forEach((int index, int value) {
      chunk[value + GameMethods.instance.freeArea][index] = Blocks.grass;
    });


    return chunk;
  }

  List<int> getYValuesFromRawNoise (List<List<double>> rawNoise){
    List<int> yValues = [];

    rawNoise.asMap().forEach((int index, List<double> value) {
      yValues.add((value[0] * 10).toInt().abs());
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