import 'package:RenderingLib/RendereringLib.dart';

import "../Dolls/Doll.dart";
import "../Dolls/HomestuckDoll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../Rendering/ReferenceColors.dart";
import "Quirk.dart";


//saving and loading isn't working .why?


class AncestorDoll extends Doll{

  @override
  String originalCreator = "Ner0";

  @override
  int renderingType =27;

  @override
  int width = 744;
  @override
  int height = 1101;

  @override
  String name = "Doc";

  @override
  String relativefolder = "images/Ancestors";
  final int maxAccessoryBehind = 2;
  final int maxAccessoryFront = 4;
  final int maxBody = 12;
  final int maxEye = 3;
  final int maxPaint = 2;
  final int maxHair = 12;
  final int maxHorn = 12;
  final int maxMouth = 9;

  SpriteLayer accessoryFront;
  SpriteLayer accessoryBack;
  SpriteLayer body;
  SpriteLayer eyeLeft;
  SpriteLayer eyeRight;
  SpriteLayer hornLeft;
  SpriteLayer hornRight;
  SpriteLayer mouth;
  SpriteLayer facepaint;
  SpriteLayer hairBack;
  SpriteLayer hairFront;

  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[accessoryBack, hairBack, body,facepaint, mouth, eyeLeft, eyeRight, accessoryFront, hairFront, hornLeft, hornRight ];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[accessoryBack, hairBack, body,facepaint, mouth, eyeLeft, eyeRight, accessoryFront, hairFront, hornLeft, hornRight];


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


  AncestorDoll() {
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
    hornLeft.imgNumber = hornRight.imgNumber;
    eyeLeft.imgNumber = eyeRight.imgNumber;
  }

  @override
  void load(String dataString) {
    Uint8List thingy = BASE64URL.decode(dataString);
    ByteReader reader = new ByteReader(thingy.buffer, 0);
    int type = reader.readByte(); //not gonna use, but needs to be gone for reader
    initFromReader(reader, new HomestuckPalette(), false);
  }

  AncestorDoll.fromDataString(String dataString){
    Uint8List thingy = BASE64URL.decode(dataString);
    ByteReader reader = new ByteReader(thingy.buffer, 0);
    int type = reader.readByte(); //not gonna use, but needs to be gone for reader
    print("Initing a Virus Doll From Reader $dataOrderLayers");
    initFromReader(reader, new HomestuckPalette());
  }

  //assumes type byte is already gone
  AncestorDoll.fromReader(ByteReader reader){
    initFromReader(reader,new HomestuckPalette());
  }

  @override
  void setQuirk() {
    Random rand  = new Random(seed);
    quirkButDontUse = Quirk.randomHumanQuirk(rand);

  }

  @override
  void initLayers() {

    {

     // hairFront, hornLeft, hornRight
      body = new SpriteLayer("Body","$folder/Body/", 1, maxBody);
      accessoryBack = new SpriteLayer("BehindAccessory","$folder/AccessoriesBehind/", 1, maxAccessoryBehind);
      hairBack = new SpriteLayer("HairBack","$folder/HairBack/", 1, maxHair);
      facepaint = new SpriteLayer("Facepaint","$folder/Facepaint/", 1, maxPaint);
      mouth = new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth);
      eyeLeft = new SpriteLayer("LeftEye","$folder/EyeLeft/", 1, maxEye)..primaryPartner = false;
      eyeRight = new SpriteLayer("RightEye","$folder/EyeRight/", 1, maxEye)..partners.add(eyeLeft);
      accessoryFront = new SpriteLayer("FrontAccessory","$folder/AccessoriesFront/", 1, maxAccessoryFront);
      hairFront = new SpriteLayer("HairFront","$folder/HairFront/", 1, maxHair, syncedWith: <SpriteLayer>[hairBack]);
      hairBack.syncedWith.add(hairFront);
      hairFront.slave = true; //can't be selected on it's own
      hornLeft = new SpriteLayer("LeftHorn","$folder/HornLeft/", 1, maxHorn)..primaryPartner = false;;
      hornRight = new SpriteLayer("RightHorn","$folder/HornRight/", 1, maxHorn)..partners.add(hornLeft);

      //slave hair, partner horns/eyes

    }
  }

}

