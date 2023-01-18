import 'package:flutter/material.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';
import 'package:minecraft2d_game/widget/inventroy/inventory_slot.dart';

class PlayerInventoryCraftingGrid extends StatelessWidget {
  const PlayerInventoryCraftingGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: GameMethods.instance.slotSize/3),
          child: SizedBox(
            height: GameMethods.instance.slotSize * 4,
            width: GameMethods.instance.slotSize * 9.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InventorySlotWidget(slotType: SlotType.crafting, inventorySlot: GlobalGameReference.instance.gameReference.worldData.craftingManager.playerInventoryCraftingGrid[0],),
                        InventorySlotWidget(slotType: SlotType.crafting, inventorySlot: GlobalGameReference.instance.gameReference.worldData.craftingManager.playerInventoryCraftingGrid[1],),
                      ],
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InventorySlotWidget(slotType: SlotType.crafting, inventorySlot: GlobalGameReference.instance.gameReference.worldData.craftingManager.playerInventoryCraftingGrid[2],),
                        InventorySlotWidget(slotType: SlotType.crafting, inventorySlot: GlobalGameReference.instance.gameReference.worldData.craftingManager.playerInventoryCraftingGrid[3],),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: (GameMethods.instance.slotSize * 9.5)/8,
                  child: Image.asset('assets/images/inventory/inventory_arrow.png'),
                ),

                InventorySlotWidget(slotType: SlotType.craftingOutput, inventorySlot: GlobalGameReference.instance.gameReference.worldData.craftingManager.playerInventoryCraftingGrid[4]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}