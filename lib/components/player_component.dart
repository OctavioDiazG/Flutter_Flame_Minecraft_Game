import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/player_data.dart';

class PlayerComponent extends SpriteAnimationComponent{

  final Vector2 playerDimensions = Vector2(50, 40); //the number of pixels it will be cut the spriteSheet
  //final double stepTime = 0.15; maybe use it later
  final double speed = 5;
  bool isFacingRight = true;

  // Movement Animation
  late SpriteSheet playerWalkingSpritesheet;
  late SpriteAnimation walkingAnimation = playerWalkingSpritesheet.createAnimation(row: 0, stepTime: 0.12);

  // Idle Animation
  late SpriteSheet playerIdleSpritesheet;
  late SpriteAnimation idleAnimation = playerIdleSpritesheet.createAnimation(row: 0, stepTime: 0.18);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    //WalkingSprite
    playerWalkingSpritesheet = SpriteSheet(
      image: await Flame.images.load('sprite_sheets/own_imports/RougeHeroWalk.png'), //tells flutter where to grab the spriteSheet
      srcSize: Vector2(50,45), //the number of pixels it will be cut the spriteSheet
    );
    //IdleSprite 
    playerIdleSpritesheet = SpriteSheet(
      image: await Flame.images.load('sprite_sheets/own_imports/RougeHeroIdle.png'), //tells flutter where to grab the spriteSheet
      srcSize: Vector2(50,45), //the number of pixels it will be cut the spriteSheet
    );

    animation = idleAnimation; //set the animation row->what row it will take from the spritesheet. stepTime->time between the sprites 
    size = Vector2(100,100);
    position = Vector2(100,400); //position in the world
  }

  @override
  void update(double dt) {
    super.update(dt);
    movementLogic();

  }

  void movementLogic() {
    //Moving Left
    if(GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState == ComponentMotionState.walkingLeft){
      position.x -= speed; //moving the player to the Left * speed
      if (isFacingRight) {
        flipHorizontallyAroundCenter();
        isFacingRight = false;
      }
      animation = walkingAnimation;
    }
    //Moving Right
    if(GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState == ComponentMotionState.walkingRight){
      position.x += speed; //moving the player to the Right * speed
      if (!isFacingRight) {
        flipHorizontallyAroundCenter();
        isFacingRight = true;
      }
      animation = walkingAnimation;
    }
    //Idle 
    if (GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState == ComponentMotionState.idle) {
      animation = idleAnimation;
    }
  }
}