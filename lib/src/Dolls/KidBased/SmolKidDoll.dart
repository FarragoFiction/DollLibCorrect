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
        double scale = 0.6;
        int smolWidth = (width * scale).round();
        int smolHeight = (height * scale).round();
        int x = 90;
        int y = 120;


        leftEye = new PositionedLayerPlusUltra(smolWidth, smolHeight, x,y,"LeftEye","$folder/LeftEye/", 1, maxEye)..primaryPartner = false;
        rightEye = new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"RightEye","$folder/RightEye/", 1, maxEye)..partners.add(leftEye);

        extendedHairTop = new PositionedLayerPlusUltra(smolWidth, smolHeight, x,y,"HairFront","$folder/HairTop/", 1, maxHair)..secretMax = maxSecretHair;
        extendedHairBack = new PositionedLayerPlusUltra(smolWidth, smolHeight, x,y,"HairBack","$folder/HairBack/", 1, maxHair)..secretMax = maxSecretHair;
        extendedHairBack.syncedWith.add(extendedHairTop);
        extendedHairTop.syncedWith.add(extendedHairBack);
        extendedHairBack.slave = true;

        glasses = new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"Glasses","$folder/Glasses/", 1, maxGlass);
        glasses2 = new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"Glasses2","$folder/Glasses2/", 0, maxGlass2)..secretMax = maxSecretGlass2;

        mouth = new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"Mouth","$folder/Mouth/", 1, maxMouth)..secretMax = maxSecretMouth;
        symbol = new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"Symbol","$folder/Symbol/", 1, maxSymbol)..secretMax = maxSecretSymbol;
        facePaint = new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"FacePaint","$folder/FacePaint/", 0, maxFacePaint);


    }





}
