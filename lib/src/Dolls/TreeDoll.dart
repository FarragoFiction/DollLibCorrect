import 'package:DollLibCorrect/src/Dolls/Layers/PositionedLayer.dart';
import 'package:RenderingLib/RendereringLib.dart';
import 'package:CommonLib/Compression.dart';

import "../Dolls/Doll.dart";
import "package:DollLibCorrect/src/Dolls/KidBased/HomestuckDoll.dart";
import "package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../Rendering/ReferenceColors.dart";
import "Quirk.dart";


/*

prototype for a doll that has positioned layers
 */


class TreeDoll extends Doll{

  List<int> bushes = <int>[0,1,2,3,4];

  bool get isBush => bushes.contains(branches.imgNumber);
  int get leafX {
    if(isBush) return bushX;
    return treeX;
  }

  int get leafY {
    if(isBush) return bushY;
    return treeY;
  }
  int treeX = 50;
  int treeY = 50;
  int bushX = 50;
  int bushY = 150;

  @override
  String originalCreator = "jadedResearcher and dystopicFuturism";

  @override
  int renderingType =33;

  @override
  int width = 500;
  @override
  int height = 500;

  @override
  String name = "Tree";

  @override
  String relativefolder = "images/Tree";
  final int maxBranches = 9;
  final int maxLeaves = 7;
  //these are special and there are more than one of this layer
  final int maxFruits = 5;
  final int maxFlowers = 4;




  SpriteLayer branches;
  PositionedLayer leavesFront;
  PositionedLayer leavesBack;




    //TODO think about how i wanna do flowers/fruit, wont know how many to have will I?

  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[leavesBack,branches, leavesFront];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[leavesBack,branches, leavesFront];


  @override
  Palette palette = new HomestuckPalette()
    ..accent = '#FF9B00'
    ..aspect_light = '#FF9B00'
    ..aspect_dark = '#FF8700'
    ..shoe_light = '#7F7F7F'
    ..shoe_dark = '#727272'
    ..cloak_light = '#A3A3A3'
    ..cloak_mid = '#999999'
    ..cloak_dark = '#898989'
    ..shirt_light = '#EFEFEF'
    ..shirt_dark = '#DBDBDB'
    ..pants_light = '#C6C6C6'
    ..eye_white_left = '#ffffff'
    ..eye_white_right = '#ffffff'
    ..pants_dark = '#ADADAD'
    ..hair_main = '#ffffff'
    ..hair_accent = '#ADADAD'
    ..skin = '#ffffff';


  TreeDoll() {
    initLayers();
    randomize();
  }

  //HELL YES i found the source of the save bug.
  //i'm not supposed to use premade palettes like this, instead,
  //how does the drop downs work?
  @override
  void randomizeColors() {
            if(rand == null) rand = new Random();;
    List<Palette> paletteOptions = new List<Palette>.from(ReferenceColours.paletteList.values);
    Palette newPallete = rand.pickFrom(paletteOptions);
    if(newPallete == ReferenceColours.INK) {
      super.randomizeColors();
    }else {
      copyPalette(newPallete);
    }
  }

  @override
  void randomizeNotColors() {
    for(SpriteLayer l in renderingOrderLayers) {
      l.imgNumber = rand.nextInt(l.maxImageNumber+1);
    }
  }

  @override
  void setQuirk() {
    Random rand  = new Random(seed);
    quirkButDontUse = Quirk.randomHumanQuirk(rand);

  }

  @override
  void beforeRender() {
      leavesBack.x = leafX;
      leavesBack.y = leafY;
      leavesFront.x = leafX;
      leavesFront.y = leafY;
  }

  @override
  void initLayers() {

    {
      branches = new SpriteLayer("Branches","$folder/branches/", 1, maxBranches);
      leavesBack = new PositionedLayer(treeX,treeY,"BackLeaves","$folder/leavesBack/", 1, maxLeaves);
      leavesFront = new PositionedLayer(treeX,treeY,"FrontLeaves","$folder/leavesFront/", 1, maxLeaves);
      leavesBack.syncedWith.add(leavesFront);
      leavesFront.syncedWith.add(leavesBack);
      leavesBack.slave = true;
    }
  }

}

