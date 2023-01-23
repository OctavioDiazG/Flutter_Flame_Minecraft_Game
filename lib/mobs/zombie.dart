import 'package:flame/components.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/player_data.dart';
import 'package:minecraft2d_game/resources/hostile_entity.dart';
import 'package:minecraft2d_game/utils/constant.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class Zombie extends HostileEntity{
  Zombie({required super.spawnIndexPosition}) 
    : super(
      path: "sprite_sheets/mobs/sprite_sheet_zombie.png",
      srcSize: Vector2(67, 99),
    );

  @override
  void update(double dt) {
    super.update(dt);
    fallingLogic(dt);
    killEntityLogic();
    jumpingLogic();
    checkForAggro();
    zombieLogic(dt);
    animationLogic();
    despawnLogic();

    setAllCollisionsToFalse();
  }

  void zombieLogic(double dt){
    if (isAggrevated) {
      double playerXPosition = GlobalGameReference.instance.gameReference.playerComponent.position.x;
      //if to the left
      if ((playerXPosition - position.x).abs() > 20) {
        if (position.x < playerXPosition){
          if (!move(ComponentMotionState.walkingRight, dt, ((playerSpeed * GameMethods.instance.blockSize.x) * dt) / 3)) {
            if (canJump = true) {
              jump(0.5);
              canJump = false;
            }
          }
          //move(ComponentMotionState.walkingRight, dt, ((playerSpeed * GameMethods.instance.blockSize.x) * dt) / 3);
        }else{
          if (!move(ComponentMotionState.walkingLeft, dt, ((playerSpeed * GameMethods.instance.blockSize.x) * dt) / 3)) {
            if (canJump = true) {
              jump(0.5);
              canJump = false;
            }
          }
        }
      }
    }
  }

  @override
  void onGameResize(Vector2 newScreenSize) {
    super.onGameResize(newScreenSize);

    size  = srcSize * ((GameMethods.instance.blockSize.x *2) / srcSize.y);
  }
}