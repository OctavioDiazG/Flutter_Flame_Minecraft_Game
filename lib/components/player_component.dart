
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

class PlayerComponent extends SpriteAnimationComponent{

  @override
  Future<void> onLoad() async {
    super.onLoad();
    SpriteSheet playerSpriteSheet = SpriteSheet(
      image: await Flame.images.load('sprite_sheets/player/player_walking_sprite_sheet.png'), //tells flutter where to grab the spriteSheet
      srcSize: Vector2.all(60) //the number of pixels it will be cut the spriteSheet
    );

    animation = playerSpriteSheet.createAnimation(row: 0, stepTime: 0.15); //set the animation row->what row it will take from the spritesheet. stepTime->time between the sprites 
    size = Vector2(100,100);
  }

  @override
  void update(double dt)
  {
    super.update(dt);
    //position.x += 1; //for moving the player
    //position.y += 1;
  }
}