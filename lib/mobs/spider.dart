import 'package:flame/components.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/player_data.dart';
import 'package:minecraft2d_game/resources/hostile_entity.dart';
import 'package:minecraft2d_game/utils/constant.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class Spider extends HostileEntity{
  Spider({required super.spawnIndexPosition}) 
    : super(
      path: "sprite_sheets/mobs/sprite_sheet_spider.png",
      srcSize: Vector2(131, 60),
    ){
      doFallDamage = false;
    }


  @override
  void update(double dt) {
    super.update(dt);
    fallingLogic(dt);
    killEntityLogic();
    jumpingLogic();
    checkForAggro();
    spiderLogic(dt);
    animationLogic();
    despawnLogic();
    
    setAllCollisionsToFalse();
  }

  void spiderLogic(double dt){
    if (isAggrevated) {
      double playerXPosition = GlobalGameReference.instance.gameReference.playerComponent.position.x;
      //if to the left
      if ((playerXPosition - position.x).abs() > 20) {
        if (position.x < playerXPosition){
          if (!move(ComponentMotionState.walkingRight, dt, ((playerSpeed * GameMethods.instance.blockSize.x) * dt) / 3)) {
            jumpForce += GameMethods.instance.blockSize.x * 0.2;
          }
          //move(ComponentMotionState.walkingRight, dt, ((playerSpeed * GameMethods.instance.blockSize.x) * dt) / 3);
        }else{
          if (!move(ComponentMotionState.walkingLeft, dt, ((playerSpeed * GameMethods.instance.blockSize.x) * dt) / 3)) {
            jumpForce += GameMethods.instance.blockSize.x * 0.2;
          }
        }
      }
    }
  }

  @override
  void onGameResize(Vector2 newScreenSize) {
    super.onGameResize(newScreenSize);

    size  = srcSize * ((GameMethods.instance.blockSize.y) / srcSize.y);
  }
}