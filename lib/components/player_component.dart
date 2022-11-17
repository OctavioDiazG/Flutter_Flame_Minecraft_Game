import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/global/player_data.dart';

class PlayerComponent extends SpriteAnimationComponent{


  final double speed = 5;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    SpriteSheet playerSpriteSheet = SpriteSheet(
      image: await Flame.images.load('sprite_sheets/own_imports/RougeHero.png'), //tells flutter where to grab the spriteSheet
      srcSize: Vector2(50,45), //the number of pixels it will be cut the spriteSheet
    );

    animation = playerSpriteSheet.createAnimation(row: 0, stepTime: 0.12); //set the animation row->what row it will take from the spritesheet. stepTime->time between the sprites 
    size = Vector2(100,100);
    position = Vector2(100,400); //position in the world
  }

  @override
  void update(double dt)
  {
    super.update(dt);

    //Moving Left
    if(GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState == ComponentMotionState.walkingLeft){
      position.x -= speed; //moving the player to the Left * speed
    }
    //Moving Right
    if(GlobalGameReference.instance.gameReference.worldData.playerData.componentMotionState == ComponentMotionState.walkingRight){
      position.x += speed; //moving the player to the Right * speed
    }

  }
 
}