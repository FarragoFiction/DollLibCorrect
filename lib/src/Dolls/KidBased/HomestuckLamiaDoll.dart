import 'package:RenderingLib/RendereringLib.dart';
import 'package:CommonLib/Compression.dart';

import "../Doll.dart";
import "package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';

import "../../../DollRenderer.dart";
import "dart:html";
import 'dart:async';


class HomestuckLamiaDoll extends HomestuckTrollDoll {

    @override
    String originalCreator = "???";
    List<int> seadwellerBodies = <int>[7,8,9,12,13];

    
    @override
    int renderingType =88;
    @override
    String relativeFolder = "images/Homestuck";
    @override
    final int maxBody = 19;


    @override
    String name = "Grub";


    @override
    Palette palette = new HomestuckTrollPalette()
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



    HomestuckLamiaDoll([int sign]) {
        initLayers();
        randomize();
        if(sign != null) {
           // print("sign is $sign");
            canonSymbol.imgNumber = sign;
            //print("used sign to set canon Symbol to ${canonSymbol.imgNumber}");

            //makes sure palette is sign appropriate
            randomize(false);
            //print("after randomize, canon symbol is ${canonSymbol.imgNumber}");

        }
    }




    void mutantWings([bool force = false]) {
        //grubs don't have wings. trolls do.
    }


    @override
    void regularEyes(older) {
        HomestuckPalette h = palette as HomestuckPalette;
        if(older) {
            palette.add(HomestuckPalette.EYE_WHITE_LEFT, new Colour.fromStyleString("#ffba29"), true);
            palette.add(HomestuckPalette.EYE_WHITE_RIGHT, new Colour.fromStyleString("#ffba29"), true);
        }else {
            h.add(HomestuckPalette.EYE_WHITE_LEFT, h.aspect_light, true);
            h.add(HomestuckPalette.EYE_WHITE_RIGHT, h.aspect_light, true);
        }
    }

    @override
    void randomize([bool chooseSign = true])

    {
        super.randomize(chooseSign);
        pickFin();
    }

    @override
    void randomizeColors() {
        super.randomizeColors();
        copyPalette(ReferenceColours.PURIFIED);
    }

    @override
    void randomizeNotColors() {
        super.randomizeColors();
        pickFin();

    }

    void pickFin() {
        if(seadwellerBodies.contains(extendedBody.imgNumber)) {
            int chosenFin = rand.nextIntRange(1,leftFin.maxImageNumber);
            print("fin chosen is $chosenFin");
            leftFin.imgNumber = chosenFin;
            rightFin.imgNumber = chosenFin;
        }
    }



    @override
    void setUpWays() {

    }

    @override
    void initLayers()

    {
        super.initLayers();
        body = new SpriteLayer("Body","$folder/SnakeBody/", 0, maxBody);
        extendedBody = new SpriteLayer("Body","$folder/SnakeBody/", 0, maxBody, supportsMultiByte: true);


    }








}