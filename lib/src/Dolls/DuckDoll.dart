import 'package:RenderingLib/RendereringLib.dart';
import 'package:CommonLib/Compression.dart';

import "../Dolls/Doll.dart";
import "package:DollLibCorrect/src/Dolls/KidBased/HomestuckDoll.dart";
import "package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../Rendering/ReferenceColors.dart";
import "Quirk.dart";


//saving and loading isn't working .why?


class DuckDoll extends Doll{

  @override
  String originalCreator = "insufferableOracle";

  @override
  int renderingType =39;

  @override
  int width = 600;
  @override
  int height = 600;

  @override
  String name = "Duck";

  @override
  String relativefolder = "images/Duck";
  final int maxBeaks = 1;
  final int maxBody = 13;
  final int maxEyes = 1;
  final int maxGlasses = 4;
  final int maxHair = 9;
  final int maxSymbols = 4;

  SpriteLayer beak;
  SpriteLayer body;
  SpriteLayer eyes;
  SpriteLayer glasses;
  SpriteLayer hairFront;
  SpriteLayer hairBack;
  SpriteLayer symbol;



  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack,body, symbol, eyes, beak, glasses, hairFront];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[hairBack,body, symbol, eyes, beak, glasses, hairFront];


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


  DuckDoll() {
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
  void initLayers() {

    {
      body = new SpriteLayer("Body","$folder/Body/", 1, maxBody);
      /*
        SpriteLayer beak;
  SpriteLayer body;
  SpriteLayer eyes;
  SpriteLayer glasses;
  SpriteLayer hairFront;
  SpriteLayer hairBack;
  SpriteLayer symbol;
       */
      beak = new SpriteLayer("Beak","$folder/Beak/", 1, maxBeaks);
      eyes = new SpriteLayer("Eyes","$folder/Eyes/", 0, maxEyes);
      glasses = new SpriteLayer("Glasses","$folder/Glasses/", 1, maxGlasses);
      hairFront = new SpriteLayer("HairFront","$folder/HairFront/", 1, maxHair);
      hairFront.slave = true;
      hairBack = new SpriteLayer("HairBack","$folder/HairBack/", 1, maxHair);
      hairFront.syncedWith.add(hairBack);
      hairBack.syncedWith.add(hairFront);
      symbol = new SpriteLayer("Symbol","$folder/Symbol/", 1, maxSymbols);
    }
  }

}

