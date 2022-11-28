import 'package:minecraft2d_game/global/player_data.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/constant.dart';

class WorldData {
  final int seed;

  WorldData({required this.seed});

  PlayerData playerData = PlayerData();

  //Collection of all the chunk from 0 so chunks -1,0,1 will be rendered
  List<List<Blocks?>> rightWorldChunks = List.generate(chunkHeight, (index) => []);


}