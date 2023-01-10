import 'package:flutter/cupertino.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class InventorySlotBackgroundWidget extends StatelessWidget {
  final SlotType slotType;
  const InventorySlotBackgroundWidget({super.key, required this.slotType});

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      width: GameMethods.instance.slotSize, 
      height: GameMethods.instance.slotSize, 
      child: Image.asset(getPath())
    );
  }
  String getPath(){
    switch (slotType) {
      case SlotType.inventory:
        return 'assets/images/inventory/inventory_item_storage_slot.png';
      case SlotType.itemBar:
        return 'assets/images/inventory/inventory_item_bar_slot.png';
    }
  }

}