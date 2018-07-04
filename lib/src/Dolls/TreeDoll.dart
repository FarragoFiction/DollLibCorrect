import 'dart:async';
import 'dart:html';
import 'dart:math' as Math;
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

    List<TreeForm> forms = new List<TreeForm>();

    TreeForm get form {
        for(TreeForm form in forms) {
            if(form.hasForm(this)) return form;
        }
        //just assume it's a tree
        return forms.first;
    }

  int minFruit = 13;
  int maxFruit = 33;




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
  final int maxBranches = 19;
  final int maxLeaves = 8;
  //these are special and there are more than one of this layer
  final int maxFruits = 5;
  final int maxFlowers = 4;

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
      forms.addAll(<TreeForm>[new TreeForm(), new BushForm(), new LeftForm(), new RightFrom()]);
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
  }

  @override
  void setQuirk() {
    Random rand  = new Random(seed);
    quirkButDontUse = Quirk.randomHumanQuirk(rand);

  }

  /*
    pick a valid ish point at random
    draw this tree (no color replacement).
    check right and down from this point till you find a valid point. if you never do, give up.
    (never look left and up because whatever, this should be good enough for now)
   */
  //TODO when get hom find out why it almost always says 0,0 is valid and then doesn't actually.....render...
  //oh. it needs to start at 0 + imageWidth? maybe? TODO
  Future<Math.Point> randomValidPointOnTree() async {
      print("looking for a valid point on tree");
      int xGuess = randomValidHangableX();
      if(xGuess == form.leafWidth) xGuess = form.leafX;
      int yGuess = randomVAlidHangableY();
      if(yGuess == form.leafHeight) yGuess = form.leafY;
      CanvasElement pointFinderCanvas = new CanvasElement(width: width, height: height);
      //not a for loop because don't do fruit
      await leavesFront.drawSelf(pointFinderCanvas);
      await branches.drawSelf(pointFinderCanvas);
      await leavesBack.drawSelf(pointFinderCanvas);

      //only look at leaf locations
      ImageData img_data = pointFinderCanvas.context2D.getImageData(xGuess, yGuess, form.leafWidth-xGuess, form.leafHeight-yGuess);
      for(int x = 0; x<form.leafWidth-xGuess; x ++) {
          for(int y = 0; y<form.leafHeight-yGuess; y++) {
              int i = (y * (form.leafWidth-xGuess) + x) * 4;
              if(img_data.data[i+3] >100) {
                  //the '0' point for the data is xguess,yguess so take that into account.
                  print("found valid position at ${x+xGuess}, ${y+yGuess} because alpha is ${img_data.data[i+3]}");
                  return new Math.Point(x + xGuess, y + yGuess);
              }
          }

      }
      print("returning null");
      return null;
  }

  int randomValidHangableX() {
      return rand.nextIntRange(form.leafX, form.leafX + form.leafWidth);
  }

  int randomVAlidHangableY() {
      return rand.nextIntRange(form.leafY, form.leafY + form.leafHeight);
  }

  bool hasHangablesAlready() {
      for(SpriteLayer layer in renderingOrderLayers) {
            if(layer.name.contains("Hang")) return true;
      }
      return false;
  }

  Future<Null> createHangables() async {
      if(barren || hasHangablesAlready()) return;
        double chosenNum = rand.nextDouble();
        print("creating hangables and chosen num is $chosenNum is it less than 0.45? ${chosenNum < 0.45}");
        if(chosenNum < 0.45) {
            await createFruit();
        }else if (chosenNum < 0.9) {
            await createFlowers();
        }else {
            await createGloriousBullshit();
        }
  }

  Future<Null> createFlowers() async {
     print ('first creating flowers');
     int amount = rand.nextIntRange(minFruit,maxFruit);
     FlowerDoll doll = new FlowerDoll();
     doll.rand = rand.spawn();
     doll.randomizeNotColors(); //now it will fit my seed.
     doll.copyPalette(palette);
     for(int i = 0; i < amount; i++) {
         Math.Point point = await randomValidPointOnTree();
         print("second point is $point");
         if(point != null) {
             int xpos = point.x;
             int ypos = point.y;


             PositionedDollLayer newLayer = new PositionedDollLayer(
                 doll.clone(), fruitWidth, fruitHeight, xpos, ypos, "Hanging$i");
             renderingOrderLayers.add(newLayer);
             print("third added to rendering order layer $newLayer");
             dataOrderLayers.add(newLayer);
         }
     }
     print ("fourth is done");
  }

  Future<Null> createFruit() async{
      print ('first creating fruit');
      int amount = rand.nextIntRange(minFruit,maxFruit);
      FruitDoll doll = new FruitDoll();
      doll.rand = rand.spawn();
      doll.randomizeNotColors(); //now it will fit my seed.
      doll.copyPalette(palette);
      for(int i = 0; i < amount; i++) {
          FruitDoll clonedDoll = doll.clone();
          Math.Point point = await randomValidPointOnTree();
          print("second point is $point");

          if(point != null) {
              int xpos = point.x;
              int ypos = point.y;

              PositionedDollLayer newLayer = new PositionedDollLayer(clonedDoll, fruitWidth, fruitHeight, xpos, ypos, "Hanging$i");
              renderingOrderLayers.add(newLayer);
              print("third added to rendering order layer $newLayer");
              dataOrderLayers.add(newLayer);
          }
      }
      print ("fourth is done");
  }

  Future<Null> createGloriousBullshit() async {
      int type = rand.pickFrom(Doll.allDollTypes);
      print("creating glorious bullshit, type is $type");

      Doll doll = Doll.randomDollOfType(type);
      doll.rand = rand.spawn();
      doll.randomize(); //now it will fit my seed.
      doll.copyPalette(palette);

      int amount = rand.nextIntRange(minFruit,maxFruit);
      for(int i = 0; i < amount; i++) {
          Math.Point point = await randomValidPointOnTree();
          print("point is $point");

          if(point != null) {
              int xpos = point.x;
              int ypos = point.y;
              PositionedDollLayer newLayer = new PositionedDollLayer(
                  doll.clone(), fruitWidth, fruitHeight, xpos, ypos,
                  "Hanging$i");
              renderingOrderLayers.add(newLayer);
              print("added to rendering order layer $newLayer");
              dataOrderLayers.add(newLayer);
          }
      }
  }

  @override
  void beforeRender() {
      leavesBack.x = form.leafX;
      leavesBack.y = form.leafY;
      leavesFront.x = form.leafX;
      leavesFront.y = form.leafY;
  }

  @override
  void initLayers() {

      branches = new SpriteLayer("Branches","$folder/branches/", 1, maxBranches);
      leavesBack = new PositionedLayer(0,0,"BackLeaves","$folder/leavesBack/", 1, maxLeaves);
      leavesFront = new PositionedLayer(0,0,"FrontLeaves","$folder/leavesFront/", 1, maxLeaves);
      leavesBack.syncedWith.add(leavesFront);
      leavesFront.syncedWith.add(leavesBack);
      leavesBack.slave = true;
      //have to do it here because not a get, can be modified
      renderingOrderLayers = <SpriteLayer>[leavesBack,branches, leavesFront];
      dataOrderLayers = <SpriteLayer>[leavesBack,branches, leavesFront];
  }

}


//forms decide where valid leaf/flower/etc locations are

class TreeForm {
    List<int> branchesNumbers = <int>[5,6,7,8,9];
    int leafX = 75;
    int leafY = 50;
    int leafWidth = 368;
    int leafHeight = 328;

    bool hasForm(TreeDoll doll) {
        return branchesNumbers.contains(doll.branches.imgNumber);
    }
}


class BushForm extends TreeForm {
    @override
    List<int> branchesNumbers = <int>[0,1,2,3,4];
    @override
    int leafX = 75;
    @override
    int leafY = 150;
    @override
    int leafWidth = 368;
    @override
    int leafHeight = 328;
}

class LeftForm extends TreeForm {
    @override
    List<int> branchesNumbers = <int>[15,16,17,18,19];
    @override
    int leafX = 0;
    @override
    int leafY = 50;
    @override
    int leafWidth = 475;
    @override
    int leafHeight = 328;
}

class RightFrom extends TreeForm {
    @override
    List<int> branchesNumbers = <int>[10,11,12,13,14];
    @override
    int leafX = 150;
    @override
    int leafY = 50;
    @override
    int leafWidth = 475;
    @override
    int leafHeight = 328;
}