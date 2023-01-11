import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:minecraft2d_game/components/block_component.dart';
import 'package:minecraft2d_game/components/item_component.dart';
import 'package:minecraft2d_game/components/player_component.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/player_data.dart';
import 'package:minecraft2d_game/global/world_data.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/chunk_generation_methods.dart';
import 'package:minecraft2d_game/utils/constant.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';


class MainGame extends FlameGame with HasCollisionDetection, HasTappables, HasKeyboardHandlerComponents{ //Has CollisionDetection is telling the program is will have Collition Detection
  final WorldData worldData;

  MainGame({required this.worldData}){
    globalGameReference.gameReference = this; 
  }
  
  GlobalGameReference globalGameReference = Get.put(GlobalGameReference()); 

  PlayerComponent playerComponent = PlayerComponent();

  @override
  Future<void> onLoad() async{
    super.onLoad();
    //print(ChunkGenerationMethods.instance.generateChunk()); //ERASE
    camera.followComponent(playerComponent);
    
    add(playerComponent);
    /*
    //GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(-1), false);
    //GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(0), true);
    //GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(1), true);
    //renderChunk(-1);
    //renderChunk(0);
    //renderChunk(1);
    */
  }

  void renderChunk(int chunkIndex){
    List<List<Blocks?>> chunk = GameMethods.instance.getChunk(chunkIndex);
    chunk.asMap().forEach((int yIndex, List<Blocks?> rowOfBlocks) {
      rowOfBlocks.asMap().forEach((int xIndex, Blocks? block) { 
        if (block != null) {
          add(BlockComponent(
            block: block, 
            blockIndex: Vector2((chunkIndex * chunkWidth) + xIndex.toDouble(), 
            yIndex.toDouble()), 
            chunkIndex: chunkIndex ));
        }
      });
    });
  }

  @override
  void update(double dt){ //get the dt as delta time to get every frame posible of the playerPos.x
    super.update(dt);

    itemRenderingLogic();

    //print(worldData.chunksThatShouldBeRendered);
    worldData.chunksThatShouldBeRendered.asMap().forEach((int index, int chunkIndex) {

      //chunk isnt rendered
      if (!worldData.currentRenderedChunk.contains(chunkIndex)) {
        //For right world chunk
        if (chunkIndex >= 0) {
          //Chunk has not been created
          if (worldData.rightWorldChunks[0].length ~/ chunkWidth < chunkIndex + 1) {
            GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(chunkIndex), true);
          }

            renderChunk(chunkIndex);

            worldData.currentRenderedChunk.add(chunkIndex);
            //For Left World Chunk
        } else {
          
        //Chunk has not been created
        if (worldData.leftWorldChunks[0].length ~/ chunkWidth < chunkIndex.abs()) {
          GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(chunkIndex), false);
        }

          renderChunk(chunkIndex);

          worldData.currentRenderedChunk.add(chunkIndex);
        }
      }
    });
  }

  void itemRenderingLogic(){
    //logic
    worldData.items.asMap().forEach((int index, ItemComponent item) {

      if (!item.isMounted ) {
        if (worldData.chunksThatShouldBeRendered.contains(GameMethods.instance.getChunkIndexFromPositionIndex(item.spawnBlockIndex))) {
          add(item);
          //item.isRendered = true;
        }
      } else {
        if (!worldData.chunksThatShouldBeRendered.contains(GameMethods.instance.getChunkIndexFromPositionIndex(item.spawnBlockIndex))) {
          remove(item);
          //item.isRendered = false;
        }
      }
    });
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed,) {
    super.onKeyEvent(event, keysPressed);
    //print(keysPressed);
    //Keyes that make the player go right
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) || keysPressed.contains(LogicalKeyboardKey.keyD)) {
      //print("Right");
      worldData.playerData.componentMotionState = ComponentMotionState.walkingRight;
    }
     //Keyes that make the player go left
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) || keysPressed.contains(LogicalKeyboardKey.keyA)) {
      //print("Left");
      worldData.playerData.componentMotionState = ComponentMotionState.walkingLeft;
    }
     //Keyes that make the player go up
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp) || keysPressed.contains(LogicalKeyboardKey.keyW) || keysPressed.contains(LogicalKeyboardKey.space)) {
      //print("Up");
      worldData.playerData.componentMotionState = ComponentMotionState.jumping;
    }

    if (keysPressed.isEmpty) {
      worldData.playerData.componentMotionState = ComponentMotionState.idle;
    }
    return KeyEventResult.ignored;
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);


    Vector2 blockPlacingPosition = GameMethods.instance.getIndexPositionFromPixels(info.eventPosition.game);

    placeBlockLogic(blockPlacingPosition, Blocks.dirt);
  }

  void placeBlockLogic(Vector2 blockPlacingPosition, Blocks block){

    if (blockPlacingPosition.y > 0 && 
      blockPlacingPosition.y < chunkHeight && 
      GameMethods.instance.playerIsWithinRange(blockPlacingPosition) && 
      GameMethods.instance.getBlockAtIndexPosition(blockPlacingPosition) == null &&
      GameMethods.instance.adjacentBlocksExist(blockPlacingPosition) 
      && worldData.inventoryManager.inventorySlots[worldData.inventoryManager.currentSelectedInventorySlot.value].block != null) {
      
      GameMethods.instance.repleceBlockAtWorldChunks(worldData.inventoryManager.inventorySlots[worldData.inventoryManager.currentSelectedInventorySlot.value].block, blockPlacingPosition);
      
      add(BlockComponent(
        block: worldData.inventoryManager.inventorySlots[worldData.inventoryManager.currentSelectedInventorySlot.value].block!,
        blockIndex: blockPlacingPosition,
        chunkIndex: GameMethods.instance
          .getChunkIndexFromPositionIndex(blockPlacingPosition)));
      worldData.inventoryManager.inventorySlots[worldData.inventoryManager.currentSelectedInventorySlot.value].decrementCount();    
    }     
  }

}