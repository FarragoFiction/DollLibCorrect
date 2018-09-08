import 'package:DollLibCorrect/src/Dolls/Layers/PositionedLayer.dart';
import 'package:DollLibCorrect/src/Dolls/Layers/PositionedLayerPlusUltra.dart';
import 'package:RenderingLib/RendereringLib.dart';
import 'package:CommonLib/Compression.dart';

import "../Doll.dart";
import "package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "package:DollLibCorrect/src/Dolls/KidBased/HomestuckSatyrDoll.dart";
import "package:DollLibCorrect/src/Dolls/KidBased/HomestuckDoll.dart";
import "../../Rendering/ReferenceColors.dart";


class SmolKidDoll extends HomestuckDoll {

    @override
    String originalCreator = "Luigicat";

    @override
    int renderingType = 37;

    @override
    String name = "Smol";


    //Don't go over 255 for any old layer unless you want to break shit. over 255 adds an exo.

    @override
    int maxBody = 21;


    @override
    String relativefolder = "images/Homestuck";

    SmolKidDoll([int sign]) :super() {
        if(sign != null) {
            //makes sure palette is sign appropriate
            randomize();
        }
    }








    @override
    void initLayers() {
        super.initLayers();
        //only do what is special to me here.
        //print("initializing layers, folder is: $folder and use absolute path is $useAbsolutePath");

        extendedBody = new SpriteLayer("SmolBody","$folder/SmolBody/", 1, maxBody);
        /*
         hairTop = new SpriteLayer("HairOld","$folder/HairTop/", 1, 255);
        hairBack = new SpriteLayer("HairOld","$folder/HairBack/", 1, 255);
        //hairTop.syncedWith.add(hairBack);
       // hairBack.slave = true; //can't be selected on it's own

        extendedHairTop = new SpriteLayer("HairFront","$folder/HairTop/", 1, maxHair, supportsMultiByte: true)..secretMax = maxSecretHair;
        extendedHairBack = new SpriteLayer("HairBack","$folder/HairBack/", 1, maxHair, syncedWith:<SpriteLayer>[extendedHairTop], supportsMultiByte: true)..secretMax = maxSecretHair;
        extendedHairTop.syncedWith.add(extendedHairBack);
        extendedHairBack.slave = true;

        extendedBody = new SpriteLayer("Body","$folder/Body/", 0, maxBody, supportsMultiByte: true)..secretMax = maxSecretBody;
        body = new SpriteLayer("BodyOld","$folder/Body/", 0, 255);

        facePaint = new SpriteLayer("FacePaint","$folder/FacePaint/", 0, maxFacePaint);

        symbol = new SpriteLayer("Symbol","$folder/Symbol/", 1, maxSymbol)..secretMax = maxSecretSymbol;
        mouth = new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth)..secretMax = maxSecretMouth;
        leftEye = new SpriteLayer("LeftEye","$folder/LeftEye/", 1, maxEye)..primaryPartner = false;
        rightEye = new SpriteLayer("RightEye","$folder/RightEye/", 1, maxEye)..partners.add(leftEye);
        glasses = new SpriteLayer("Glasses","$folder/Glasses/", 1, maxGlass);
        glasses2 = new SpriteLayer("Glasses2","$folder/Glasses2/", 0, maxGlass2)..secretMax = maxSecretGlass2;
         */
        double scale = 0.6;
        int smolWidth = (width * scale).round();
        int smolHeight = (height * scale).round();
        int x = 90;
        int y = 120;


        leftEye = new PositionedLayerPlusUltra(smolWidth, smolHeight, x,y,"LeftEye","$folder/LeftEye/", 1, maxEye)..primaryPartner = false;
        rightEye = new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"RightEye","$folder/RightEye/", 1, maxEye)..partners.add(leftEye);


    }





}
