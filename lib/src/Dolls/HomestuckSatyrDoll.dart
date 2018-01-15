import "../Misc/random.dart";
import "../includes/colour.dart";
import "../Dolls/Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../includes/bytebuilder.dart";
import "../includes/palette.dart";
import "../Dolls/HomestuckDoll.dart";
import "../Rendering/ReferenceColors.dart";


class HomestuckSatyrDoll extends HomestuckDoll {

    @override
    int renderingType = 15;
    //Don't go over 255 for any old layer unless you want to break shit. over 255 adds an exo.

    //these bodies look terrible with troll signs. if any of these use 47,48, or 49
    List<int> bannedRandomBodies = <int>[96,219,221,223,5,11,14,43,50,59,65,66,67,70,72,75,74,98,100,101,102,106,107,109,63,17];
    int defaultBody = 48;
    int maxHorn = 9;
    int maxFluff = 9;
    int maxFacePattern = 7;
    int maxSatyrSymbol = 15;
    int maxTail = 2;

    SpriteLayer leftHorn;
    SpriteLayer satyrSymbol; //can pick any color, but when randomized will be a canon color.
    SpriteLayer rightHorn;
    SpriteLayer fluff;
    SpriteLayer tail;

    @override
    String folder = "images/Homestuck";

    @override
    List<SpriteLayer> get renderingOrderLayers => <SpriteLayer>[tail, hairBack, body, facePaint, symbol, satyrSymbol, mouth, leftEye, rightEye, glasses, hairTop, fluff, glasses2, rightHorn, leftHorn];


    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[body, hairTop, hairBack, leftEye, rightEye, mouth, symbol, glasses, glasses2,leftHorn, rightHorn, fluff, tail, satyrSymbol, facePaint];


    @override
    void load(String dataString) {
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be gone for reader
        initFromReader(reader, new HomestuckSatyrPalette(), false);
    }

    HomestuckSatyrDoll([int sign]) :super() {
        if(sign != null) {
            satyrSymbol.imgNumber = sign;
            //makes sure palette is sign appropriate
            randomize();
        }
    }

    static int randomSignBetween(int minSign, int maxSign) {
        Random rand = new Random();
        int signNumber = rand.nextInt(maxSign - minSign) + minSign;
        return signNumber;
    }

    static int get randomBurgundySign => randomSignBetween(1,24);
    static int get randomBronzeSign => randomSignBetween(25,48);
    static int get randomGoldSign => randomSignBetween(49,72);
    static int get randomLimeSign => randomSignBetween(73,96);
    static int get randomOliveSign => randomSignBetween(97,120);
    static int get randomJadeSign => randomSignBetween(121,144);
    static int get randomTealSign => randomSignBetween(145,168);
    static int get randomCeruleanSign => randomSignBetween(169,192);
    static int get randomIndigoSign => randomSignBetween(193,216);
    static int get randomPurpleSign => randomSignBetween(217,240);
    static int get randomVioletSign => randomSignBetween(241,264);
    static int get randomFuchsiaSign => randomSignBetween(265,288);



    @override
    Palette paletteSource = ReferenceColours.TROLL_PALETTE;

    @override
    Palette palette = new HomestuckSatyrPalette()
        ..accent = '#FF9B00'
        ..aspect_light = '#FF9B00'
        ..aspect_dark = '#FF8700'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#A3A3A3'
        ..cloak_mid = '#999999'
        ..cloak_dark = '#898989'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..eye_white_left = '#ffba29'
        ..eye_white_right = '#ffba29'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#aa0000'
        ..hair_main = '#000000'
        ..skin = '#C4C4C4';

    @override
    void initLayers() {
        super.initLayers();
        //only do what is special to me here.
        satyrSymbol = new SpriteLayer("Symbol", "$folder/CanonSymbol/", 0, maxSatyrSymbol, supportsMultiByte: true);
        fluff = new SpriteLayer("Fluff", "$folder/SatyrFluff/", 1, maxFluff);
        tail = new SpriteLayer("Tail", "$folder/SatyrTail/", 0, maxTail);
        leftHorn = new SpriteLayer("LeftHorn", "$folder/SatyrLeftHorn/", 1, maxHorn);
        rightHorn = new SpriteLayer("RightHorn", "$folder/SatyrRightHorn/", 1, maxHorn);
        facePaint = new SpriteLayer("FacePattern","$folder/SatyrFacePattern/", 0, maxFacePattern);

    }


    HomestuckSatyrDoll.fromDataString(String dataString){
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be off before given to initFromReader
        initFromReader(reader, new HomestuckSatyrPalette());
    }

    //assumes type byte is already gone
    HomestuckSatyrDoll.fromReader(ByteReader reader){
        initFromReader(reader, new HomestuckSatyrPalette());
    }


}


/// Convenience class for getting/setting aspect palettes
class HomestuckSatyrPalette extends HomestuckPalette {
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

    Colour get wing2 => this[_WING2];

    void set wing2(dynamic c) => this.add(_WING2, _handleInput(c), true);
}
