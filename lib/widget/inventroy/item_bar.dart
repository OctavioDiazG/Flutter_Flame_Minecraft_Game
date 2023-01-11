import 'package:flutter/material.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';
import 'package:minecraft2d_game/widget/inventroy/inventory_slot.dart';

class ItemBarWidget extends StatelessWidget {
  const ItemBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}