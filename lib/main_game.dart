import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:minecraft2d_game/components/block_component.dart';
import 'package:minecraft2d_game/components/player_component.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/world_data.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/chunk_generation_methods.dart';
import 'package:minecraft2d_game/utils/constant.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';


class MainGame extends FlameGame{
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
    GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(-1), false);
    GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(0), true);
    GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(1), true);
    renderChunk(-1);
    renderChunk(0);
    renderChunk(1);
  }

  void renderChunk(int chunkIndex){
    List<List<Blocks?>> chunk = GameMethods.instance.getChunk(chunkIndex);
    chunk.asMap().forEach((int yIndex, List<Blocks?> rowOfBlocks) {
      rowOfBlocks.asMap().forEach((int xIndex, Blocks? block) { 
        if (block != null) {
          add(BlockComponent(block: block, blockIndex: Vector2((chunkIndex * chunkWidth) + xIndex.toDouble(), yIndex.toDouble())));
        }
      });
    });
  }

  @override
  void update(double dt){ //get the dt as delta time to get every frame posible of the playerPos.x
    super.update(dt);
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

}

/*

        //Chunk has not been created
        if (worldData.rightWorldChunks[0].length ~/ chunkWidth < chunkIndex + 1) {
          GameMethods.instance.addChunkToWorldChunks(ChunkGenerationMethods.instance.generateChunk(chunkIndex), true);
        }

          renderChunk(chunkIndex);

          worldData.currentRenderedChunk.add(chunkIndex);
 */