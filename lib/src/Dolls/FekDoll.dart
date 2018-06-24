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


class FekDoll extends Doll{

  @override
  String originalCreator = "nebulousHarmong and Firanka";

  @override
  int renderingType =28;

  @override
  int width = 214;
  @override
  int height = 214;

  @override
  String name = "Fek";

  @override
  String relativefolder = "images/Fek";
  final int maxCanonSymbol = 288;
  final int maxBody = 14;
  final int maxFace = 11;
  final int maxFacePaint = 4;
  final int maxGlasses = 9;
  final int maxHair = 33;
  final int maxHorns = 16;
  final int maxSymbol = 18;
  final int maxText = 8;




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
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[body, face,facePaint, hair, horns,symbol,canonSymbol, glasses, text];
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


  DocDoll() {
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
      body = new SpriteLayer("Body","$folder/body/", 1, maxBody);
      canonSymbol = new SpriteLayer("canonSymbol","$folder/Head/", 1, maxCanonSymbol);
      face = new SpriteLayer("Face","$folder/face/", 1, maxFace);
      text = new SpriteLayer("Text","$folder/text/", 1, maxText);
      glasses = new SpriteLayer("Glasses","$folder/glasses/", 1, maxGlasses);
      hair = new SpriteLayer("Hair","$folder/hair/", 1, maxHair);
      horns = new SpriteLayer("Horns","$folder/horns/", 1, maxHorns);
      symbol = new SpriteLayer("Symbol","$folder/symbol/", 1, maxSymbol);
      facePaint = new SpriteLayer("FacePaint","$folder/facepaint/", 1, maxFacePaint);

  }

}

