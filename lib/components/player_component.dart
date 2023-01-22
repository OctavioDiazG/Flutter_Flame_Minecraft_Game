import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:minecraft2d_game/components/block_component.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/player_data.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/resources/entity.dart';
import 'package:minecraft2d_game/utils/constant.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class PlayerComponent extends Entity {//CollisionCallbacks will give us access to a function

  final Vector2 playerDimensions = Vector2.all(60); //the number of pixels it will be cut the spriteSheet
  final double stepTime = 0.3; //maybe use it later

  // Movement Animation
  late SpriteSheet playerWalkingSpritesheet;
  late SpriteAnimation walkingAnimation = playerWalkingSpritesheet.createAnimation(row: 0, stepTime: 0.12);
  late SpriteAnimation walkingHurtAnimation = playerWalkingSpritesheet.createAnimation(row: 1, stepTime: 0.12);

  // Idle Animation
  late SpriteSheet playerIdleSpritesheet;
  late SpriteAnimation idleAnimation = playerIdleSpritesheet.createAnimation(row: 0, stepTime: 0.18);
  late SpriteAnimation idleHurtAnimation = playerIdleSpritesheet.createAnimation(row: 1, stepTime: 0.18);

  // Jump Animation
  //late SpriteSheet playerJumpSpritesheet;
  //late SpriteAnimation jumpAnimation = playerJumpSpritesheet.createAnimation(row: 0, stepTime: 0.12);


  double localPlayerSpeed = 0;

  bool refreshSpeed = false;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BlockComponent && BlockData.getBlockDataFor(other.block).isCollidable) {
      super.onCollision(intersectionPoints, other);
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await Future.delayed(const Duration(milliseconds: 500));

    add(RectangleHitbox());

    priority = 2;

    anchor = Anchor.bottomCenter;  

    // WalkingSprite
    playerWalkingSpritesheet = SpriteSheet(
      image: Flame.images.fromCache('sprite_sheets/own_imports/new_player_walk.png'), //tells flutter where to grab the spriteSheet
      srcSize: playerDimensions + Vector2(-1, 0), //the number of pixels it will be cut the spriteSheet
    );
    // IdleSprite 
    playerIdleSpritesheet = SpriteSheet(
      //image: Flame.images.fromCache('sprite_sheets/player/player_idle_sprite_sheet.png'), //tells flutter where to grab the spriteSheet
      image: Flame.images.fromCache('sprite_sheets/own_imports/new_player_idle.png'), //tells flutter where to grab the spriteSheet
      srcSize: playerDimensions, //the number of pixels it will be cut the spriteSheet
    );
    // JumpSprite
    /*playerJumpSpritesheet = SpriteSheet(
      image: await Flame.images.load('sprite_sheets/own_imports/RougeHeroJump.png'), 
      srcSize: Vector2(50,45), //check the pixel numer of the cut 
    );*/ //JUMP ANIM

    position = Vector2(100,400); //position in the world

    animation = idleAnimation;//set the animation row->what row it will take from the spritesheet. stepTime->time between the sprites 
    
    //refreshSpeed = true; every second
    add(TimerComponent(
      period: 1,
      repeat: true, 
      onTick:() {
        refreshSpeed = true;
      }
    ));

    add(TimerComponent(
      period: 25,
      repeat: true, 
      onTick:() {
        changeHungerBy(-0.5);
      }
    ));

    position = GameMethods.instance.getSpawnPositionForPlayer() * GameMethods.instance.blockSize.x;
  }

  @override
  void update(double dt) {
    super.update(dt);
    movementLogic(dt);
    fallingLogic(dt);
    jumpingLogic();
    killEntityLogic();
    healthAndhungerLogic();
    setAllCollisionsToFalse();

    print(isHurt);

    double hunger = GlobalGameReference.instance.gameReference.worldData.playerData.playerHunger.value;

    if (refreshSpeed) {
      if (hunger > 3) {  
        localPlayerSpeed = (playerSpeed * GameMethods.instance.blockSize.x) * dt;
      } else {
        localPlayerSpeed = (playerSpeed/2 * GameMethods.instance.blockSize.x) * dt;
        localPlayerSpeed /= 1.5;
      }
      refreshSpeed = false;

    }

    double playerHealth = GlobalGameReference.instance.gameReference.worldData.playerData.playerHealth.value;

    if (playerHealth != health) {
      GlobalGameReference.instance.gameReference.worldData.playerData.playerHealth.value = health;
      
    }
  } 

  void changeHungerBy(double value){
    //current hunger
    double hunger = GlobalGameReference.instance.gameReference.worldData.playerData.playerHunger.value;
    if (hunger + value <= 10) {
      if(hunger + value >= 0){
        GlobalGameReference.instance.gameReference.worldData.playerData.playerHunger.value += value;
      } else {
        GlobalGameReference.instance.gameReference.worldData.playerData.playerHunger.value = 0;
      }
    } else {
      GlobalGameReference.instance.gameReference.worldData.playerData.playerHunger.value = 10;
    }
  }


  void healthAndhungerLogic() {
    //regenerationLogic
    if(GlobalGameReference.instance.gameReference.worldData.playerData.playerHunger.value > 9){
      changeHealthBy(0.05);
    }

  }



  void movementLogic(double dt) {
    //Moving left
    if (GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState == ComponentMotionState.walkingLeft) {
      if (move(ComponentMotionState.walkingLeft, dt, localPlayerSpeed)) {
        GlobalGameReference.instance.gameReference.skyComponent.componentMotionState = ComponentMotionState.walkingRight;
      } else {
        GlobalGameReference.instance.gameReference.skyComponent.componentMotionState = ComponentMotionState.idle;
      }
      if (isHurt) {
        animation = walkingHurtAnimation;
      } else {
        animation = walkingAnimation;
      } 
        //animation = walkingAnimation;
    }

    //Moving right
    if (GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState == ComponentMotionState.walkingRight) {
      if (move(ComponentMotionState.walkingRight, dt, localPlayerSpeed)) {
        GlobalGameReference.instance.gameReference.skyComponent.componentMotionState = ComponentMotionState.walkingLeft;
      } else {
        GlobalGameReference.instance.gameReference.skyComponent.componentMotionState = ComponentMotionState.idle;
      }
      if (isHurt) {
        animation = walkingHurtAnimation;
      } else {
        animation = walkingAnimation;
      }
        //animation = walkingAnimation;
    }
    if (GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState == ComponentMotionState.idle) {
      if (isHurt) {
        animation = idleHurtAnimation;
      } else {
        animation = idleAnimation;
      }
      GlobalGameReference.instance.gameReference.skyComponent.componentMotionState = ComponentMotionState.idle;
    }
    if (GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState == ComponentMotionState.jumping && isCollidingBottom) {
      jump(0.6);
    }
  }

  @override
  void onGameResize(Vector2 newGameSize) {
    super.onGameResize(newGameSize);
    size = GameMethods.instance.blockSize * 1.5; 
  }
}
