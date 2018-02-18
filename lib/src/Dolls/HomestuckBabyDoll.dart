import 'package:RenderingLib/RendereringLib.dart';

import "../Dolls/Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';

import "../../DollRenderer.dart";


class HomestuckBabyDoll extends HomestuckDoll {

    @override
    int renderingType =12;
    @override
    String folder = "images/Homestuck";
    @override
    final int maxBody = 3;


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



    HomestuckBabyDoll() {
        initLayers();
        randomize();
    }

    @override
    void randomizeNotColors()

    {
        super.randomizeNotColors();
        symbol.imgNumber = 0;

    }

    @override
    void randomize()

    {
        super.randomize();
        symbol.imgNumber = 0;

    }

    @override
    void initLayers()

    {
        super.initLayers();
        body = new SpriteLayer("Body","$folder/Baby/", 0, maxBody);

    }

    HomestuckBabyDoll.fromDataString(String dataString){
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be off before given to initFromReader
        initFromReader(reader, new HomestuckPalette());
    }

    //assumes type byte is already gone
     HomestuckBabyDoll.fromReader(ByteReader reader){
         initFromReader(reader,new HomestuckPalette());
     }





}