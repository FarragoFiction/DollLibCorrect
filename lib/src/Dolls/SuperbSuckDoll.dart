import 'package:RenderingLib/RendereringLib.dart';

import "../Dolls/Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';

import "../Rendering/ReferenceColors.dart";
import "../Dolls/HomestuckDoll.dart";




class SuperbSuckDoll extends Doll{
  @override
  int renderingType =16;

  @override
  int width = 400;
  @override
  int height = 300;

  @override
  String folder = "images/Homestuck/superbsuck";
  final int maxFace = 1;
  final int maxBody = 1;
  final int maxSymbol =11;
  final int maxHair = 2;


  SpriteLayer face;
  SpriteLayer body;
  SpriteLayer symbol;
  SpriteLayer hair;

  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[body,symbol,face,hair];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[body,symbol,face,hair];

  @override
  Palette palette = new SuperbSuckPalette()
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


  SuperbSuckDoll() {
    initLayers();
    randomize();
  }

  @override
  void load(String dataString) {
    Uint8List thingy = BASE64URL.decode(dataString);
    ByteReader reader = new ByteReader(thingy.buffer, 0);
    int type = reader.readByte(); //not gonna use, but needs to be gone for reader
    initFromReader(reader, new SuperbSuckPalette(), false);
  }

  SuperbSuckDoll.fromDataString(String dataString){
    Uint8List thingy = BASE64URL.decode(dataString);
    ByteReader reader = new ByteReader(thingy.buffer, 0);
    int type = reader.readByte(); //not gonna use, but needs to be gone for reader
    initFromReader(reader, new SuperbSuckPalette());
  }

  //assumes type byte is already gone
  SuperbSuckDoll.fromReader(ByteReader reader){
    initFromReader(reader,new SuperbSuckPalette());
  }

  @override
  void initLayers() {

    {

      body = new SpriteLayer("Body","$folder/Body/", 1, maxBody);
      face = new SpriteLayer("Face","$folder/Face/", 1, maxFace);
      hair = new SpriteLayer("Hair","$folder/Hair/", 1, maxHair);
      symbol = new SpriteLayer("Symbol","$folder/Symbol/", 1, maxSymbol);

    }
  }

  void randomizeColors() {
    List<String> human_hair_colors = <String>["#68410a", "#fffffe", "#000000", "#000000", "#000000", "#f3f28d", "#cf6338", "#feffd7", "#fff3bd", "#724107", "#382207", "#ff5a00", "#3f1904", "#ffd46d", "#473200", "#91683c"];

    Random rand = new Random();
    SuperbSuckPalette h = palette as SuperbSuckPalette;
    tackyColors();
    h.add("hairMain",new Colour.fromStyleString(rand.pickFrom(human_hair_colors)),true);
  }

  void tackyColors() {
    Random rand = new Random();
    SuperbSuckPalette h = palette as SuperbSuckPalette;
    palette.add(SuperbSuckPalette._ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
    palette.add(SuperbSuckPalette._ASPECT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);

    palette.add(SuperbSuckPalette._ASPECT_DARK, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value/2), true);
    palette.add(SuperbSuckPalette._SHOE_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
    palette.add(SuperbSuckPalette._SHOE_DARK, new Colour(h.shoe_light.red, h.shoe_light.green, h.shoe_light.blue)..setHSV(h.shoe_light.hue, h.shoe_light.saturation, h.shoe_light.value/2), true);
    palette.add(SuperbSuckPalette._CLOAK_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
    palette.add(SuperbSuckPalette._CLOAK_DARK, new Colour(h.cloak_light.red, h.cloak_light.green, h.cloak_light.blue)..setHSV(h.cloak_light.hue, h.cloak_light.saturation, h.cloak_light.value/2), true);
    palette.add(SuperbSuckPalette._CLOAK_MID, new Colour(h.cloak_dark.red, h.cloak_dark.green, h.cloak_dark.blue)..setHSV(h.cloak_dark.hue, h.cloak_dark.saturation, h.cloak_dark.value*3), true);
    palette.add(SuperbSuckPalette._SHIRT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
    palette.add(SuperbSuckPalette._SHIRT_DARK, new Colour(h.shirt_light.red, h.shirt_light.green, h.shirt_light.blue)..setHSV(h.shirt_light.hue, h.shirt_light.saturation, h.shirt_light.value/2), true);
    palette.add(SuperbSuckPalette._PANTS_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
    palette.add(SuperbSuckPalette._PANTS_DARK, new Colour(h.pants_light.red, h.pants_light.green, h.pants_light.blue)..setHSV(h.pants_light.hue, h.pants_light.saturation, h.pants_light.value/2), true);
    palette.add(SuperbSuckPalette._HAIR_ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
    palette.add(SuperbSuckPalette._HAIR_MAIN, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
  }

}




/// Convenience class for getting/setting aspect palettes
class SuperbSuckPalette extends HomestuckPalette {
  static String _ACCENT = "accent";
  static String _ASPECT_LIGHT = "aspect1";
  static String _ASPECT_DARK = "aspect2";
  static String _SHOE_LIGHT = "shoe1";
  static String _SHOE_DARK = "shoe2";
  static String _CLOAK_LIGHT = "cloak1";
  static String _CLOAK_MID = "cloak2";
  static String _CLOAK_DARK = "cloak3";
  static String _SHIRT_LIGHT = "shirt1";
  static String _SHIRT_DARK = "shirt2";
  static String _PANTS_LIGHT = "pants1";
  static String _PANTS_DARK = "pants2";
  static String _HAIR_MAIN = "hairMain";
  static String _HAIR_ACCENT = "hairAccent";
  static String _EYE_WHITE_LEFT = "eyeWhitesLeft";
  static String _EYE_WHITE_RIGHT = "eyeWhitesRight";
  static String _SKIN = "skin";

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

  Colour get text => this[_ACCENT];

  Colour get accent => this[_ACCENT];

  void set accent(dynamic c) => this.add(_ACCENT, _handleInput(c), true);

  Colour get aspect_light => this[_ASPECT_LIGHT];

  void set aspect_light(dynamic c) => this.add(_ASPECT_LIGHT, _handleInput(c), true);

  Colour get aspect_dark => this[_ASPECT_DARK];

  void set aspect_dark(dynamic c) => this.add(_ASPECT_DARK, _handleInput(c), true);

  Colour get shoe_light => this[_SHOE_LIGHT];

  void set shoe_light(dynamic c) => this.add(_SHOE_LIGHT, _handleInput(c), true);

  Colour get shoe_dark => this[_SHOE_DARK];

  void set shoe_dark(dynamic c) => this.add(_SHOE_DARK, _handleInput(c), true);

  Colour get cloak_light => this[_CLOAK_LIGHT];

  void set cloak_light(dynamic c) => this.add(_CLOAK_LIGHT, _handleInput(c), true);

  Colour get cloak_mid => this[_CLOAK_MID];

  void set cloak_mid(dynamic c) => this.add(_CLOAK_MID, _handleInput(c), true);

  Colour get cloak_dark => this[_CLOAK_DARK];

  void set cloak_dark(dynamic c) => this.add(_CLOAK_DARK, _handleInput(c), true);

  Colour get shirt_light => this[_SHIRT_LIGHT];

  void set shirt_light(dynamic c) => this.add(_SHIRT_LIGHT, _handleInput(c), true);

  Colour get shirt_dark => this[_SHIRT_DARK];

  void set shirt_dark(dynamic c) => this.add(_SHIRT_DARK, _handleInput(c), true);

  Colour get pants_light => this[_PANTS_LIGHT];

  void set pants_light(dynamic c) => this.add(_PANTS_LIGHT, _handleInput(c), true);

  Colour get pants_dark => this[_PANTS_DARK];

  void set pants_dark(dynamic c) => this.add(_PANTS_DARK, _handleInput(c), true);

  Colour get hair_main => this[_HAIR_MAIN];

  void set hair_main(dynamic c) => this.add(_HAIR_MAIN, _handleInput(c), true);

  Colour get hair_accent => this[_HAIR_ACCENT];

  void set hair_accent(dynamic c) => this.add(_HAIR_ACCENT, _handleInput(c), true);

  Colour get eye_white_left => this[_EYE_WHITE_LEFT];

  void set eye_white_left(dynamic c) => this.add(_EYE_WHITE_LEFT, _handleInput(c), true);

  Colour get eye_white_right => this[_EYE_WHITE_RIGHT];

  void set eye_white_right(dynamic c) => this.add(_EYE_WHITE_RIGHT, _handleInput(c), true);

  Colour get skin => this[_SKIN];

  void set skin(dynamic c) => this.add(_SKIN, _handleInput(c), true);
}