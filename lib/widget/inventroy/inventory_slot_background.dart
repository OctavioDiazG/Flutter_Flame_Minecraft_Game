import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class InventorySlotBackgroundWidget extends StatelessWidget {
  final SlotType slotType;
  final int index;
  const InventorySlotBackgroundWidget({super.key, required this.slotType, required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      width: GameMethods.instance.slotSize, 
      height: GameMethods.instance.slotSize, 
      child: Obx(() => FittedBox(
        child: index == GlobalGameReference.instance.gameReference.worldData.inventoryManager.currentSelectedInventorySlot.value 
        && slotType == SlotType.itemBar
        ? Image.asset('assets/images/inventory/inventory_active_slot.png')
        : Image.asset(getPath()),
      ))
    );
  }
  String getPath(){
    switch (slotType) {
      case SlotType.inventory:
        return "assets/images/inventory/inventory_item_storage_slot.png";
      case SlotType.itemBar:
        return "assets/images/inventory/inventory_item_bar_slot.png";
      case SlotType.crafting:
        return "assets/images/inventory/inventory_item_storage_slot.png";
      case SlotType.craftingOutput:
        return "assets/images/inventory/inventory_item_storage_slot.png";
    }
  }
}