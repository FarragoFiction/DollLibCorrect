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
  final int maxAspects = 1;
  final int maxBrows = 0;
  final int maxEyes = 1;
  final int maxHai = 1;
  final int maxHead = 1;
  final int maxLeftEar = 1;
  final int maxLeftEye = 2;
  final int maxLeftHeadFur = 1;
  final int maxRightEar = 1;
  final int maxRightEye = 2;
  final int maxRightHeadFur = 1;
  final int maxSnout = 3;
  final int maxTail = 1;




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
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[tail, body,chestFur, rightHeadFur, head, leftEye, rightEye, leftHeadFur, leftEar, rightEar, snout, accessory, backLegs, frontLegs];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[tail, body,chestFur, rightHeadFur, head, leftEye, rightEye, leftHeadFur, leftEar, rightEar, snout, accessory, backLegs, frontLegs];


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
    leftEye.imgNumber = rightEye.imgNumber;
    leftEar.imgNumber = rightEar.imgNumber;
    if(tail.imgNumber == 0) tail.imgNumber = 1;
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
      //leftHeadFur, leftEar, rightEar, snout, accessory, backLegs, frontLegs];
      tail = new SpriteLayer("Tail","$folder/Tail/", 1, maxTail);
      body = new SpriteLayer("Body","$folder/Body/", 1, maxBody);
      chestFur = new SpriteLayer("ChestFur","$folder/chestFur/", 1, maxChestFur);
      rightHeadFur = new SpriteLayer("RightHeadFur","$folder/rightHeadFur/", 1, maxRightHeadFur);
      head = new SpriteLayer("Head","$folder/head/", 1, maxHead);
      leftEye = new SpriteLayer("LeftEye","$folder/leftEye/", 1, maxLeftEye);
      rightEye = new SpriteLayer("RightEye","$folder/rightEye/", 1, maxRightEye);
      leftHeadFur = new SpriteLayer("LeftHeadFur","$folder/leftHeadFur/", 1, maxLeftHeadFur, syncedWith: <SpriteLayer>[rightHeadFur]);
      leftEar = new SpriteLayer("LeftEar","$folder/leftEar/", 1, maxLeftEar);
      rightEar = new SpriteLayer("RightEar","$folder/rightEar/", 1, maxRightEar);
      snout = new SpriteLayer("Snout","$folder/snout/", 1, maxSnout);
      accessory = new SpriteLayer("Accessory","$folder/accessory/", 1, maxAccessory);
      backLegs = new SpriteLayer("BackLegs","$folder/backLegs/", 1, maxbackLegs);
      frontLegs = new SpriteLayer("FrontLegs","$folder/frontLeg/", 1, maxFrontLegs);


      rightHeadFur.syncedWith.add(leftHeadFur);
      leftHeadFur.slave = true; //can't be selected on it's own



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