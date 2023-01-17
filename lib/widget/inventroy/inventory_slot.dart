import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minecraft2d_game/global/crafting_manager.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/inventory.dart';
import 'package:minecraft2d_game/utils/constant.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';
import 'package:minecraft2d_game/widget/inventroy/inventory_item_and_number.dart';
import 'package:minecraft2d_game/widget/inventroy/inventory_slot_background.dart';

class InventorySlotWidget extends StatelessWidget {
  final SlotType slotType;
  final InventorySlot inventorySlot;
  const InventorySlotWidget({super.key, required this.slotType, required this.inventorySlot});

  @override
  Widget build(BuildContext context) {
    switch (slotType) {
      //item bar
      case SlotType.itemBar:
        return GestureDetector(
          onTap: () {
            GlobalGameReference.instance.gameReference.worldData.inventoryManager.currentSelectedInventorySlot.value = inventorySlot.index;
          },
          child: getChild(),
        );

      //inventory  
      case SlotType.inventory:
        return GestureDetector(
          
          onLongPress: () {
            for (int i = 0; i < inventorySlot.count.value/2; i++) {
              GlobalGameReference.instance.gameReference.worldData.inventoryManager.addBlockToInventory(inventorySlot.block!);
              inventorySlot.decrementCount();
            }
          },

          child: Draggable(
            feedback: InventoryItemAndNumberWidget(inventorySlot: inventorySlot,),
            childWhenDragging: InventorySlotBackgroundWidget(slotType: slotType, index: inventorySlot.index,),
            data: inventorySlot,
            child: getChild(),
          ),
        );

      case SlotType.crafting:
        return GestureDetector(
          
          onLongPress: () {
            for (int i = 0; i < inventorySlot.count.value/2; i++) {
              GlobalGameReference.instance.gameReference.worldData.inventoryManager.addBlockToInventory(inventorySlot.block!);
              inventorySlot.decrementCount();
            }
          },

          child: Draggable(
            feedback: InventoryItemAndNumberWidget(inventorySlot: inventorySlot,),
            childWhenDragging: InventorySlotBackgroundWidget(slotType: slotType, index: inventorySlot.index,),
            data: inventorySlot,
            child: getChild(),
          ),
        );
      case SlotType.craftingOutput:
        return GestureDetector(
          onTap: (){
            if(CraftingManager.isInPlayerInventory()){
              int interateTill = GlobalGameReference.instance.gameReference.worldData.craftingManager.playerInventoryCraftingGrid.last.count.value;
              for (int i = 0; i < interateTill; i++) {
                if (GlobalGameReference.instance.gameReference.worldData.inventoryManager.addBlockToInventory(GlobalGameReference.instance.gameReference.worldData.craftingManager.playerInventoryCraftingGrid.last.block!)) {
                  GlobalGameReference.instance.gameReference.worldData.craftingManager.playerInventoryCraftingGrid.last.decrementCount();
                }
              }
            } else {
              int interateTill = GlobalGameReference.instance.gameReference.worldData.craftingManager.standardCraftingGrid.last.count.value;
              for (int i = 0; i < interateTill; i++) {
                if (GlobalGameReference.instance.gameReference.worldData.inventoryManager.addBlockToInventory(GlobalGameReference.instance.gameReference.worldData.craftingManager.standardCraftingGrid.last.block!)) {
                  GlobalGameReference.instance.gameReference.worldData.craftingManager.standardCraftingGrid.last.decrementCount();
                }
              }
              /* GlobalGameReference
                  .instance.gameReference.worldData.craftingManager
                  .decrementOneFromEachSlot(GlobalGameReference
                      .instance
                      .gameReference
                      .worldData
                      .craftingManager
                      .standardCraftingGrid); */
            }
            //GlobalGameReference.instance.gameReference.worldData.craftingManager.checkForRecipe();
          },
          child: getChild(),
        );
     }
  }

  Widget getChild() {
    return Stack(
      children: [
        InventorySlotBackgroundWidget(slotType: slotType, index: inventorySlot.index,),
        InventoryItemAndNumberWidget(inventorySlot: inventorySlot,),
        getDragTarget() //added the items in the items bar
      ],
    );
  }


  Widget getDragTarget(){
    return SizedBox(
      width: GameMethods.instance.slotSize,
      height: GameMethods.instance.slotSize,
      child: DragTarget(
        builder: (context, /* List<InventorySlot> */ candidateData, rejectedData) => Container(),
        onWillAccept: (data) {
          return true;
        },
        onAccept: (InventorySlot draggingInventorySlot) {
          if ( slotType != SlotType.craftingOutput  /* true */) {
            if (inventorySlot.isEmpty) {
              inventorySlot.block = draggingInventorySlot.block;
              inventorySlot.count.value = draggingInventorySlot.count.value;
              draggingInventorySlot.emptySlot();
            } else if(draggingInventorySlot.block == inventorySlot.block && draggingInventorySlot.count.value + inventorySlot.count.value <= stack){
              inventorySlot.count.value += draggingInventorySlot.count.value;
              draggingInventorySlot.emptySlot();
            } 
          }
          if (slotType == SlotType.crafting) {
            //GlobalGameReference.instance.gameReference.worldData.craftingManager.checkForRecipe();
          }
        },
      ),
    );
  }
}