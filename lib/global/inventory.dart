import 'package:minecraft2d_game/resources/blocks.dart';

class InventoryManager{
  List<InventorySlot> inventorySlots = List.generate(5, (index) => InventorySlot(index: index));
}

class InventorySlot{
  Blocks? block;
  int count = 0;
  final int index;

  InventorySlot({required this.index});
}