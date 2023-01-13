import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/inventory.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';
import 'package:minecraft2d_game/widget/inventroy/inventory_item_and_number.dart';
import 'package:minecraft2d_game/widget/inventroy/inventory_slot_background.dart';

class InventroySlotWidget extends StatelessWidget {
  final SlotType slotType;
  final InventorySlot inventorySlot;
  const InventroySlotWidget({super.key, required this.slotType, required this.inventorySlot});

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
        return Draggable(
          feedback: InventoryItemAndNumberWidget(inventorySlot: inventorySlot,),
          childWhenDragging: InventorySlotBackgroundWidget(slotType: slotType, index: inventorySlot.index,),
          data: inventorySlot,
          child: getChild(),
        );
     }
  }

  Widget getChild() {
    return Stack(
      children: [
        InventorySlotBackgroundWidget(slotType: slotType, index: inventorySlot.index,),
        InventoryItemAndNumberWidget(inventorySlot: inventorySlot,),
        getDragTarget(), //added the items in the items bar
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
          //InventorySlot inventorySlot = data as InventorySlot;
          if (inventorySlot.isEmpty) {
            inventorySlot.block = draggingInventorySlot.block;
            inventorySlot.count.value = draggingInventorySlot.count.value;
            draggingInventorySlot.emptySlot();
          } else {
            print('not empty');
          }
        },
      ),
    );
  }
}