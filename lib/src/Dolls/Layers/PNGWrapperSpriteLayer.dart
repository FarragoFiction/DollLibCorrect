import "package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart";
import 'package:CommonLib/Compression.dart';
import 'package:RenderingLib/RendereringLib.dart';
import 'package:RenderingLib/src/includes/bytebuilder.dart' as OldByteBuilder;

class PNGWrapperSpriteLayer extends SpriteLayer {

  PNGWrapperSpriteLayer(String name, String imgNameBase) : super(name, imgNameBase, 0, 0);

  String get imgLocation {
      return "$imgNameBase";
  }

  @override
  void saveToBuilder(ByteBuilder builder) {
      //throw("does not support saving");
  }

  @override
  void loadFromReaderOld(OldByteBuilder.ByteReader reader) {
    //throw("does not support loading");

  }

  @override
  void loadFromReader(ImprovedByteReader reader) {
    //throw("does not support loading");

  }


}