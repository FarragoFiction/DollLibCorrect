import 'package:RenderingLib/RendereringLib.dart';

import "../Dolls/Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';

import "../Dolls/HomestuckDoll.dart";
import "../Rendering/ReferenceColors.dart";


class HomestuckCherubDoll extends HomestuckDoll {

    @override
    int renderingType = 16;
    //Don't go over 255 for any old layer unless you want to break shit. over 255 adds an exo.

    //these bodies look terrible with troll signs. if any of these use 47,48, or 49
    int maxCheeks = 4;
    int maxWings = 2;
    @override
    int maxEyes = 6;

    @override
    int maxBody = 239;

    @override
    int maxMouth = 10;

    @override
    int maxGlass = 113;

    @override
    int maxGlass2 = 113;

    SpriteLayer cheeks;
    SpriteLayer wings;




    @override
    String relativefolder = "images/Homestuck";

    @override
    List<SpriteLayer> get renderingOrderLayers => <SpriteLayer>[wings, hairBack, body,  facePaint, cheeks,symbol, mouth, leftEye, rightEye, glasses, hairTop, glasses2];


    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[body, hairTop, hairBack, leftEye, rightEye, mouth, symbol, glasses, glasses2,facePaint];


    @override
    void load(String dataString) {
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be gone for reader
        initFromReader(reader, new HomestuckCherubPalette(), false);
    }

    HomestuckCherubDoll([int sign]) :super() {
        if(sign != null) {
            //makes sure palette is sign appropriate
            randomize();
        }
    }







    @override
     Palette source_palette = new HomestuckCherubPalette()
        ..accent = '#FF9B00'
        ..aspect_light = '#FEFD49'
        ..aspect_dark = '#FEC910'
        ..wing1 = '#00FF2A'
        ..wing2 = '#FF0000'
        ..aspect_dark = '#FEC910'
        ..shoe_light = '#10E0FF'
        ..shoe_dark = '#00A4BB'
        ..cloak_light = '#FA4900'
        ..cloak_mid = '#E94200'
        ..cloak_dark = '#C33700'
        ..shirt_light = '#FF8800'
        ..shirt_dark = '#D66E04'
        ..pants_light = '#E76700'
        ..pants_dark = '#CA5B00'
        ..hair_main = '#313131'
        ..hair_accent = '#202020'
        ..eye_white_left = '#ffba35'
        ..eye_white_right = '#ffba15'
        ..eyeBags = "#9d9d9d"
        ..skin = '#ffffff';

    @override
    Palette palette = new HomestuckCherubPalette()
        ..accent = '#FF9B00'
        ..aspect_light = '#FF9B00'
        ..aspect_dark = '#FF8700'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#A3A3A3'
        ..cloak_mid = '#999999'
        ..cloak_dark = '#898989'
        ..shirt_light = '#ffffff'
        ..shirt_dark = '#000000'
        ..pants_light = '#ffffff'
        ..eye_white_left = '#ffffff'
        ..eye_white_right = '#ffffff'
        ..pants_dark = '#000000'
        ..hair_accent = '#aa0000'
        ..hair_main = '#000000'
        ..skin = '#ffffff';




    @override
    void initLayers() {
        super.initLayers();
        //only do what is special to me here.
        //print("initializing layers, folder is: $folder and use absolute path is $useAbsolutePath");
        mouth = new SpriteLayer("Mouth","$folder/CherubMouth/", 1, maxMouth);
        wings = new SpriteLayer("Wings","$folder/CherubWings/", 1, maxWings);
        leftEye = new SpriteLayer("Eyes","$folder/CherubLeftEyes/", 1, maxEyes);
        rightEye = new SpriteLayer("Eyes","$folder/CherubRightEyes/", 1, maxEyes);
        cheeks = new SpriteLayer("Cheeks","$folder/CherubCheeks/", 1, maxCheeks);
        body = new SpriteLayer("Body","$folder/CherubBody/", 1, maxBody);
        glasses = new SpriteLayer("Glasses","$folder/CherubGlasses/", 0, maxGlass);
        glasses2 = new SpriteLayer("Glasses2","$folder/CherubGlasses/", 0, maxGlass2);
    }

    @override
    void randomizeColors() {
        List<String> human_hair_colors = <String>["#fffffe", "#000000"];

        Random rand = new Random();
        HomestuckPalette h = palette as HomestuckPalette;
        List<HomestuckPalette> paletteOptions = new List<HomestuckPalette>.from(ReferenceColours.paletteList.values);
        HomestuckPalette newPallete = rand.pickFrom(paletteOptions);
        if(newPallete == ReferenceColours.INK) {
            tackyColors();
        }else {
            copyPalette(newPallete);
        }
        h.add("skin",new Colour.fromStyleString(rand.pickFrom(human_hair_colors)),true);

        if(newPallete != ReferenceColours.SKETCH) h.add("hairMain",new Colour.fromStyleString(rand.pickFrom(human_hair_colors)),true);

        if(rand.nextBool()) {
            palette.add(HomestuckPalette.ASPECT_LIGHT, new Colour(0, 255, 0), true);
        }else {
            palette.add(HomestuckPalette.ASPECT_LIGHT, new Colour(255, 0, 0), true);
        }

        palette.add(HomestuckPalette.ASPECT_DARK, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value/2), true);

    }


    @override
    void randomizeNotColors() {
        Random rand = new Random();
        int firstEye = -100;
        for(SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber+1);
            //keep eyes synced unless player decides otherwise
            if(firstEye > 0 && l.imgNameBase.contains("Eye")) l.imgNumber = firstEye;
            if(firstEye < 0 && l.imgNameBase.contains("Eye")) firstEye = l.imgNumber;
            if(l.imgNumber == 0 && l != body) l.imgNumber = 1;
            if(l == glasses || l == glasses2 && rand.nextDouble() > 0.35) l.imgNumber = 0;
            if(l == wings && rand.nextDouble() > 0.35) l.imgNumber = 0;
            if(l == hairBack || l == hairTop && rand.nextDouble() > 0.1) l.imgNumber = 61;
        }
        leftEye.imgNumber = rightEye.imgNumber;
        if(rand.nextDouble() > .2) {
            facePaint.imgNumber = 0;
        }
    }

    @override
    void randomize() {
        super.randomize();
        symbol.imgNumber = 0; //blank it out.
    }


    HomestuckCherubDoll.fromDataString(String dataString){
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be off before given to initFromReader
        initFromReader(reader, new HomestuckCherubPalette());
    }

    //assumes type byte is already gone
    HomestuckCherubDoll.fromReader(ByteReader reader){
        initFromReader(reader, new HomestuckCherubPalette());
    }

}


/// Convenience class for getting/setting aspect palettes
class HomestuckCherubPalette extends HomestuckPalette {
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
    static String _WING1 = "wing1";
    static String _WING2 = "wing2";
    static String _HAIR_MAIN = "hairMain";
    static String _HAIR_ACCENT = "hairAccent";
    static String _EYE_WHITES = "eyeWhites";
    static String _SKIN = "skin";
    static String EYE_BAGS = "eyeBags";

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

    Colour get wing1 => this[_WING1];

    void set wing1(dynamic c) => this.add(_WING1, _handleInput(c), true);


    Colour get eyeBags => this[EYE_BAGS];

    void set eyeBags(dynamic c) => this.add(EYE_BAGS, _handleInput(c), true);

    Colour get wing2 => this[_WING2];

    void set wing2(dynamic c) => this.add(_WING2, _handleInput(c), true);
}
