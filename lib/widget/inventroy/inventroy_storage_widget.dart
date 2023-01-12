import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';
import 'package:minecraft2d_game/widget/inventroy/inventory_slot.dart';

class InventoryStorageWidget extends StatelessWidget {
  const InventoryStorageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double inventoryStorageSize = GameMethods.instance.slotSize * 9.5 ;
    return Padding(
      padding: EdgeInsets.only(bottom: GameMethods.instance.slotSize / 1.5),
      child: SizedBox(
        height: GameMethods.instance.getScreenSize().height * 0.8,
        width: GameMethods.instance.getScreenSize().height * 0.8,
        child: FittedBox(
          child: Stack(
            children: [
              //this is the background image
              SizedBox(
                width: inventoryStorageSize,
                height: inventoryStorageSize,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset('assets/images/inventory/inventory_background.png')
                )
              ),
            
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getRow(3),
                      getRow(2),
                      getRow(1),
                      Padding( //we add the padding because it is the last row which is our player active inventory bar
                        padding: EdgeInsets.symmetric(vertical: GameMethods.instance.slotSize / 3),
                        child: getRow(0),
                      ),
                    ],),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRow(int rowIndex){
    int newRowIndex = rowIndex * 9;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InventroySlotWidget(slotType: SlotType.inventory, inventorySlot: GlobalGameReference.instance.gameReference.worldData.inventoryManager.inventorySlots[newRowIndex + 0],),
        InventroySlotWidget(slotType: SlotType.inventory, inventorySlot: GlobalGameReference.instance.gameReference.worldData.inventoryManager.inventorySlots[newRowIndex + 1],),
        InventroySlotWidget(slotType: SlotType.inventory, inventorySlot: GlobalGameReference.instance.gameReference.worldData.inventoryManager.inventorySlots[newRowIndex + 2],),
        InventroySlotWidget(slotType: SlotType.inventory, inventorySlot: GlobalGameReference.instance.gameReference.worldData.inventoryManager.inventorySlots[newRowIndex + 3],),
        InventroySlotWidget(slotType: SlotType.inventory, inventorySlot: GlobalGameReference.instance.gameReference.worldData.inventoryManager.inventorySlots[newRowIndex + 4],),
        InventroySlotWidget(slotType: SlotType.inventory, inventorySlot: GlobalGameReference.instance.gameReference.worldData.inventoryManager.inventorySlots[newRowIndex + 5],),
        InventroySlotWidget(slotType: SlotType.inventory, inventorySlot: GlobalGameReference.instance.gameReference.worldData.inventoryManager.inventorySlots[newRowIndex + 6],),
        InventroySlotWidget(slotType: SlotType.inventory, inventorySlot: GlobalGameReference.instance.gameReference.worldData.inventoryManager.inventorySlots[newRowIndex + 7],),
        InventroySlotWidget(slotType: SlotType.inventory, inventorySlot: GlobalGameReference.instance.gameReference.worldData.inventoryManager.inventorySlots[newRowIndex + 8],),
      ],
    );
  }


}

