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


class FekDoll extends Doll{

  @override
  String originalCreator = "nebulousHarmony and Firanka";

  @override
  int renderingType =28;

  @override
  int width = 214;
  @override
  int height = 214;

  @override
  String name = "Fek";

  @override
  String relativefolder = "images/fek";
  final int maxCanonSymbol = 288;
  final int maxBody = 20;
  final int maxFace = 14;
  final int maxFacePaint = 5;
  final int maxGlasses = 10;
  final int maxHair = 34;
  final int maxHorns = 17;
  final int maxSymbol = 19;
  final int maxText = 11;




  SpriteLayer canonSymbol;
  SpriteLayer body;
  SpriteLayer face;
  SpriteLayer text;
  SpriteLayer glasses;
  SpriteLayer hair;
  SpriteLayer horns;
  SpriteLayer symbol;
  SpriteLayer facePaint;

  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[body, facePaint,face, hair, horns,symbol,canonSymbol, glasses, text];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[body, face,facePaint, hair, horns,symbol,canonSymbol, glasses, text];


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


  FekDoll() {
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
    canonSymbol.imgNumber = 0;
    //roughly 50/50 shot of being human
    if(rand.nextBool()) {
        horns.imgNumber = 0;
    }
    if(horns.imgNumber == 0) {
        palette.add(HomestuckPalette.SKIN, new Colour.fromStyleString("#ffffff"), true);
        List<String> human_hair_colors = <String>["#68410a", "#fffffe", "#000000", "#000000", "#000000", "#f3f28d", "#cf6338", "#feffd7", "#fff3bd", "#724107", "#382207", "#ff5a00", "#3f1904", "#ffd46d", "#473200", "#91683c"];
        palette.add(HomestuckPalette.HAIR_MAIN, new Colour.fromStyleString(rand.pickFrom(human_hair_colors)), true);
        palette.add(HomestuckPalette.EYE_WHITE_LEFT, new Colour.fromStyleString("#c4c4c4"), true);
        palette.add(HomestuckPalette.EYE_WHITE_RIGHT, new Colour.fromStyleString("#c4c4c4"), true);



    }else {
        palette.add(HomestuckPalette.SKIN, new Colour.fromStyleString("#c4c4c4"), true);
        palette.add(HomestuckPalette.HAIR_MAIN, new Colour.fromStyleString("#000000"), true);
        palette.add(HomestuckPalette.EYE_WHITE_LEFT, new Colour.fromStyleString("#000000"), true);
        palette.add(HomestuckPalette.EYE_WHITE_RIGHT, new Colour.fromStyleString("#000000"), true);


    }
  }

  @override
  void setQuirk() {
    Random rand  = new Random(seed);
    quirkButDontUse = Quirk.randomHumanQuirk(rand);

  }

  @override
  void initLayers() {
      body = new SpriteLayer("Body","$folder/body/", 1, maxBody);
      canonSymbol = new SpriteLayer("canonSymbol","$folder/canonSymbol/", 1, maxCanonSymbol);
      face = new SpriteLayer("Face","$folder/face/", 1, maxFace);
      text = new SpriteLayer("Text","$folder/text/", 1, maxText);
      glasses = new SpriteLayer("Glasses","$folder/glasses/", 1, maxGlasses);
      hair = new SpriteLayer("Hair","$folder/hair/", 1, maxHair);
      horns = new SpriteLayer("Horns","$folder/horns/", 1, maxHorns);
      symbol = new SpriteLayer("Symbol","$folder/symbol/", 1, maxSymbol);
      facePaint = new SpriteLayer("FacePaint","$folder/facepaint/", 1, maxFacePaint);
  }

}

