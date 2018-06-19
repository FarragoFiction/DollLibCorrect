import 'package:RenderingLib/RendereringLib.dart';
import 'package:CommonLib/Compression.dart';

import "../Dolls/Doll.dart";
import "../Dolls/HomestuckDoll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../Rendering/ReferenceColors.dart";
import "Quirk.dart";


//saving and loading isn't working .why?


class DogDoll extends Doll{

  @override
  String originalCreator = "spinningDisks";

  @override
  int renderingType =19;

  @override
  int width = 300;
  @override
  int height = 300;

  @override
  String name = "Dog";

  @override
  String relativefolder = "images/Dog";
  final int maxAccessory = 2;
  final int maxbackLegs = 1;
  final int maxBody = 2;
  final int maxChestFur = 1;
  final int maxFrontLegs = 1;
  final int maxHead = 1;
  final int maxEar = 1;
  final int maxEye = 3;
  final int maxHeadFur = 1;
  final int maxSnout = 3;
  final int maxTail = 3;




  SpriteLayer accessory;
  SpriteLayer backLegs;
  SpriteLayer body;
  SpriteLayer chestFur;
  SpriteLayer frontLegs;
  SpriteLayer head;
  SpriteLayer leftEar;
  SpriteLayer leftEye;
  SpriteLayer leftHeadFur;
  SpriteLayer rightEar;
  SpriteLayer rightEye;
  SpriteLayer rightHeadFur;
  SpriteLayer snout;
  SpriteLayer tail;





  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[tail, body,chestFur,  head,rightHeadFur, leftEye, rightEye, leftHeadFur, leftEar, rightEar, snout, accessory, backLegs, frontLegs];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[tail, body,chestFur, rightHeadFur, head, leftEye, rightEye, leftHeadFur, leftEar, rightEar, snout, accessory, backLegs, frontLegs];


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


  DogDoll() {
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
    leftEye.imgNumber = rightEye.imgNumber;
    leftEar.imgNumber = rightEar.imgNumber;
    if(tail.imgNumber == 0) tail.imgNumber = 1;
  }



  @override
  void setQuirk() {
    int seed = associatedColor.red + associatedColor.green + associatedColor.blue + renderingOrderLayers.first.imgNumber ;
    Random rand  = new Random(seed);
    quirkButDontUse = Quirk.randomHumanQuirk(rand);
    quirkButDontUse.lettersToReplaceIgnoreCase = [["^.*\$", "Woof"],["[.]\$", "Bark"],["[.]\$", "Yip"],];

  }

  @override
  void initLayers() {

    {
      //leftHeadFur, leftEar, rightEar, snout, accessory, backLegs, frontLegs];
      tail = new SpriteLayer("Tail","$folder/Tail/", 1, maxTail);
      body = new SpriteLayer("Body","$folder/Body/", 1, maxBody);
      chestFur = new SpriteLayer("ChestFur","$folder/chestFur/", 1, maxChestFur);
      rightHeadFur = new SpriteLayer("HairFur","$folder/rightHeadFur/", 1, maxHeadFur);
      head = new SpriteLayer("Head","$folder/head/", 1, maxHead);
      leftEye = new SpriteLayer("LeftEye","$folder/leftEye/", 1, maxEye);
      rightEye = new SpriteLayer("RightEye","$folder/rightEye/", 1, maxEye);
      leftHeadFur = new SpriteLayer("HairFur","$folder/leftHeadFur/", 1, maxHeadFur, syncedWith: <SpriteLayer>[rightHeadFur]);
      leftEar = new SpriteLayer("LeftEar","$folder/leftEar/", 1, maxEar);
      rightEar = new SpriteLayer("RightEar","$folder/rightEar/", 1, maxEar);
      snout = new SpriteLayer("Snout","$folder/snout/", 1, maxSnout);
      accessory = new SpriteLayer("Accessory","$folder/accessory/", 1, maxAccessory);
      backLegs = new SpriteLayer("BackLegs","$folder/backLegs/", 1, maxbackLegs);
      frontLegs = new SpriteLayer("FrontLegs","$folder/frontLeg/", 1, maxFrontLegs);


      rightHeadFur.syncedWith.add(leftHeadFur);
      leftHeadFur.slave = true; //can't be selected on it's own



    }
  }

}

