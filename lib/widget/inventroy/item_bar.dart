import 'package:flutter/material.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';
import 'package:minecraft2d_game/widget/inventroy/inventory_slot.dart';

class ItemBarWidget extends StatelessWidget {
  const ItemBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: GameMethods.instance.slotSize / 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InventroySlotWidget(slotType: SlotType.itemBar),
            InventroySlotWidget(slotType: SlotType.itemBar),
            InventroySlotWidget(slotType: SlotType.itemBar),
            InventroySlotWidget(slotType: SlotType.itemBar),
            InventroySlotWidget(slotType: SlotType.itemBar),
            InventroySlotWidget(slotType: SlotType.itemBar),
            InventroySlotWidget(slotType: SlotType.itemBar),
            InventroySlotWidget(slotType: SlotType.itemBar),
          ],
        ),
      ),
    );
  }
}