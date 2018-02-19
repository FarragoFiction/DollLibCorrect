import 'package:RenderingLib/RendereringLib.dart';

import "../Dolls/Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';

import "../Rendering/ReferenceColors.dart";

class HomestuckDoll extends Doll {
    @override
    int renderingType =1;
    @override
    String folder = "images/Homestuck";
    //Don't go over 255 for any old layer unless you want to break shit. over 255 adds an exo.
    final int maxBody = 235;
    final int maxHair = 189;
    final int maxEye = 124;
    final int maxMouth = 121;
    final int maxSymbol = 250;
    final int maxGlass = 114;
    final int maxGlass2 = 128;
    final int maxFacePaint = 133;

    SpriteLayer body;
    SpriteLayer facePaint;
    SpriteLayer hairTop;
    SpriteLayer hairBack;
    SpriteLayer leftEye;
    SpriteLayer rightEye;
    SpriteLayer mouth;
    SpriteLayer symbol;
    SpriteLayer glasses;
    SpriteLayer glasses2;


    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack, body, facePaint,symbol, mouth, leftEye, rightEye, glasses, hairTop, glasses2];

    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[body, hairTop, hairBack, leftEye, rightEye, mouth, symbol, glasses, glasses2,facePaint];



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



    HomestuckDoll() {
        initLayers();
        randomize();
    }

    @override
    void load(String dataString) {
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be gone for reader
        initFromReader(reader, new HomestuckPalette(), false);
    }

    void initLayers()

    {
        hairTop = new SpriteLayer("Hair","$folder/HairTop/", 1, maxHair);
        hairBack = new SpriteLayer("Hair","$folder/HairBack/", 1, maxHair, syncedWith:<SpriteLayer>[hairTop]);
        hairTop.syncedWith.add(hairBack);
        hairBack.slave = true; //can't be selected on it's own

        body = new SpriteLayer("Body","$folder/Body/", 0, maxBody);
        facePaint = new SpriteLayer("FacePaint","$folder/FacePaint/", 0, maxFacePaint);

        symbol = new SpriteLayer("Symbol","$folder/Symbol/", 1, maxSymbol);
        mouth = new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth);
        leftEye = new SpriteLayer("LeftEye","$folder/LeftEye/", 1, maxEye);
        rightEye = new SpriteLayer("RightEye","$folder/RightEye/", 1, maxEye);
        glasses = new SpriteLayer("Glasses","$folder/Glasses/", 1, maxGlass);
        glasses2 = new SpriteLayer("Glasses2","$folder/Glasses2/", 0, maxGlass2);
    }

    HomestuckDoll.fromDataString(String dataString){
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be off before given to initFromReader
        initFromReader(reader, new HomestuckPalette());
    }

    //assumes type byte is already gone
     HomestuckDoll.fromReader(ByteReader reader){
         initFromReader(reader,new HomestuckPalette());
     }




    void randomize() {
         randomizeColors();
         randomizeNotColors();
    }

    void randomizeColors() {
        List<String> human_hair_colors = <String>["#68410a", "#fffffe", "#000000", "#000000", "#000000", "#f3f28d", "#cf6338", "#feffd7", "#fff3bd", "#724107", "#382207", "#ff5a00", "#3f1904", "#ffd46d", "#473200", "#91683c"];

        Random rand = new Random();
        HomestuckPalette h = palette as HomestuckPalette;
        List<HomestuckPalette> paletteOptions = new List<HomestuckPalette>.from(ReferenceColours.paletteList.values);
        HomestuckPalette newPallete = rand.pickFrom(paletteOptions);
        if(newPallete == ReferenceColours.INK) {
            tackyColors();
        }else {
            copyPalette(newPallete);
        }
        if(newPallete != ReferenceColours.SKETCH) h.add("hairMain",new Colour.fromStyleString(rand.pickFrom(human_hair_colors)),true);
    }

    void tackyColors() {
        Random rand = new Random();
        HomestuckPalette h = palette as HomestuckPalette;
        palette.add(HomestuckPalette.ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.ASPECT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);

        palette.add(HomestuckPalette.ASPECT_DARK, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value/2), true);
        palette.add(HomestuckPalette.SHOE_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.SHOE_DARK, new Colour(h.shoe_light.red, h.shoe_light.green, h.shoe_light.blue)..setHSV(h.shoe_light.hue, h.shoe_light.saturation, h.shoe_light.value/2), true);
        palette.add(HomestuckPalette.CLOAK_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.CLOAK_DARK, new Colour(h.cloak_light.red, h.cloak_light.green, h.cloak_light.blue)..setHSV(h.cloak_light.hue, h.cloak_light.saturation, h.cloak_light.value/2), true);
        palette.add(HomestuckPalette.CLOAK_MID, new Colour(h.cloak_dark.red, h.cloak_dark.green, h.cloak_dark.blue)..setHSV(h.cloak_dark.hue, h.cloak_dark.saturation, h.cloak_dark.value*3), true);
        palette.add(HomestuckPalette.SHIRT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.SHIRT_DARK, new Colour(h.shirt_light.red, h.shirt_light.green, h.shirt_light.blue)..setHSV(h.shirt_light.hue, h.shirt_light.saturation, h.shirt_light.value/2), true);
        palette.add(HomestuckPalette.PANTS_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.PANTS_DARK, new Colour(h.pants_light.red, h.pants_light.green, h.pants_light.blue)..setHSV(h.pants_light.hue, h.pants_light.saturation, h.pants_light.value/2), true);
        palette.add(HomestuckPalette.HAIR_ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.HAIR_MAIN, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);

    }
     void randomizeNotColors() {
         Random rand = new Random();
         int firstEye = -100;
         for(SpriteLayer l in renderingOrderLayers) {
             l.imgNumber = rand.nextInt(l.maxImageNumber+1);
             //keep eyes synced unless player decides otherwise
             if(firstEye > 0 && l.imgNameBase.contains("Eye")) l.imgNumber = firstEye;
             if(firstEye < 0 && l.imgNameBase.contains("Eye")) firstEye = l.imgNumber;
             if(l.imgNumber == 0 && l != body) l.imgNumber = 1;
             if(l.imgNameBase.contains("Glasses") && rand.nextDouble() > 0.35) l.imgNumber = 0;
         }
         if(rand.nextDouble() > .2) {
             facePaint.imgNumber = 0;
         }
     }



}

class CharSheetPalette extends Palette {
    static String _ASPECT_LIGHT = "aspect1";
    Colour get aspect_light => this[_ASPECT_LIGHT];

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

    void set aspect_light(dynamic c) => this.add(_ASPECT_LIGHT, _handleInput(c), true);
}

/// Convenience class for getting/setting aspect palettes
class HomestuckPalette extends Palette {
    static String ACCENT = "accent";
    static String ASPECT_LIGHT = "aspect1";
    static String ASPECT_DARK = "aspect2";
    static String SHOE_LIGHT = "shoe1";
    static String SHOE_DARK = "shoe2";
    static String CLOAK_LIGHT = "cloak1";
    static String CLOAK_MID = "cloak2";
    static String CLOAK_DARK = "cloak3";
    static String SHIRT_LIGHT = "shirt1";
    static String SHIRT_DARK = "shirt2";
    static String PANTS_LIGHT = "pants1";
    static String PANTS_DARK = "pants2";
    static String HAIR_MAIN = "hairMain";
    static String HAIR_ACCENT = "hairAccent";
    static String EYE_WHITE_LEFT = "eyeWhitesLeft";
    static String EYE_WHITE_RIGHT = "eyeWhitesRight";
    static String SKIN = "skin";

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

    Colour get text => this[ACCENT];

    Colour get accent => this[ACCENT];

    void set accent(dynamic c) => this.add(ACCENT, _handleInput(c), true);

    Colour get aspect_light => this[ASPECT_LIGHT];

    void set aspect_light(dynamic c) => this.add(ASPECT_LIGHT, _handleInput(c), true);

    Colour get aspect_dark => this[ASPECT_DARK];

    void set aspect_dark(dynamic c) => this.add(ASPECT_DARK, _handleInput(c), true);

    Colour get shoe_light => this[SHOE_LIGHT];

    void set shoe_light(dynamic c) => this.add(SHOE_LIGHT, _handleInput(c), true);

    Colour get shoe_dark => this[SHOE_DARK];

    void set shoe_dark(dynamic c) => this.add(SHOE_DARK, _handleInput(c), true);

    Colour get cloak_light => this[CLOAK_LIGHT];

    void set cloak_light(dynamic c) => this.add(CLOAK_LIGHT, _handleInput(c), true);

    Colour get cloak_mid => this[CLOAK_MID];

    void set cloak_mid(dynamic c) => this.add(CLOAK_MID, _handleInput(c), true);

    Colour get cloak_dark => this[CLOAK_DARK];

    void set cloak_dark(dynamic c) => this.add(CLOAK_DARK, _handleInput(c), true);

    Colour get shirt_light => this[SHIRT_LIGHT];

    void set shirt_light(dynamic c) => this.add(SHIRT_LIGHT, _handleInput(c), true);

    Colour get shirt_dark => this[SHIRT_DARK];

    void set shirt_dark(dynamic c) => this.add(SHIRT_DARK, _handleInput(c), true);

    Colour get pants_light => this[PANTS_LIGHT];

    void set pants_light(dynamic c) => this.add(PANTS_LIGHT, _handleInput(c), true);

    Colour get pants_dark => this[PANTS_DARK];

    void set pants_dark(dynamic c) => this.add(PANTS_DARK, _handleInput(c), true);

    Colour get hair_main => this[HAIR_MAIN];

    void set hair_main(dynamic c) => this.add(HAIR_MAIN, _handleInput(c), true);

    Colour get hair_accent => this[HAIR_ACCENT];

    void set hair_accent(dynamic c) => this.add(HAIR_ACCENT, _handleInput(c), true);

    Colour get eye_white_left => this[EYE_WHITE_LEFT];

    void set eye_white_left(dynamic c) => this.add(EYE_WHITE_LEFT, _handleInput(c), true);

    Colour get eye_white_right => this[EYE_WHITE_RIGHT];

    void set eye_white_right(dynamic c) => this.add(EYE_WHITE_RIGHT, _handleInput(c), true);

    Colour get skin => this[SKIN];

    void set skin(dynamic c) => this.add(SKIN, _handleInput(c), true);
}



