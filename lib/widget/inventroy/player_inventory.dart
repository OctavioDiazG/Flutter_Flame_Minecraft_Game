import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';
import 'package:minecraft2d_game/widget/crafting/player_inventory_crafting_grid.dart';
import 'package:minecraft2d_game/widget/crafting/standartd_crafting_grid.dart';
import 'package:minecraft2d_game/widget/inventroy/inventroy_storage_widget.dart';

class PlayerInventoryWidget extends StatelessWidget {
  const PlayerInventoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GlobalGameReference.instance.gameReference.worldData.inventoryManager.inventoryIsOpen.value 
      ? Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: Stack(
            children: const[
              InventoryStorageWidget(),
              PlayerInventoryCraftingGrid(),
            ],
          ),
        ),
      ) : Container()
    );
  }
}