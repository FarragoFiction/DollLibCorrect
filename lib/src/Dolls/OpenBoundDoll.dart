import 'package:RenderingLib/RendereringLib.dart';

import "../Dolls/Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../Rendering/ReferenceColors.dart";




class OpenBoundDoll extends Doll{

  @override
  String originalCreator = "NER0";


  @override
  int renderingType =21;

  @override
  int width = 160;
  @override
  int height = 137;

  @override
  String name = "OpenBound";

  @override
  String relativefolder = "images/Homestuck/OpenBound";
  final int maxAccessory = 2;
  final int maxBody = 1;
  final int maxCape = 1;
  final int maxEye = 1;
  final int maxFin = 1;
  final int maxHair = 1;
  final int maxHorn = 1;
  final int maxMouth = 1;
  final int maxSymbol = 1;



  SpriteLayer accessory;
  SpriteLayer glasses;
  SpriteLayer body;
  SpriteLayer cape;
  SpriteLayer leftEye;
  SpriteLayer rightEye;
  SpriteLayer leftFin;
  SpriteLayer rightFin;
  SpriteLayer hairFront;
  SpriteLayer hairBack;
  SpriteLayer leftHorn;
  SpriteLayer rightHorn;
  SpriteLayer mouth;
  SpriteLayer symbol;


  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack, cape, rightFin, body, mouth, rightEye, leftEye, glasses, hairFront, leftFin, accessory, rightHorn, leftHorn, symbol];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[hairBack, cape, rightFin, body, mouth, rightEye, leftEye, glasses, hairFront, leftFin, accessory, rightHorn, leftHorn, symbol];

  @override
  Palette paletteSource = new OpenBoundPalette()
    ..armor1 = '#00fffa'
    ..armor2 = '#00d6d2'
    ..armor3 = '#00a8a5'
    ..claw1 = '#76e0db'
    ..claw2 = '#9bc9c7'
    ..capsid1 = '#0000ff'
    ..capsid2 = '#0000c4'
    ..capsid3 = '#000096'
    ..capsid4 = '#5151ff'
    ..accent1 = '#8700ff'
    ..accent2 = '#a84cff';
  @override
  Palette palette = new OpenBoundPalette()
    ..armor1 = '#FF9B00'
    ..armor2 = '#FF9B00'
    ..armor3 = '#FF8700'
    ..claw1 = '#7F7F7F'
    ..claw2 = '#727272'
    ..capsid1 = '#A3A3A3'
    ..capsid2 = '#999999'
    ..capsid3 = '#898989'
    ..capsid4 = '#EFEFEF'
    ..accent1 = '#DBDBDB'
    ..accent2 = '#C6C6C6';


  OpenBoundDoll() {
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
  void load(String dataString) {
    Uint8List thingy = BASE64URL.decode(dataString);
    ByteReader reader = new ByteReader(thingy.buffer, 0);
    int type = reader.readByte(); //not gonna use, but needs to be gone for reader
    initFromReader(reader, new OpenBoundPalette(), false);
  }

  OpenBoundDoll.fromDataString(String dataString){
    Uint8List thingy = BASE64URL.decode(dataString);
    ByteReader reader = new ByteReader(thingy.buffer, 0);
    int type = reader.readByte(); //not gonna use, but needs to be gone for reader
    print("Initing a Virus Doll From Reader $dataOrderLayers");
    initFromReader(reader, new OpenBoundPalette());
  }

  //assumes type byte is already gone
  OpenBoundDoll.fromReader(ByteReader reader){
    initFromReader(reader,new OpenBoundPalette());
  }

  @override
  void initLayers() {

    {

      hairFront = new SpriteLayer("Hair","$folder/HairFront/", 1, maxHair, supportsMultiByte: true);
      hairBack = new SpriteLayer("Hair","$folder/HairBack/", 1, maxHair, syncedWith:<SpriteLayer>[hairFront], supportsMultiByte: true);
      hairFront.syncedWith.add(hairBack);
      hairBack.slave = true;

      leftFin = new SpriteLayer("Fin", "$folder/FinLeft/", 1, maxFin,supportsMultiByte: true);
      rightFin = new SpriteLayer("Fin", "$folder/FinRight/", 1, maxFin, syncedWith: <SpriteLayer>[leftFin],supportsMultiByte: true);
      leftFin.syncedWith.add(rightFin);
      rightFin.slave = true; //can't be selected on it's own

      body = new SpriteLayer("Body","$folder/Body/", 0, maxBody, supportsMultiByte: true);
      cape = new SpriteLayer("Body","$folder/Cape/", 1, maxCape, supportsMultiByte: true);
      mouth = new SpriteLayer("Body","$folder/Mouth/", 1, maxMouth, supportsMultiByte: true);
      leftEye = new SpriteLayer("Body","$folder/EyeLeft/", 1, maxEye, supportsMultiByte: true);
      rightEye = new SpriteLayer("Body","$folder/EyeRight/", 1, maxEye, supportsMultiByte: true);
      glasses = new SpriteLayer("Body","$folder/Accessory/", 1, maxAccessory, supportsMultiByte: true);
      accessory = new SpriteLayer("Body","$folder/Accessory/", 1, maxAccessory, supportsMultiByte: true);
      leftHorn = new SpriteLayer("Body","$folder/HornLeft/", 1, maxHorn, supportsMultiByte: true);
      rightHorn = new SpriteLayer("Body","$folder/HornRight/", 1, maxHorn, supportsMultiByte: true);
      symbol = new SpriteLayer("Body","$folder/Symbol/", 1, maxSymbol, supportsMultiByte: true);

    }
  }

}


/// Convenience class for getting/setting aspect palettes
class OpenBoundPalette extends Palette {

  static String ARMOR1 = "armor1";
  static String ARMOR2 = "armor2";
  static String ARMOR3 = "armor3";
  static String CLAW1 = "claw1";
  static String CLAW2 = "claw2";
  static String CAPSID1 = "capsid1";
  static String CAPSID2 = "capsid2";
  static String CAPSID3 = "capsid3";
  static String CAPSID4 = "capsid4";
  static String ACCENT1 = "accent1";
  static String ACCENT2 = "accent2";

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



  Colour get armor1 => this[ARMOR1];

  void set armor1(dynamic c) => this.add(ARMOR1, _handleInput(c), true);

  Colour get armor2 => this[ARMOR2];

  void set armor2(dynamic c) => this.add(ARMOR2, _handleInput(c), true);

  Colour get armor3 => this[ARMOR3];

  void set armor3(dynamic c) => this.add(ARMOR3, _handleInput(c), true);

  Colour get claw1 => this[CLAW1];

  void set claw1(dynamic c) => this.add(CLAW1, _handleInput(c), true);

  Colour get claw2 => this[CLAW2];

  void set claw2(dynamic c) => this.add(CLAW2, _handleInput(c), true);

  Colour get capsid1 => this[CAPSID1];

  void set capsid1(dynamic c) => this.add(CAPSID1, _handleInput(c), true);

  Colour get capsid2 => this[CAPSID2];

  void set capsid2(dynamic c) => this.add(CAPSID2, _handleInput(c), true);

  Colour get capsid3 => this[CAPSID3];

  void set capsid3(dynamic c) => this.add(CAPSID3, _handleInput(c), true);

  Colour get capsid4 => this[CAPSID4];

  void set capsid4(dynamic c) => this.add(CAPSID4, _handleInput(c), true);

  Colour get accent1 => this[ACCENT1];

  void set accent1(dynamic c) => this.add(ACCENT1, _handleInput(c), true);

  Colour get accent2 => this[ACCENT2];

  void set accent2(dynamic c) => this.add(ACCENT2, _handleInput(c), true);


}