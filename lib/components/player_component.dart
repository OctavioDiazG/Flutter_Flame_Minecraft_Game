import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/player_data.dart';
import 'package:minecraft2d_game/utils/constant.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class PlayerComponent extends SpriteAnimationComponent with CollisionCallbacks {//CollisionCallbacks will give us access to a function

  final Vector2 playerDimensions = Vector2.all(60); //the number of pixels it will be cut the spriteSheet
  final double stepTime = 0.3; //maybe use it later
  bool isFacingRight = true;
  double yVelocity = 0;
  double jumpForce = 0;

  // Movement Animation
  late SpriteSheet playerWalkingSpritesheet;
  late SpriteAnimation walkingAnimation = playerWalkingSpritesheet.createAnimation(row: 0, stepTime: 0.12);

  // Idle Animation
  late SpriteSheet playerIdleSpritesheet;
  late SpriteAnimation idleAnimation = playerIdleSpritesheet.createAnimation(row: 0, stepTime: 0.18);

  // Jump Animation
  //late SpriteSheet playerJumpSpritesheet;
  //late SpriteAnimation jumpAnimation = playerJumpSpritesheet.createAnimation(row: 0, stepTime: 0.12);

  bool isCollidingBottom = false;
  bool isCollidingRight = false;
  bool isCollidingLeft = false;


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    //print("Other is $other ");
    //print("IntersectionPoints are $intersectionPoints ");

    intersectionPoints.forEach((Vector2 individualIntersectionPoint) { 

      if (individualIntersectionPoint.y > (position.y - (size.y * 0.3)) && (intersectionPoints.first.x - intersectionPoints.last.x).abs() > size.x * 0.4) { 
        print("bottom Collision");
        isCollidingBottom = true;
        yVelocity = 0;
      }

      if (individualIntersectionPoint.y < (position.y - (size.y * 0.3))) {
        //print("isCollidingHotizontally");
        //create right collision
        if (individualIntersectionPoint.x > position.x) {
          isCollidingRight = true;
        } else {
          isCollidingLeft = true;
        }
      }

    });
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(RectangleHitbox());

    priority = 2;

    anchor = Anchor.bottomCenter;  

    // WalkingSprite
    playerWalkingSpritesheet = SpriteSheet(
      image: await Flame.images.load('sprite_sheets/player/player_walking_sprite_sheet.png'), //tells flutter where to grab the spriteSheet
      srcSize: playerDimensions, //the number of pixels it will be cut the spriteSheet
    );
    // IdleSprite 
    playerIdleSpritesheet = SpriteSheet(
      image: await Flame.images.load('sprite_sheets/player/player_idle_sprite_sheet.png'), //tells flutter where to grab the spriteSheet
      srcSize: playerDimensions, //the number of pixels it will be cut the spriteSheet
    );
    // JumpSprite
    /*playerJumpSpritesheet = SpriteSheet(
      image: await Flame.images.load('sprite_sheets/own_imports/RougeHeroJump.png'), 
      srcSize: Vector2(50,45), //check the pixel numer of the cut 
    );*/ //JUMP ANIM

    animation = idleAnimation;//set the animation row->what row it will take from the spritesheet. stepTime->time between the sprites 
    
    position = Vector2(100,400); //position in the world
    
  }

  @override
  void update(double dt) {
    super.update(dt);
    movementLogic(dt);

    fallingLogic(dt);

    setAllCollisionsToFalse();

    if (jumpForce > 0) {
      position.y -= jumpForce;
      jumpForce -= GameMethods.instance.blockSize.x * 0.15;
    }
  }

  void fallingLogic(double dt){

    if (!isCollidingBottom) {
      if (yVelocity < (GameMethods.instance.gravity * dt) * 5) { //place a limit to the yVelocity //5
        position.y += yVelocity;
        yVelocity += GameMethods.instance.gravity * dt;
      } else {
        position.y += yVelocity;
      }
    }
  }

  void setAllCollisionsToFalse(){
    isCollidingBottom = false;
    isCollidingRight = false;
    isCollidingLeft = false;
  }

  void move(ComponentMotionState componentMotionState, double dt) {
    switch (componentMotionState) {
      case ComponentMotionState.walkingLeft:
        if(!isCollidingLeft){
          position.x -= (playerSpeed * GameMethods.instance.blockSize.x) * dt; //moving the player to the Left * speed
        }
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        animation = walkingAnimation;
      break;
      case ComponentMotionState.walkingRight:
        if(!isCollidingRight) {
          position.x += (playerSpeed * GameMethods.instance.blockSize.x) * dt; //moving the player to the Left * speed
        }
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        animation = walkingAnimation;
      break;
      default: 
      break;  //if its defoult it will do nothing
    }
  }

  void movementLogic(double dt) {
    //Moving Left
    if(GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState == ComponentMotionState.walkingLeft){
      move(ComponentMotionState.walkingLeft, dt);
    }
    //Moving Right
    if(GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState == ComponentMotionState.walkingRight){
      move(ComponentMotionState.walkingRight, dt);
    }
    //Idle 
    if (GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState == ComponentMotionState.idle) {
      animation = idleAnimation;
    }
    //Jump
    if (GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState == ComponentMotionState.jumping) {
      jumpForce = GameMethods.instance.blockSize.x * 0.6; 
      /*if (isCollidingBottom) {
        yVelocity = -jumpForce;
      }*/
      //animation = jumpAnimation;
    }
  }

  @override
  void onGameResize(Vector2 newGameSize) {
    super.onGameResize(newGameSize);
    size = GameMethods.instance.blockSize * 1.5; 
  }
}