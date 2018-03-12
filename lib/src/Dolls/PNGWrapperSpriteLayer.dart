import "SpriteLayer.dart";
import 'package:RenderingLib/RendereringLib.dart';

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
  void loadFromReader(ByteReader reader) {
      //throw("does not support loading");

  }


}