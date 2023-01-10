import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/constant.dart';

class InventoryManager{
  List<InventorySlot> inventorySlots = List.generate(5, (index) => InventorySlot(index: index));

  bool addBlockToInventory(Blocks block){
    //loops through all the slots
    for(InventorySlot slot in inventorySlots){


      if (slot.block == block) {
        //if the slot.block is >= 64, then it will skip to the next slot
        if (slot.incrementCount()) {
          return true;
        }
      } 
      else if(slot.block == null){
        slot.block = block;
        slot.count++;
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
  int count = 0;
  final int index;

  InventorySlot({required this.index});

  bool incrementCount(){
    if(count < stack){
      count++;
      return true;
    }
    return false;
  }
}