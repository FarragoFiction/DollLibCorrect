import "HomestuckTrollDoll.dart";
import 'package:RenderingLib/RendereringLib.dart';

import "../Dolls/Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';

import "../Dolls/HomestuckDoll.dart";
import "../Rendering/ReferenceColors.dart";

class TrollEggDoll extends HomestuckTrollDoll {

    @override
    int renderingType =65;

    @override
    final int maxBody = 13;

    TrollEggDoll() {
        initLayers();
        randomize();
    }

    @override
    void initLayers()

    {
        super.initLayers();
        //only one thing different.
        body = new SpriteLayer("Body","$folder/Egg/", 1, maxBody);
    }

    TrollEggDoll.fromReader(ByteReader reader){
        initFromReader(reader,new HomestuckPalette());
        if(extendedBody.imgNumber ==0) extendedBody.imgNumber = body.imgNumber;
        if(extendedHairBack.imgNumber ==0) extendedHairBack.imgNumber = hairBack.imgNumber;
        if(extendedHairTop.imgNumber ==0) extendedHairTop.imgNumber = hairTop.imgNumber;

    }


}