import 'package:RenderingLib/RendereringLib.dart';

import "../Dolls/Doll.dart";
import "../Dolls/HatchedChick.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';

import "../Rendering/ReferenceColors.dart";
abstract class HatchableDoll extends Doll {
    Doll hatch();
}