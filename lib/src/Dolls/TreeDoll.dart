import 'package:DollLibCorrect/src/Dolls/FlowerDoll.dart';
import 'package:DollLibCorrect/src/Dolls/FruitDoll.dart';
import 'package:DollLibCorrect/src/Dolls/Layers/PositionedDollLayer.dart';
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

  //hangables should confine themselves to that space
  int leafWidth = 368;
  int leafHeight = 328;
  int fruitWidth = 50;
  int fruitHeight = 50;



  SpriteLayer branches;
  PositionedLayer leavesFront;
  PositionedLayer leavesBack;




    //TODO think about how i wanna do flowers/fruit, wont know how many to have will I?

  //not a get, so i can add flowers/fruit to it over time.
  @override
  List<SpriteLayer>   renderingOrderLayers = new List <SpriteLayer>();
  @override
  List<SpriteLayer>   dataOrderLayers =new List <SpriteLayer>();


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

  //for making random trees in the randomdolloftype method, don't let it recurse and need ever more fruit.
  //(to make one tree with random doll fruit, i would need to make another tree to genererate a random doll)
  bool barren = false;

  TreeDoll([bool this.barren = false]) {
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
      //print("randomizing not colors, rendering order layers is $renderingOrderLayers");
    for(SpriteLayer l in renderingOrderLayers) {
      l.imgNumber = rand.nextInt(l.maxImageNumber+1);
    }
    createHangables();
  }

  @override
  void setQuirk() {
    Random rand  = new Random(seed);
    quirkButDontUse = Quirk.randomHumanQuirk(rand);

  }

  int randomValidHangableX() {
      return rand.nextIntRange(leafX, leafX + leafWidth);
  }

  int randomVAlidHangableY() {
      return rand.nextIntRange(leafY, leafY + leafHeight);
  }

  void createHangables() {
      if(barren) return;
        double chosenNum = rand.nextDouble();
        if(chosenNum < 0.45) {
            createFruit();
        }else if (chosenNum < 0.9) {
            createFlowers();
        }else {
            createGloriousBullshit();
        }
  }

  void createFlowers() {
    // print ('creating flowers');
     int amount = rand.nextIntRange(3,13);
     for(int i = 0; i < amount; i++) {
         int xpos = randomValidHangableX();
         int ypos = randomVAlidHangableY();
         FlowerDoll doll = new FlowerDoll();
         doll.rand = rand.spawn();
         doll.randomizeNotColors(); //now it will fit my seed.
         doll.copyPalette(palette);
         PositionedDollLayer newLayer = new PositionedDollLayer(
             doll, fruitWidth, fruitHeight, xpos, ypos, "Hanging1");
         renderingOrderLayers.add(newLayer);
         dataOrderLayers.add(newLayer);
     }
  }

  void createFruit() {
      //print ('creating fruit');
      int amount = rand.nextIntRange(3,13);
      for(int i = 0; i < amount; i++) {
          int xpos = randomValidHangableX();
          int ypos = randomVAlidHangableY();
          FruitDoll doll = new FruitDoll();
          doll.rand = rand.spawn();
          doll.randomizeNotColors(); //now it will fit my seed.
          doll.copyPalette(palette);
          PositionedDollLayer newLayer = new PositionedDollLayer(
              doll, fruitWidth, fruitHeight, xpos, ypos, "Hanging1");
          renderingOrderLayers.add(newLayer);
          dataOrderLayers.add(newLayer);
      }
  }

  void createGloriousBullshit() {
      int type = rand.pickFrom(Doll.allDollTypes);
      print("creating glorious bullshit, type is $type");


      int amount = rand.nextIntRange(3,13);
      for(int i = 0; i < amount; i++) {
          int xpos = randomValidHangableX();
          int ypos = randomVAlidHangableY();
          Doll doll = Doll.randomDollOfType(type);
          doll.rand = rand.spawn();
          doll.randomize(); //now it will fit my seed.
          doll.copyPalette(palette);
          PositionedDollLayer newLayer = new PositionedDollLayer(
              doll, fruitWidth, fruitHeight, xpos, ypos, "Hanging1");
          renderingOrderLayers.add(newLayer);
          dataOrderLayers.add(newLayer);
      }
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

      branches = new SpriteLayer("Branches","$folder/branches/", 1, maxBranches);
      leavesBack = new PositionedLayer(treeX,treeY,"BackLeaves","$folder/leavesBack/", 1, maxLeaves);
      leavesFront = new PositionedLayer(treeX,treeY,"FrontLeaves","$folder/leavesFront/", 1, maxLeaves);
      leavesBack.syncedWith.add(leavesFront);
      leavesFront.syncedWith.add(leavesBack);
      leavesBack.slave = true;
      //have to do it here because not a get, can be modified
      renderingOrderLayers = <SpriteLayer>[leavesBack,branches, leavesFront];
      dataOrderLayers = <SpriteLayer>[leavesBack,branches, leavesFront];
  }

}

