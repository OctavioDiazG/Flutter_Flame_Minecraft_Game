import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/resources/structures.dart';

Structure birchTree = Structure(
  structure: [
    [null, Blocks.birchLeaf, Blocks.birchLeaf, Blocks.birchLeaf, null],
    [Blocks.birchLeaf, Blocks.birchLeaf, Blocks.birchLeaf, Blocks.birchLeaf, Blocks.birchLeaf],
    [Blocks.birchLeaf, Blocks.birchLeaf, Blocks.birchLeaf, Blocks.birchLeaf, Blocks.birchLeaf],
    [null, null, Blocks.birchLog, null, null],
    [null, null, Blocks.birchLog, null, null],
  ], 
  maxOccurences: 1, //Generates a max of 3 occurences in the same chunk
  maxWidth: 5,
);