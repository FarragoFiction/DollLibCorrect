import 'package:RenderingLib/RendereringLib.dart';

import "../Dolls/Doll.dart";
import "../Dolls/PigeonDoll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';

import "../Rendering/ReferenceColors.dart";
class EasterEggDoll extends Doll {

    @override
    String originalCreator = "jadedResearcher";

    //TODO random set of pigeon palettes maybe for random colored pigeons?
    int maxBase = 32;
    int maxTop = 20;
    int maxMiddle = 20;
    int maxBottom = 20;

    String relativefolder = "images/EasterEgg";

    SpriteLayer base;
    SpriteLayer middle;
    SpriteLayer bottom;
    SpriteLayer top;

    @override
    String name = "EasterEgg";


    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[base, top,bottom,middle];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[base,middle,bottom,top];

    @override
    List<Palette> get validPalettes => <Palette>[redBird2, greyBird, frohike,traitor,whiteBird,byers,redBird,blackBird];


    @override
    int width = 234;
    @override
    int height = 300;

    @override
    int renderingType =41; //after the best day ever, easter fools

    @override
    Palette paletteSource = new EasterEggPalette()
        ..eyes = '#f6ff00'
        ..skin = '#00ff20'
        ..feather1 = '#ff0000'
        ..accent = "#b400ff"
        ..feather2 = '#0135ff';

    @override
    Palette palette = new EasterEggPalette()
        ..eyes = '#FF9B00'
        ..skin = '#EFEFEF'
        ..accent = "#b400ff"
        ..feather1 = '#DBDBDB'
        ..feather2 = '#C6C6C6';

    Palette whiteBird = new EasterEggPalette()
        ..eyes = '#ffffff'
        ..skin = '#ffc27e'
        ..accent = "#ffffff"
        ..feather1 = '#ffffff'
        ..feather2 = '#f8f8f8';

    Palette traitor = new EasterEggPalette()
        ..eyes = '#e8da57'
        ..skin = '#dba0a6'
        ..accent = "#a8d0ae"
        ..feather1 = '#e6e2e1'
        ..feather2 = '#bc949d';

    Palette frohike = new EasterEggPalette()
        ..eyes = '#e8da57'
        ..skin = '#5c372e'
        ..accent = "#b400ff"
        ..feather1 = '#b57e79'
        ..feather2 = '#a14f44';

    Palette byers = new EasterEggPalette()
        ..eyes = '#e8da57'
        ..skin = '#807174'
        ..accent = "#77a88b"
        ..feather1 = '#dbd3c8'
        ..feather2 = '#665858';

    Palette greyBird = new EasterEggPalette()
        ..eyes = '#FF9B00'
        ..skin = '#ffc27e'
        ..accent = "#b400ff"
        ..feather1 = '#DBDBDB'
        ..feather2 = '#4d4c45';

    Palette redBird = new EasterEggPalette()
        ..eyes = '#FF9B00'
        ..skin = '#bb8d71'
        ..accent = "#b400ff"
        ..feather1 = '#ffffff'
        ..feather2 = '#4d1c15';

    Palette redBird2 = new EasterEggPalette()
        ..eyes = '#FF9B00'
        ..skin = '#bb8d71'
        ..accent = "#b400ff"
        ..feather1 = '#4d1c15'
        ..feather2 = '#ffffff';

    Palette blackBird = new EasterEggPalette()
        ..eyes = '#ba5931'
        ..skin = '#000000'
        ..accent = "#3c6a5d"
        ..feather1 = '#0a1916'
        ..feather2 = '#252e2c';

    EasterEggDoll() {
        initLayers();
        randomize();
    }

    EasterEggDoll.fromDataString(String dataString){
        validPalettes.addAll(ReferenceColours.paletteList.values);
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be gone for reader
        initFromReader(reader, new EasterEggPalette());
    }

    @override
    void load(String dataString) {
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be gone for reader
        initFromReader(reader, new EasterEggPalette(), false);
    }

    //assumes type byte is already gone
    EasterEggDoll.fromReader(ByteReader reader){
        initFromReader(reader,new EasterEggPalette());
    }

    @override
    void initLayers() {
        base = new SpriteLayer("Base", "$folder/Base/", 1, maxBase);
        middle = new SpriteLayer("Middle", "$folder/Middle/", 1, maxMiddle);
        bottom = new SpriteLayer("Bottom", "$folder/Bottom/", 1, maxBottom);
        top = new SpriteLayer("Top", "$folder/Top/", 1, maxTop
        );

    }

    PigeonDoll hatch() {
        PigeonDoll bird = new PigeonDoll();
        bird.copyPalette(palette);
        //same color, same layers (but don't go over max)
        bird.body.imgNumber = base.imgNumber % bird.maxBody;
        bird.head.imgNumber = top.imgNumber % bird.maxHead;
        bird.wing.imgNumber = middle.imgNumber % bird.maxWing;
        bird.tail.imgNumber = bottom.imgNumber % bird.maxTail;
        return bird;
    }

    @override
    void randomize() {
        randomizeNotColors();
        randomizeColors();
    }

    @override
    randomizeColors() {
        Random rand = new Random();
        WeightedList<String> possibilities = new WeightedList<String>();
        String valid = "valid";
        String tacky = "tacky";
        String dark = "dark";
        String pastel = "pastel";
        possibilities.add(valid, 3.0);
        possibilities.add(tacky);
        possibilities.add(dark);
        possibilities.add(pastel,2.0);

        String choice = rand.pickFrom(possibilities);
        if(choice == valid) {
            copyPalette(rand.pickFrom(validPalettes));
        }else if (choice == dark) {
            pastelColor();
        }else if (choice == tacky) {
            tackyColor();
        }else if(choice == dark) {
            darkColor();
        }
    }

    void pastelColor() {
        int colorAmount = rand.nextInt(100)+155;
        EasterEggPalette h = palette as EasterEggPalette;
        h.eyes =  new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount));
        h.feather1 =  new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount));
        h.feather2 =  new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount));
        h.skin =  new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount));
        h.accent =  new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount));
    }

    void tackyColor() {
        super.randomizeColors();
    }

    void darkColor() {
        int colorAmount = rand.nextInt(100)+100;
        EasterEggPalette h = palette as EasterEggPalette;
        h.eyes =  new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount));
        h.feather1 =  new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount));
        h.feather2 =  new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount));
        h.skin =  new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount));
        h.accent =  new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount));
    }



    @override
    void randomizeNotColors() {
        Random rand = new Random();
        print('randomizing not colors');
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber);
        }

        if(rand.nextDouble() > 0.5) {
            top.imgNumber = 0;
        }
        if(rand.nextDouble() > 0.7) middle.imgNumber = 0;
        if(rand.nextDouble() > 0.5) bottom.imgNumber = 0;

    }

}




class EasterEggPalette extends Palette {
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