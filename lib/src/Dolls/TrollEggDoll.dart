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
    int renderingType =5;

    @override
    final int maxBody = 13;

    @override
    void initLayers()

    {
        super.initLayers();
        //only one thing different.
        body = new SpriteLayer("Body","$folder/Egg/", 1, maxBody);
    }


}