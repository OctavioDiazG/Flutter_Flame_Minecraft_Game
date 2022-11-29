import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/constant.dart';

class GameMethods{
  static GameMethods get instance {
    return GameMethods();
  }
  
  Vector2 get blockSize{
    //return Vector2.all(getScreenSize().width/chunkWidth);
    return Vector2.all(40);
  }

  int get freeArea{
    return(chunkHeight * 0.2).toInt();
  }

  int get maxSecondarySoilExtent{
    return freeArea + 6;
  }

  Size getScreenSize ()
  {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  } 

  Future<SpriteSheet> getBlockSpriteSheet() async{
    return SpriteSheet(
      image: await Flame.images.load('sprite_sheets/blocks/block_sprite_sheet_original.png'), 
      srcSize: Vector2.all(60), 
    );
  }

  Future<Sprite> getSpriteFromBlock(Blocks block) async{
    SpriteSheet spriteSheet = await getBlockSpriteSheet();
    return spriteSheet.getSprite(0, block.index);
  }
  //chunk
  void addChunkToWorldChunks (List<List<Blocks?>> chunk, bool isInRightWorldChunk) {
    if (isInRightWorldChunk) {
      chunk.asMap().forEach((int yIndex, List<Blocks?> value) {
        GlobalGameReference.instance.gameReference.worldData.rightWorldChunks[yIndex].addAll(value);
      });
    } else {
      chunk.asMap().forEach((int yIndex, List<Blocks?> value) {
        GlobalGameReference.instance.gameReference.worldData.leftWorldChunks[yIndex].addAll(value);
      });
    }
  }
  
  List<List<Blocks?>> getChunk(int chunkIndex) {
    List<List<Blocks?>> chunk = [];
    if (chunkIndex >= 0) {
      GlobalGameReference.instance.gameReference.worldData.rightWorldChunks.asMap().forEach((int index, List<Blocks?> rowOfBlocks) { 
        chunk.add(rowOfBlocks.sublist(chunkWidth * chunkIndex, chunkWidth * (chunkIndex + 1)));
      });
    } else { //Left World Chunk
      GlobalGameReference.instance.gameReference.worldData.leftWorldChunks.asMap().forEach((int index, List<Blocks?> rowOfBlocks) { 
        chunk.add(rowOfBlocks.sublist(chunkWidth * (chunkIndex.abs() - 1), chunkWidth * (chunkIndex.abs())).reversed.toList());
      });
    }
    return chunk;
  }
}