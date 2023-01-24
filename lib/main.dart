//import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minecraft2d_game/global/inventory.dart';
import 'package:minecraft2d_game/global/player_data.dart';
import 'package:minecraft2d_game/global/world_data.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/resources/items.dart';
import 'package:minecraft2d_game/resources/sky_timer.dart';
import 'package:minecraft2d_game/screens/menu_screen.dart';
import 'package:minecraft2d_game/utils/constant.dart';
//import 'package:minecraft2d_game/main_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Flame.device.setLandscape();

  Hive.registerAdapter(WorldDataAdapter());
  Hive.registerAdapter(BlocksAdapter());
  Hive.registerAdapter(InventoryManagerAdapter());
  Hive.registerAdapter(InventorySlotSaveAdapter());
  Hive.registerAdapter(ItemsAdapter());
  Hive.registerAdapter(PlayerDataSaveAdapter());
  Hive.registerAdapter(SkyTimerAdapter());
  Hive.registerAdapter(SkyTimerEnumAdapter());

  //load
  await Flame.images.load("sprite_sheets/blocks/block_breaking_sprite_sheet.png");

  await Flame.images.load("sprite_sheets/player/player_walking_sprite_sheet.png");

  await Flame.images.load("sprite_sheets/player/player_idle_sprite_sheet.png");

  await Flame.images.load("sprite_sheets/blocks/block_sprite_sheet.png");

  await Flame.images.load("sprite_sheets/item/item_sprite_sheet.png");

  await Flame.images.load("sprite_sheets/mobs/sprite_sheet_zombie.png");

  await Flame.images.load("sprite_sheets/mobs/sprite_sheet_spider.png");

  await Hive.openBox(worldDataBox);

  //int seed = GameMethods.instance.getRandomSeed();

  /* Hive.box(worldDataBox)
      .put(seed, WorldData(seed: seed, worldName: "New World Test")); */

  print(Hive.box(worldDataBox).keys);

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MenuScreen(),
  ));
}