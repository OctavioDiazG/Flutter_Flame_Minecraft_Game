import 'package:minecraft2d_game/global/player_data.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/constant.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class WorldData {
  final int seed;

  WorldData({required this.seed});

  PlayerData playerData = PlayerData();

  //Collection of all the chunk from 0 so chunks -1,0,1 will be rendered
  List<List<Blocks?>> rightWorldChunks = List.generate(chunkHeight, (index) => []);
  List<List<Blocks?>> leftWorldChunks = List.generate(chunkHeight, (index) => []);

  List<int> get chunksThatShouldBeRendered{
    return [  //the number of chunks that should be render depending on the player pos
      GameMethods.instance.inCurrentChunkIndex - 1,
      GameMethods.instance.inCurrentChunkIndex ,
      GameMethods.instance.inCurrentChunkIndex + 1,
    ];
  }


}