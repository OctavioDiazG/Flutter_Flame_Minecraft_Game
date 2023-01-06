import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:minecraft2d_game/components/block_breaking_component.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';


class BlockComponent extends SpriteComponent with Tappable{

  final Blocks block;
  final Vector2 blockIndex;
  final int chunkIndex;

  BlockComponent(
    {required this.chunkIndex, 
    required this.blockIndex, 
    required this.block});

  late SpriteSheet animationBlockSpriteSheet;

  //the double dot is the cascate operator in dart, think about it as the word with
  late BlockBreakingComponent blockBreakingComponent = BlockBreakingComponent()
  ..animation = animationBlockSpriteSheet.createAnimation(row: 0, stepTime: 0.3, loop: false)
  ..animation!.onComplete = (){
    GameMethods.instance.repleceBlockAtWorldChunks(null, blockIndex);
    removeFromParent();
  };

  @override
  Future<void> onLoad() async{
    super.onLoad();

    add(RectangleHitbox());

    animationBlockSpriteSheet = SpriteSheet(image: await Flame.images.load('sprite_sheets/blocks/block_breaking_sprite_sheet.png'), srcSize: Vector2.all(60));

    sprite = await GameMethods.instance.getSpriteFromBlock(block);
  }

  @override
  void onGameResize(Vector2 newGameSize) {
    super.onGameResize(newGameSize);
    size = GameMethods.instance.blockSize;
    position = Vector2(
      GameMethods.instance.blockSize.x * blockIndex.x,
      GameMethods.instance.blockSize.y * blockIndex.y,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!GlobalGameReference.instance.gameReference.worldData.chunksThatShouldBeRendered.contains(chunkIndex)) {
        
      removeFromParent();

      GlobalGameReference.instance.gameReference.worldData.currentRenderedChunk.remove(chunkIndex);
    }
  }

  @override
  bool onTapDown(TapDownInfo info){ 
    super.onTapDown(info);
    
    //Add Block Breaking animation     
    if (!blockBreakingComponent.isMounted) {
      blockBreakingComponent.animation!.reset(); // every time the player taps on the block, the animation will reset
      add(blockBreakingComponent);
    }
    return true;
  }

  @override
  bool onTapUp(TapUpInfo info) { 
    super.onTapUp(info);

    //Stop Block Breaking animation 
    if (blockBreakingComponent.isMounted) {
      remove(blockBreakingComponent);
    }
    
    return true;
  }

  @override
  bool onTapCancel() {
    //Stop Block Breaking animation
    if (blockBreakingComponent.isMounted) {
      remove(blockBreakingComponent);
    } 
    
    return true;
  }


}