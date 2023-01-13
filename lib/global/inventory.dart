import 'package:get/get.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/constant.dart';

class InventoryManager {

  Rx<int> currentSelectedInventorySlot = 0.obs;
  Rx<bool> inventoryIsOpen = false.obs;

  List<InventorySlot> inventorySlots = List.generate(36, (index) => InventorySlot(index: index,));

  bool addBlockToInventory(Blocks block) {
    //loops through all the slots
    for (InventorySlot slot in inventorySlots) {
      if (slot.block == block) {
        //if the slot.block is >= 64, then it will skip to the next slot
        if (slot.incrementCount()) {
          return true;
        }
      } else if (slot.block == null) {
        slot.block = block;
        slot.count.value++;
        return true;
      }
      /* else if(slot.block != block){

      } */
    }
    return false;
  }
}

class InventorySlot{
  Blocks? block;
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