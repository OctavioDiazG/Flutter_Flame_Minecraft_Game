import 'package:flame/input.dart';
import 'package:minecraft2d_game/components/block_component.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/inventory.dart';
import 'package:minecraft2d_game/resources/blocks.dart';

class CraftingTableBlock extends BlockComponent {
  CraftingTableBlock({required super.chunkIndex, required super.blockIndex})
      : super(block: Blocks.craftingTable);

  InventoryManager inventoryManager =
      GlobalGameReference.instance.gameReference.worldData.inventoryManager;

  @override
  bool onTapDown(TapDownInfo info) {
    //PLayer is not holding anyhting
    if (inventoryManager
            .inventorySlots[inventoryManager.currentSelectedInventorySlot.value]
            .block ==
        null) {
      GlobalGameReference.instance.gameReference.worldData.craftingManager
          .craftingInventoryIsOpen.value = true;
    } else {
      //break block
      super.onTapDown(info);
    }

    return true;
  }
}