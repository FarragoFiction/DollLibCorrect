import 'package:DollLibCorrect/src/Dolls/KidBased/HomestuckTrollDoll.dart';
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


class SmolTrollDoll extends HomestuckTrollDoll {

    @override
    String originalCreator = "Luigicat";

    @override
    int renderingType = 38;

    @override
    String name = "SmolButTroll";


    //Don't go over 255 for any old layer unless you want to break shit. over 255 adds an exo.

    @override
    int maxBody = 21;


    @override
    String relativefolder = "images/Homestuck";

    SmolTrollDoll([int sign]) :super() {
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
        int x = 85;
        int y = 123;


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

        canonSymbol = new PositionedLayerPlusUltra(smolWidth, smolHeight, x,y,"CanonSymbol", "$folder/CanonSymbol/", 0, maxCanonSymbol)..secretMax = 288;
        leftFin = new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"FinLeft", "$folder/LeftFin/", 1, maxFin);
        rightFin = new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"FinRight", "$folder/RightFin/", 1, maxFin,);
        rightFin.syncedWith.add(leftFin);
        leftFin.syncedWith.add(rightFin);
        rightFin.slave = true; //can't be selected on it's own

        wings = new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"Wings", "$folder/Wings/", 0, maxWing);
        leftHorn = new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"LeftHornOld", "$folder/LeftHorn/", 1, 255);
        rightHorn = new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"RightHornOld", "$folder/RightHorn/", 1, 255);
        extendedRightHorn =new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"RightHorn", "$folder/RightHorn/", 1, maxHorn)..primaryPartner = false..secretMax = maxSecretHorn;
        extendedLeftHorn = new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"LeftHorn", "$folder/LeftHorn/", 1, maxHorn)..partners.add(extendedRightHorn)..secretMax = maxSecretHorn;
    }

    @override
    Doll hatch() {
        HomestuckTrollDoll newDoll = new HomestuckTrollDoll();
        int seed = associatedColor.red + associatedColor.green + associatedColor.blue + renderingOrderLayers.first.imgNumber ;
        newDoll.rand = new Random(seed);
        newDoll.randomize();
        Doll.convertOneDollToAnother(this, newDoll);
        newDoll.extendedBody.imgNumber = newDoll.rand.nextInt(newDoll.extendedBody.maxImageNumber);
        newDoll.symbol.imgNumber = 0; //use canon sign you dunkass.
        //(newDoll as HomestuckTrollDoll).mutantEyes(false);
        return newDoll;
    }





}
