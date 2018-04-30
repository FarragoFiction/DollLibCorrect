import 'package:RenderingLib/RendereringLib.dart';

import "../Dolls/Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../Rendering/ReferenceColors.dart";



//saving and loading isn't working .why?


class TalkSpriteDoll extends Doll{
  @override
  int renderingType =19;

  @override
  int width = 350;
  @override
  int height = 350;

  @override
  String name = "TalkSprite";

  @override
  String relativefolder = "images/TalkSprite";
  final int maxAccessory = 1;
  final int maxSymbol = 13;
  final int maxBrows = 2;
  final int maxEyes = 2;
  final int maxHair = 2;
  final int maxHood = 11;
  final int maxMouth = 2;
  final int maxNose = 2;
  final int maxShirt = 6;
  final int maxBody = 0;
  final int maxFacePaint = 2;


  SpriteLayer accessory;
  SpriteLayer symbol;
  SpriteLayer hood;
  SpriteLayer brows;
  SpriteLayer leftEye;
  SpriteLayer hairBack;
  SpriteLayer hairFront;
  SpriteLayer rightEye;
  SpriteLayer mouth;
  SpriteLayer nose;
  SpriteLayer shirt;
  SpriteLayer body;
  SpriteLayer facePaint;


  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack, body, facePaint, leftEye, rightEye, brows, mouth,nose, accessory,shirt, symbol, hood, hairFront];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[hairBack, body, facePaint,accessory, leftEye, rightEye, brows, mouth,nose, shirt, symbol, hood, hairFront];


  @override
  Palette palette = new TalkSpritePalette();


  DogDoll() {
    initLayers();
    randomize();
  }

  //HELL YES i found the source of the save bug.
  //i'm not supposed to use premade palettes like this, instead,
  //how does the drop downs work?
  @override
  void randomizeColors() {
    Random rand = new Random();
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
  void load(String dataString) {
    Uint8List thingy = BASE64URL.decode(dataString);
    ByteReader reader = new ByteReader(thingy.buffer, 0);
    int type = reader.readByte(); //not gonna use, but needs to be gone for reader
    initFromReader(reader, new TalkSpritePalette(), false);
  }

  TalkSpriteDoll.fromDataString(String dataString){
    Uint8List thingy = BASE64URL.decode(dataString);
    ByteReader reader = new ByteReader(thingy.buffer, 0);
    int type = reader.readByte(); //not gonna use, but needs to be gone for reader
    print("Initing a Virus Doll From Reader $dataOrderLayers");
    initFromReader(reader, new TalkSpritePalette());
  }

  //assumes type byte is already gone
  TalkSpriteDoll.fromReader(ByteReader reader){
    initFromReader(reader,new TalkSpritePalette());
  }

  @override
  void initLayers() {

    {
      hairFront = new SpriteLayer("Hair","$folder/hairFront/", 1, maxHair);
      hairBack = new SpriteLayer("Hair","$folder/hairBack/", 1, maxHair, syncedWith: <SpriteLayer>[hairFront]);
      hairFront.syncedWith.add(hairBack);
      hairBack.slave = true; //can't be selected on it's own

      body = new SpriteLayer("Body","$folder/Body/", 1, maxBody);

      facePaint = new SpriteLayer("FacePaint","$folder/FacePaint/", 1, maxFacePaint);
      brows = new SpriteLayer("Brows","$folder/Brows/", 1, maxBrows);
      mouth = new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth);
      leftEye = new SpriteLayer("LeftEye","$folder/leftEye/", 1, maxEyes);
      rightEye = new SpriteLayer("RightEye","$folder/rightEye/", 1, maxEyes);

      nose = new SpriteLayer("Nose","$folder/Nose/", 1, maxNose);
      accessory = new SpriteLayer("Accessory","$folder/accessory/", 1, maxAccessory);
      shirt = new SpriteLayer("Shirt","$folder/Shirt/", 1, maxShirt);
      symbol = new SpriteLayer("Symbol","$folder/Symbol/", 1, maxSymbol);
      hood = new SpriteLayer("Hood","$folder/Hood/", 1, maxHood);

    }
  }

}



class TalkSpritePalette extends Palette {
  static String _EYES = "eyes"; //yellow
  static String _SKIN = "skin"; //green
  static String _FEATHER1 = "feather1"; //red
  static String _FEATHER2 = "feather2"; //blue
  static String _ACCENT = "accent"; //purple

  static Colour _handleInput(Object input) {
    if (input is Colour) {
      return input;
    }
    if (input is int) {
      return new Colour.fromHex(input, input
          .toRadixString(16)
          .padLeft(6, "0")
          .length > 6);
    }
    if (input is String) {
      if (input.startsWith("#")) {
        return new Colour.fromStyleString(input);
      } else {
        return new Colour.fromHexString(input);
      }
    }
    throw "Invalid AspectPalette input: colour must be a Colour object, a valid colour int, or valid hex string (with or without leading #)";
  }

  Colour get text => this[_EYES];

  Colour get eyes => this[_EYES];

  void set eyes(dynamic c) => this.add(_EYES, _handleInput(c), true);

  Colour get skin => this[_SKIN];

  void set skin(dynamic c) => this.add(_SKIN, _handleInput(c), true);

  Colour get accent => this[_ACCENT];

  void set accent(dynamic c) => this.add(_ACCENT, _handleInput(c), true);

  Colour get feather1 => this[_FEATHER1];

  void set feather1(dynamic c) => this.add(_FEATHER1, _handleInput(c), true);

  Colour get feather2 => this[_FEATHER2];
  void set feather2(dynamic c) => this.add(_FEATHER2, _handleInput(c), true);


}