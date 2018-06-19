import "HomestuckTrollDoll.dart";
import 'package:CommonLib/Compression.dart';
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

    @override
    String name = "Troll Egg";

    TrollEggDoll() {
        initLayers();
        randomize();
    }

    @override
    void initLayers()

    {
        super.initLayers();
        //only one thing different.
        extendedBody = new SpriteLayer("Body","$folder/Egg/", 1, maxBody, supportsMultiByte: true);
    }



}