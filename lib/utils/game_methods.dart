import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/constant.dart';

enum Direction { top, bottom, left, right }

class GameMethods{
  static GameMethods get instance {
    return GameMethods();
  }
  
  Vector2 get blockSize{
    return Vector2.all(getScreenSize().width/chunkWidth);
    //return Vector2.all(20);
  }

  int get freeArea{
    return(chunkHeight * 0.4).toInt();
  }

  int get maxSecondarySoilExtent{ //how many blocks are after the first soil (from top to down)
    return freeArea + 6;
  }

  double get playerXIndexPosition{
    return GlobalGameReference.instance.gameReference.playerComponent.position.x / blockSize.x;
  }
  
  double get playerYIndexPosition{
    return GlobalGameReference.instance.gameReference.playerComponent.position.y / blockSize.y;
  }

  int get currentChunkPlayerIndex{
    return playerXIndexPosition >= 0 
      ? playerXIndexPosition ~/ chunkWidth 
      : (playerXIndexPosition ~/ chunkWidth) - 1;
  }

  double get gravity {
    return blockSize.x * 0.8; //check if it works
  }

  int getChunkIndexFromPositionIndex(Vector2 positionIndex){
    return positionIndex.x >= 0 
      ? positionIndex.x ~/ chunkWidth 
      : (positionIndex.x ~/ chunkWidth) - 1;
  }

  Vector2 getIndexPositionFromPixels(Vector2 clickPosision){
    return Vector2(
      (clickPosision.x / blockSize.x).floorToDouble(), 
      (clickPosision.y / blockSize.y).floorToDouble()
    );
  }

  Size getScreenSize()
  {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  } 

  SpriteSheet getBlockSpriteSheet() {
    return SpriteSheet(
      image: Flame.images.fromCache('sprite_sheets/blocks/block_sprite_sheet.png'), 
      srcSize: Vector2.all(60), 
    );
  }

  Future<Sprite> getSpriteFromBlock(Blocks block) async{
    SpriteSheet spriteSheet = await getBlockSpriteSheet();
    return spriteSheet.getSprite(0, block.index);
  }
  //chunk
  void addChunkToWorldChunks(List<List<Blocks?>> chunk, bool isInRightWorldChunk) {
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

  List<List<int>> processNoise(List<List<double>> rawNoise){
    List<List<int>> processedNoise = List.generate(
      rawNoise.length, 
      (index) => List.generate(rawNoise[0].length, (index) => 255),
    );
    for (var x = 0; x < rawNoise.length; x++) {
      for (var y = 0; y < rawNoise[0].length; y++) {
        int value = (0x80 + 0x80 * rawNoise[x][y]).floor(); // grayscale
        processedNoise[x][y] = value;
      }
    }
    return processedNoise;
  }

  void repleceBlockAtWorldChunks(Blocks? block, Vector2 blockIndex) {
    if (blockIndex.x >= 0) {
      GlobalGameReference.instance.gameReference.worldData.rightWorldChunks[blockIndex.y.toInt()][blockIndex.x.toInt()] = block;
    } 
    else {
      GlobalGameReference.instance.gameReference.worldData.leftWorldChunks[blockIndex.y.toInt()][blockIndex.x.toInt().abs() - 1] = block;
    }
  }

  bool playerIsWithinRange(Vector2 positionIndex) {
    
    if((positionIndex.x - playerXIndexPosition).abs() <= maxReach && (positionIndex.y - playerYIndexPosition).abs() <= maxReach){
      return true;
    }
    return false;
  }

  Blocks? getBlockAtIndexPosition(Vector2 blockIndex){

    if (blockIndex.x >= 0) {
      return GlobalGameReference.instance.gameReference.worldData.rightWorldChunks[blockIndex.y.toInt()][blockIndex.x.toInt()];
    } 
    else {
      return GlobalGameReference.instance.gameReference.worldData.leftWorldChunks[blockIndex.y.toInt()][blockIndex.x.toInt().abs() - 1];
    }

  }
  Blocks? getBlocksAtDirection(Vector2 blockIndex, Direction direction){
    switch (direction) {
      case Direction.top:
      try{
        return getBlockAtIndexPosition(Vector2(blockIndex.x, blockIndex.y - 1));
      }catch(e){
        break;
      }
        //return getBlockAtIndexPosition(blockIndex + Vector2(0, -1));
      case Direction.bottom:
      try{
        return getBlockAtIndexPosition(Vector2(blockIndex.x, blockIndex.y + 1));
      }catch(e){
        break;
      }
        //return getBlockAtIndexPosition(blockIndex + Vector2(0, 1));
      case Direction.left:
      try{
        return getBlockAtIndexPosition(Vector2(blockIndex.x - 1, blockIndex.y));
      }catch(e){
        break;
      }
        //return getBlockAtIndexPosition(blockIndex + Vector2(-1, 0));
      case Direction.right:
      try{
        return getBlockAtIndexPosition(Vector2(blockIndex.x + 1, blockIndex.y));
      }catch(e){
        break;
      }
        //return getBlockAtIndexPosition(blockIndex + Vector2(1, 0));
      default:
        return null;
    }
  }

  bool adjacentBlocksExist(Vector2 blockIndex){
    if(getBlocksAtDirection(blockIndex, Direction.top) is Blocks){
      return true;
    } 
    else if(getBlocksAtDirection(blockIndex, Direction.bottom) is Blocks){
      return true;
    }
    else if(getBlocksAtDirection(blockIndex, Direction.left) is Blocks){
      return true;
    }
    else if(getBlocksAtDirection(blockIndex, Direction.right) is Blocks){
      return true;
    }
    return false;
  }

}