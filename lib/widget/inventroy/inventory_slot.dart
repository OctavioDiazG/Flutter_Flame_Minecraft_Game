import 'package:flame/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';
import 'package:minecraft2d_game/widget/inventroy/inventory_slot_background.dart';

class InventroySlotWidget extends StatelessWidget {
  final SlotType slotType;
  const InventroySlotWidget({super.key, required this.slotType});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InventorySlotBackgroundWidget(slotType: slotType),
        
      ]);
  }
}