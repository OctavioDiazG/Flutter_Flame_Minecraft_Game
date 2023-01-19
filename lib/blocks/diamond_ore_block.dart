import 'package:minecraft2d_game/components/block_component.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/resources/items.dart';

class DiamondOreBlock extends BlockComponent {
  DiamondOreBlock({required super.blockIndex, required super.chunkIndex})
      : super(block: Blocks.diamondOre);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    itemDropped = Items.diamond;
  }
}