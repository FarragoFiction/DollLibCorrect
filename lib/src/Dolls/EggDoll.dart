import "HomestuckTrollDoll.dart";
import 'package:RenderingLib/RendereringLib.dart';

import "../Dolls/Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';

import "../Dolls/HomestuckDoll.dart";
import "../Rendering/ReferenceColors.dart";

class EggDoll extends HomestuckDoll {

    @override
    int renderingType =66;

    @override
    final int maxBody = 13;

    EggDoll() {
        initLayers();
        randomize();
    }

    @override
    void initLayers()

    {
        super.initLayers();
        //only one thing different
        body = new SpriteLayer("Body","$folder/Egg/", 1, maxBody);


    }

    EggDoll.fromReader(ByteReader reader){
        initFromReader(reader,new HomestuckPalette());
        if(extendedBody.imgNumber ==0) extendedBody.imgNumber = body.imgNumber;
        if(extendedHairBack.imgNumber ==0) extendedHairBack.imgNumber = hairBack.imgNumber;
        if(extendedHairTop.imgNumber ==0) extendedHairTop.imgNumber = hairTop.imgNumber;

    }




}