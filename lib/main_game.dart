import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:minecraft2d_game/components/block_component.dart';
import 'package:minecraft2d_game/components/player_component.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/world_data.dart';
import 'package:minecraft2d_game/resources/blocks.dart';


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
    add(playerComponent);
    add(BlockComponent(block: Blocks.grass));
  }
}