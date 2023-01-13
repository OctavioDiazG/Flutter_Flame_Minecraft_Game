import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minecraft2d_game/global/inventory.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';


class InventoryItemAndNumberWidget extends StatelessWidget {
  final InventorySlot inventorySlot;
  const InventoryItemAndNumberWidget({super.key, required this.inventorySlot});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: GameMethods.instance.slotSize,
      height: GameMethods.instance.slotSize,
      child: Obx((() => inventorySlot.count.value > 0 
        ? Stack(
          children: [
            Positioned (
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.all(GameMethods.instance.slotSize/4),
                child: SpriteWidget(sprite: GameMethods.instance.getSpriteFromBlock(inventorySlot.block!)),
              )
            ), 
            Positioned( bottom: 0, right: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: GameMethods.instance.slotSize/7, 
                  right: GameMethods.instance.slotSize/7),
                child: Text(
                  inventorySlot.count.value.toString(), 
                  style: TextStyle( color: Colors.white, 
                  fontSize: GameMethods.instance.slotSize/4,
                  fontFamily: "MinecraftFont",
                  shadows: const [BoxShadow(color: Colors.black, offset: Offset(1,1) ,blurRadius: 2)]
                  ),
                ),
              )
            )
          ],
        ) : Container()
      ))
    );
  }
}