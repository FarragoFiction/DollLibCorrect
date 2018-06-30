import 'package:RenderingLib/RendereringLib.dart';
import 'package:CommonLib/Compression.dart';

import "../Dolls/Doll.dart";
import "package:DollLibCorrect/src/Dolls/KidBased/HomestuckDoll.dart";

import "package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart";
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
