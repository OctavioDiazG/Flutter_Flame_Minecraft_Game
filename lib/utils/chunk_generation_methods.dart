import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/constant.dart';

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

    //the 5th y level will be grass
    chunk.asMap().forEach((int indexOfRow, List<Blocks?> rowOfBlocks ) {
      if(indexOfRow == 5){
        //[null, null, null, null]
        rowOfBlocks.asMap().forEach((int index, Blocks? blocks) { 
          chunk[5][index] = Blocks.grass;
        });
      }
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