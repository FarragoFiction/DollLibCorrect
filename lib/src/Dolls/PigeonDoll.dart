import "../Misc/random.dart";
import "../includes/colour.dart";
import "../Dolls/Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../includes/bytebuilder.dart";
import "../includes/palette.dart";
import "../Rendering/ReferenceColors.dart";
class PigeonDoll extends Doll {
    //TODO random set of pigeon palettes maybe for random colored pigeons?
    int maxBody = 1;
    int maxHead = 1;
    int maxTail = 1;
    int maxWing = 1;

    String folder = "images/Pigeon";

    SpriteLayer body;
    SpriteLayer head;
    SpriteLayer wing;
    SpriteLayer tail;


    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[tail, body,head,wing];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[body,head,wing,tail];


    @override
    int width = 500;
    @override
    int height = 500;

    @override
    int renderingType =113; //true arc number

    @override
    Palette paletteSource = new PigeonPalette()
        ..eyes = '#f6ff00'
        ..skin = '#00ff20'
        ..feather1 = '#ff0000'
        ..feather2 = '#0135ff';

    @override
    Palette palette = new PigeonPalette()
        ..eyes = '#FF9B00'
        ..skin = '#EFEFEF'
        ..feather1 = '#DBDBDB'
        ..feather2 = '#C6C6C6';

    PigeonDoll() {
        initLayers();
        randomize();
    }

    PigeonDoll.fromDataString(String dataString){
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be gone for reader
        initFromReader(reader, new PigeonPalette());
    }

    @override
    void load(String dataString) {
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be gone for reader
        initFromReader(reader, new PigeonPalette(), false);
    }

    //assumes type byte is already gone
    PigeonDoll.fromReader(ByteReader reader){
        initFromReader(reader,new PigeonPalette());
    }

    @override
    void initLayers() {
        body = new SpriteLayer("Body", "$folder/Body/", 1, maxBody);
        head = new SpriteLayer("Head", "$folder/Head/", 1, maxHead);
        wing = new SpriteLayer("Wing", "$folder/Wing/", 1, maxWing);
        tail = new SpriteLayer("Tail", "$folder/Tail/", 1, maxTail);

    }

    @override
    void randomize() {
        Random rand = new Random();
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
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




class PigeonPalette extends Palette {
    static String _EYES = "eyes"; //yellow
    static String _SKIN = "skin"; //green
    static String _FEATHER1 = "feather1"; //red
    static String _FEATHER2 = "feather2"; //blue

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

    Colour get feather1 => this[_FEATHER1];

    void set feather1(dynamic c) => this.add(_FEATHER1, _handleInput(c), true);

    Colour get feather2 => this[_FEATHER2];
    void set feather2(dynamic c) => this.add(_FEATHER2, _handleInput(c), true);


}