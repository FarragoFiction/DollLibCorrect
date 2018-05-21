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
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack, cape, body, mouth, rightEye, leftEye, glasses, hairFront,rightFin, leftFin, accessory, rightHorn, leftHorn, symbol];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[hairBack, cape, rightFin, body, mouth, rightEye, leftEye, glasses, hairFront, leftFin, accessory, rightHorn, leftHorn, symbol];

  @override
  Palette paletteSource = new OpenBoundPalette();

  @override
  Palette palette = new OpenBoundPalette();


  OpenBoundDoll() {
    initPalette();
    initLayers();
    randomize();
  }

  void initPalette() {
    for(NCP ncp in OpenBoundPalette.sourceColors) {
      ncp.addToPalette(paletteSource);
      ncp.addToPalette(palette);
    }
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

    rightHorn.imgNumber = leftHorn.imgNumber;
    rightEye.imgNumber = leftEye.imgNumber;
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

  static String COATLIGHT = "coat";
  static String COATLIGHT1 = "coat1";
  static String COATLIGHT2 = "coat2";
  static String COATLIGHTOUTLINE = "coatOutline";

  static String SHIRTLIGHT = "shirt";
  static String SHIRTLIGHT1 = "shirt1";
  static String SHIRTLIGHT2 = "shirt2";
  static String SHIRTLIGHTOUTLINE = "shirtOutline";

  static String PANTSLIGHT = "pants";
  static String PANTSLIGHT1 = "pants1";
  static String PANTSLIGHT2 = "pants2";
  static String PANTSLIGHTOUTLINE = "pantsOutline";

  static String SHOESLIGHT = "shoes";
  static String SHOESLIGHT1 = "shoes1";
  static String SHOESLIGHTOUTLINE = "shoesOutline";

  static String ACCENT = "accent";
  static String ACCENT1 = "accent1";
  static String ACCENT2 = "accent2";
  static String ACCENTOUTLINE = "accentOutline";

  static String HAIR = "hairLight";
  static String HAIR1 = "hairDark1";
  static String HAIR2 = "hairDark2";

  static String SKIN = "skinLight";
  static String SKIN1 = "skinDark1";
  static String SKIN2 = "skinDark2";
  static String SKINOUTLINE = "skinOutline";

  static String ASPECT1 = "aspectLight";
  static String ASPECT2 = "aspectDark";

  static String EYELEFT = "eyeLeft";
  static String EYELEFTGLOW1 = "eyeLeftGlow1";
  static String EYELEFTGLOW2 = "eyeLeftGlow2";
  static String EYELEFTGLOW3 = "eyeLeftGlow3";
  static String EYELEFTGLOW4 = "eyeLeftGlow4";

  static String EYERIGHT = "eyeRight";
  static String EYERIGHTGLOW1 = "eyeRightGlow1";
  static String EYERIGHTGLOW2 = "eyeRightGlow2";
  static String EYERIGHTGLOW3 = "eyeRightGlow3";
  static String EYERIGHTGLOW4 = "eyeRightGlow4";


  //default colors are
  static List<NCP> sourceColors = <NCP>[new NCP(COATLIGHT,"#ff4e1b"),new NCP(COATLIGHT1,"#da4115"),new NCP(COATLIGHT2,"#ca3c13"),new NCP(COATLIGHTOUTLINE,"#bc3008")]
    ..addAll(<NCP>[new NCP(SHIRTLIGHT,"#ff892e"),new NCP(SHIRTLIGHT1,"#fa802a"),new NCP(SHIRTLIGHT2,"#f16f23"),new NCP(SHIRTLIGHTOUTLINE,"#cc5016")])
    ..addAll(<NCP>[new NCP(PANTSLIGHT,"#e76700"),new NCP(PANTSLIGHT1,"#cc5c00"),new NCP(PANTSLIGHT2,"#c05600"),new NCP(PANTSLIGHTOUTLINE,"#984400")])
    ..addAll(<NCP>[new NCP(SHOESLIGHT,"#12e5fb"),new NCP(SHOESLIGHT1,"#00abf8"),new NCP(SHOESLIGHTOUTLINE,"#0061c7")])
    ..addAll(<NCP>[new NCP(PANTSLIGHT,"#ed1c24"),new NCP(PANTSLIGHT1,"#cc5c00"),new NCP(PANTSLIGHT2,"#c05600"),new NCP(PANTSLIGHTOUTLINE,"#984400")]);



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

}

//name color pair but short
class NCP
{
  String name;
  String styleString;

  NCP(String this.name, String this.styleString);

  void addToPalette(Palette p) {
    p.add(name, new Colour.fromStyleString(styleString), true);
  }

}