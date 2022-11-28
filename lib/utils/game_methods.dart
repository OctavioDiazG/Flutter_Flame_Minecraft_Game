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

  Future<SpriteSheet> getBlockSpritesheet() async{
    return SpriteSheet(
      image: await Flame.images.load('sprite_sheets/blocks/block_sprite_sheet_original.png'), 
      srcSize: Vector2.all(60), 
    );
  }

  Future<Sprite> getSpriteFromBlock(Blocks block) async{
    SpriteSheet spriteSheet = await getBlockSpritesheet();
    return spriteSheet.getSprite(0, block.index);
  }
  //chunk
  void addChunkToRightWorldChunks (List<List<Blocks?>> chunk) {
    chunk.asMap().forEach((int index, List<Blocks?> value) {
      GlobalGameReference.instance.gameReference.worldData.rightWorldChunks[index].addAll(value);
    });
  }
}