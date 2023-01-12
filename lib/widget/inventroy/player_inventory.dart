import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';
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
            children: [
              const InventoryStorageWidget(),
              Positioned(
                left: 0, right: 0, top: 20,
                child: Container(
                  height: GameMethods.instance.slotSize * 4,
                  width: GameMethods.instance.slotSize * 9,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ) : Container()
    );
  }
}