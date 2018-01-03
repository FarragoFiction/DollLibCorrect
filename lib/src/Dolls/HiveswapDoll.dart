import "../Misc/random.dart";
import "../includes/colour.dart";
import "../Dolls/Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../includes/bytebuilder.dart";
import "../includes/palette.dart";
import "../Rendering/ReferenceColors.dart";

//MadCreativity championed this one.
class HiveswapDoll extends Doll {
    int maxBody = 0;
    int maxEyebrows = 2;
    int maxHorn = 6;
    int maxHair = 8;

    int maxEyes = 1;
    int maxMouth = 6;



    String folder = "images/Homestuck/Hiveswap";

    SpriteLayer body;
    SpriteLayer eyebrows;
    SpriteLayer leftEye;
    SpriteLayer rightEye;
    SpriteLayer hairTop;
    SpriteLayer hairBack;
    SpriteLayer leftHorn;
    SpriteLayer rightHorn;
    SpriteLayer mouth;



    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[body,hairBack, eyebrows,leftEye,rightEye, hairTop,leftHorn, rightHorn,mouth];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[body,eyebrows,leftEye, rightEye,hairBack,hairTop,leftHorn, rightHorn,mouth];


    @override
    int width = 900;
    @override
    int height = 1000;

    @override
    int renderingType =914; //hiveswap release date

    @override
    Palette paletteSource = new HiveswapPalette()
        ..skin = '#C947FF'
        ..left_eye = '#5D52DE'
        ..right_eye = '#D4DE52'
        ..skin_dark = "#9130BA"
        ..shirt_detail = "#3957C8"
        ..pants = "#6C47FF"
        ..pants_detail = "#87FF52"
        ..shoes = "#5CDAFF"
        ..hair = "#5FDE52"
        ..shirt = '#3358FF';

    @override
    Palette palette = new HiveswapPalette()
        ..skin = '#C947FF'
        ..left_eye = '#5D52DE'
        ..right_eye = '#D4DE52'
        ..skin_dark = "#9130BA"
        ..shirt_detail = "#3957C8"
        ..pants = "#6C47FF"
        ..pants_detail = "#87FF52"
        ..shoes = "#5CDAFF"
        ..hair = "#5FDE52"
        ..shirt = '#3358FF';

    HiveswapDoll() {
        initLayers();
        randomize();
    }

    HiveswapDoll.fromDataString(String dataString){
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be gone for reader
        initFromReader(reader, new HiveswapPalette());
    }

    @override
    void load(String dataString) {
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be gone for reader
        initFromReader(reader, new HiveswapPalette(), false);
    }

    //assumes type byte is already gone
    HiveswapDoll.fromReader(ByteReader reader){
        initFromReader(reader,new HiveswapPalette());
    }

    @override
    void initLayers() {
        hairTop = new SpriteLayer("Hair","$folder/HairTop/", 1, maxHair);
        hairBack = new SpriteLayer("Hair","$folder/HairBack/", 1, maxHair, syncedWith:<SpriteLayer>[hairTop]);
        hairTop.syncedWith.add(hairBack);
        hairBack.slave = true; //can't be selected on it's own

        body = new SpriteLayer("Body", "$folder/Body/", 1, maxBody);
        eyebrows = new SpriteLayer("EyeBrows", "$folder/Eyebrows/", 1, maxEyebrows);
        leftEye = new SpriteLayer("LeftEye", "$folder/LeftEye/", 1, maxEyes);
        rightEye = new SpriteLayer("RightEye", "$folder/RightEye/", 1, maxEyes);
        leftHorn = new SpriteLayer("LeftHorn", "$folder/LeftHorn/", 1, maxHorn);
        rightHorn = new SpriteLayer("RightHorn", "$folder/RightHorn/", 1, maxHorn);
        mouth = new SpriteLayer("Mouth", "$folder/Mouth/", 1, maxMouth);
    }

    @override
    void randomize() {
        Random rand = new Random();
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
            if(l.imgNumber == 0 && l != body) l.imgNumber = 1;
        }
        randomizeColors();
    }



    @override
    void randomizeNotColors() {
        Random rand = new Random();
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
        }
    }

}




class HiveswapPalette extends Palette {
    static String _SKIN = "skin"; //fuscia
    static String _SKIN_DARK = "skindark";
    static String _SHIRT = "shirt"; //blue
    static String _SHIRT_DETAIL = "shirtdetail";
    static String _PANTS = "pants"; //purple
    static String _PANTS_DETAIL = "pantsdetail";
    static String _SHOES = "shoes"; //teal
    static String _RIGHT_EYE = "righteye"; //yellow
    static String _LEFT_EYE = "lefteye"; //indigo
    static String _HAIR = "hair"; //green




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

    Colour get text => this[_SKIN];

    Colour get skin => this[_SKIN];

    void set skin(dynamic c) => this.add(_SKIN, _handleInput(c), true);

    Colour get left_eye => this[_LEFT_EYE];

    void set left_eye(dynamic c) => this.add(_LEFT_EYE, _handleInput(c), true);

    Colour get right_eye => this[_RIGHT_EYE];

    void set right_eye(dynamic c) => this.add(_RIGHT_EYE, _handleInput(c), true);

    Colour get skin_dark => this[_SKIN_DARK];

    void set skin_dark(dynamic c) => this.add(_SKIN_DARK, _handleInput(c), true);

    Colour get shirt => this[_SHIRT];

    void set shirt(dynamic c) => this.add(_SHIRT, _handleInput(c), true);

    Colour get shirt_detail => this[_SHIRT_DETAIL];

    void set shirt_detail(dynamic c) => this.add(_SHIRT_DETAIL, _handleInput(c), true);

    Colour get pants => this[_PANTS];

    void set pants(dynamic c) => this.add(_PANTS, _handleInput(c), true);

    Colour get pants_detail => this[_PANTS_DETAIL];

    void set pants_detail(dynamic c) => this.add(_PANTS_DETAIL, _handleInput(c), true);

    Colour get shoes => this[_SHOES];

    void set shoes(dynamic c) => this.add(_SHOES, _handleInput(c), true);

    Colour get hair => this[_HAIR];

    void set hair(dynamic c) => this.add(_HAIR, _handleInput(c), true);




}