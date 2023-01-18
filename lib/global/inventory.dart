import 'package:get/get.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/resources/items.dart';
import 'package:minecraft2d_game/utils/constant.dart';

class InventoryManager {

  Rx<int> currentSelectedInventorySlot = 0.obs;
  Rx<bool> inventoryIsOpen = false.obs;

  List<InventorySlot> inventorySlots = List.generate(36, (index) => InventorySlot(index: index,));

  bool addBlockToInventory(dynamic block) {
    //loops through all the slots
    for (InventorySlot slot in inventorySlots) {
      //item
      if (slot.block == block) {
        //ITEM
        if (block is Items && ItemData.getItemDataForItem(block).toolType == Tools.none){
          if (slot.incrementCount()) {
            return true;
          }
          //block
        } else if (block is Blocks) {
          if (slot.incrementCount()) {
            return true;
          }
        }
        //Slot is empty
      } else if (slot.block == null) {
        slot.block = block;
        slot.count.value++;
        return true;
      }
    }
    return false;
  }
}

class InventorySlot{
  dynamic block;
  Rx<int> count = 0.obs;
  final int index;

  InventorySlot({required this.index});

  bool incrementCount(){
    if(count.value < stack){
      count.value++;
      return true;
    }
    return false;
  }

  void decrementCount(){
    count.value--;
    if(count.value == 0){
      block = null;
    }
  }


  bool get isEmpty {
    if (count.value == 0) {
      return true;  
    }
    return false;
  } 

  void emptySlot(){
    count.value = 0;
    block = null;
  }
}