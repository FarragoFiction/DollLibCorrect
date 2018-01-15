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
     Palette source_palette = new HomestuckSatyrPalette()
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
        ..eyeBags = "9d9d9d"
        ..skin = '#ffffff';

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
        satyrSymbol = new SpriteLayer("Symbol", "$folder/SatyrSymbol/", 0, maxSatyrSymbol, supportsMultiByte: true);
        fluff = new SpriteLayer("Fluff", "$folder/SatyrFluff/", 1, maxFluff);
        tail = new SpriteLayer("Tail", "$folder/SatyrTail/", 0, maxTail);
        leftHorn = new SpriteLayer("LeftHorn", "$folder/SatyrLeftHorn/", 1, maxHorn);
        rightHorn = new SpriteLayer("RightHorn", "$folder/SatyrRightHorn/", 1, maxHorn);
        facePaint = new SpriteLayer("FacePattern","$folder/SatyrFacePattern/", 0, maxFacePattern);
    }

    @override
    void randomize() {
        super.randomize();
        symbol.imgNumber = 0; //blank it out.
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

    void randomizeColors() {

        Random rand = new Random();
        HomestuckPalette h = palette as HomestuckPalette;
        List<HomestuckPalette> paletteOptions = new List<HomestuckPalette>.from(ReferenceColours.paletteList.values);
        HomestuckPalette newPallete = rand.pickFrom(paletteOptions);
        if(newPallete == ReferenceColours.INK) {
            tackyColors();
        }else {
            copyPalette(newPallete);
        }
        palette.add(HomestuckPalette.SHIRT_LIGHT, ReferenceColours.WHITE, true);
        palette.add(HomestuckPalette.SHIRT_DARK, ReferenceColours.BLACK, true);
        palette.add(HomestuckPalette.PANTS_LIGHT, ReferenceColours.WHITE, true);
        palette.add(HomestuckPalette.PANTS_DARK, ReferenceColours.BLACK, true);
        palette.add(HomestuckSatyrPalette.EYE_BAGS, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value / 2), true);
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
