import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/resources/gravity_block.dart';

class SandBlock extends GravityBlock {
  SandBlock({required super.blockIndex, required super.chunkIndex})
      : super(block: Blocks.sand);
} 