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
    GameMethods.instance.addChunkToRightWorldChunks(ChunkGenerationMethods.instance.generateChunk(0));
    GameMethods.instance.addChunkToRightWorldChunks(ChunkGenerationMethods.instance.generateChunk(1));
    renderChunk(0);
    renderChunk(1);
    renderChunk(2);
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


}