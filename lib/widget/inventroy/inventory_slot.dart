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
          child: getChild(),
        );
     }
  }

  Widget getChild() {
    return Stack(
      children: [
        InventorySlotBackgroundWidget(slotType: slotType, index: inventorySlot.index,),
        InventoryItemAndNumberWidget(inventorySlot: inventorySlot,), //added the items in the items bar
      ]
    );
  }
}