import 'package:get/get.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/inventory.dart';

class CraftingManager{

  Rx<bool> craftingInventoryIsOpen = false.obs;

  List<InventorySlot> playerInventoryCraftingGrid = List.generate(5, (index) => InventorySlot(index: index,));
  List<InventorySlot> standardCraftingGrid = List.generate(10, (index) => InventorySlot(index: index,));

  static bool isInPlayerInventory() {
    if (GlobalGameReference.instance.gameReference.worldData.inventoryManager.inventoryIsOpen.value) {
      return true;
    }
    return false;
  } 
}