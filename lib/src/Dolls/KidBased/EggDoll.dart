import "package:DollLibCorrect/src/Dolls/KidBased/HomestuckTrollDoll.dart";
import 'package:RenderingLib/RendereringLib.dart';
import 'package:CommonLib/Compression.dart';

import "../Doll.dart";
import "package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';

import "package:DollLibCorrect/src/Dolls/KidBased/HomestuckDoll.dart";
import "../../Rendering/ReferenceColors.dart";

class EggDoll extends HomestuckDoll {

    @override
    String originalCreator = "multipleStripes";

    @override
    int renderingType =66;

    @override
    final int maxBody = 13;

    @override
    String name = "Egg";

    EggDoll() {
        initLayers();
        randomize();
    }

    @override
    void initLayers()

    {
        super.initLayers();
        //only one thing different
        extendedBody = new SpriteLayer("Body","$folder/Egg/", 1, maxBody, supportsMultiByte: true);


    }






}