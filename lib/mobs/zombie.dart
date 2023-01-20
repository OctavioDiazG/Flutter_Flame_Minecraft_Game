import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:minecraft2d_game/components/block_component.dart';
import 'package:minecraft2d_game/components/player_component.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/player_data.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/resources/entity.dart';
import 'package:minecraft2d_game/utils/constant.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class Zombie extends Entity{
  Vector2 dimensions = Vector2(67,99);

  late SpriteSheet zombieSpriteSheet = SpriteSheet(
    image: Flame.images.fromCache('sprite_sheets/mobs/sprite_sheet_zombie.png'),
    srcSize: dimensions,
  );

  late SpriteAnimation walkingAnimation = zombieSpriteSheet.createAnimation(row: 2, stepTime: 0.2);
  //late SpriteAnimation idleAnimation = zombieSpriteSheet.createAnimation(row: 0, stepTime: 0.2, from: 0, to: 1);
  late SpriteAnimation idleAnimation = SpriteAnimation.spriteList([zombieSpriteSheet.getSprite(0, 0)], stepTime: 0.2);

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    //blocks collision
    if (other is BlockComponent && BlockData.getBlockDataFor(other.block).isCollidable) {
      super.onCollision(intersectionPoints, other);
    }

    //player collision
    if (other is PlayerComponent) {
      inflictDamageToPlayer(other);
    }
  }

  bool canJump = false;
  bool canDamage = false;
  bool isAggrevated = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(RectangleHitbox());

    add(TimerComponent(period: 1, repeat: true, onTick: (() => canJump = true)));
    add(TimerComponent(period: .70, repeat: true, onTick: (() => canDamage = true)));

    anchor = Anchor.bottomCenter;

    animation = idleAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);
    fallingLogic(dt);
    killEntityLogic();
    jumpingLogic();
    checkForAggro();
    zombieLogic(dt);

    setAllCollisionsToFalse();
  }

  void inflictDamageToPlayer(PlayerComponent other){
    if (canDamage == true) {
      other.changeHealthBy(-1);
      canDamage = false;
      double playerXPosition = GlobalGameReference.instance.gameReference.playerComponent.position.x;
      other.move(
        position.x > playerXPosition 
          ? ComponentMotionState.walkingLeft
          : ComponentMotionState.walkingRight, 
        1/45, 
        GameMethods.instance.blockSize.x * 0.6
      );
    }
  }

  void checkForAggro(){
    if (GameMethods.instance.playerIsWithinRange(GameMethods.instance.getIndexPositionFromPixels(position))){
      isAggrevated = true;
      animation = walkingAnimation;
    } else {
      isAggrevated = false;
      animation = idleAnimation;
    }
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

    size  = dimensions * ((GameMethods.instance.blockSize.x *2) / dimensions.y);
  }
}