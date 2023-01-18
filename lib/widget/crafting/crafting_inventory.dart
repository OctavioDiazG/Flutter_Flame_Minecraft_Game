import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/widget/crafting/standartd_crafting_grid.dart';
import 'package:minecraft2d_game/widget/inventroy/inventroy_storage_widget.dart';

class CraftingInventory extends StatelessWidget {
  const CraftingInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GlobalGameReference.instance.gameReference.worldData.craftingManager.craftingInventoryIsOpen.value
      ? Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: Stack(
            children: const[
              InventoryStorageWidget(),

              StandardCraftingGrid(),
            ],
          ),
        ),
      ) : Container()
    );
  }
}