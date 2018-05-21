import 'package:RenderingLib/RendereringLib.dart';

import "../Dolls/Doll.dart";
import "../Dolls/HomestuckDoll.dart";

import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';

import "../Rendering/ReferenceColors.dart";
class BroomDoll extends Doll {

    @override
    String originalCreator = "Cat,fireRachet";

    int maxHandle = 10;
    int maxHead = 13;

    String relativefolder = "images/Broom";

    SpriteLayer handle;
    SpriteLayer head;


    @override
    String name = "Broom";


    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[handle, head];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[handle, head];


    @override
    int width = 400;
    @override
    int height = 200;

    @override
    int renderingType =22;


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



    BroomDoll() {
        initLayers();
        randomize();
    }

    BroomDoll.fromDataString(String dataString){
        validPalettes.addAll(ReferenceColours.paletteList.values);
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be gone for reader
        initFromReader(reader, new HomestuckPalette());
    }


    @override
    void load(String dataString) {
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be gone for reader
        initFromReader(reader, new HomestuckPalette(), false);
    }

    //assumes type byte is already gone
    BroomDoll.fromReader(ByteReader reader){
        initFromReader(reader,new HomestuckPalette());
    }

    @override
    void initLayers() {
        handle = new SpriteLayer("Handle", "$folder/Handle/", 1, maxHandle);
        head = new SpriteLayer("Head", "$folder/Head/", 1, maxHead);
    }


    @override
    void randomize() {
        randomizeNotColors();
        randomizeColors();
    }

    @override
    void randomizeColors() {
        HomestuckPalette o = palette as HomestuckPalette;

        palette.add(HomestuckPalette.ASPECT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)),true);
        makeOtherColorsDarker(o, HomestuckPalette.ASPECT_LIGHT, <String>[HomestuckPalette.ASPECT_DARK]);

        palette.add(HomestuckPalette.SHIRT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)),true);
        makeOtherColorsDarker(o, HomestuckPalette.SHIRT_LIGHT, <String>[HomestuckPalette.SHIRT_DARK]);

    }



}
