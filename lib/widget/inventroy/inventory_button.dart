import 'package:flutter/material.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class InventoryButtonWidget extends StatelessWidget {
  const InventoryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GlobalGameReference.instance.gameReference.worldData.inventoryManager.inventoryIsOpen.value = !GlobalGameReference.instance.gameReference.worldData.inventoryManager.inventoryIsOpen.value;
      },
      child: SizedBox(
        height: GameMethods.instance.slotSize,
        width: GameMethods.instance.slotSize,    
        child: FittedBox(
          child: Image.asset("assets/images/inventory/inventory_button.png"),
        ),
      ),
    );
  }
}