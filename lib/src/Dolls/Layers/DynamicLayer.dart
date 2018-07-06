import 'package:CommonLib/Compression.dart';
import 'package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart';

//has a type so that when loaded from datastring it knows how to instantiate itself
class DynamicLayer extends SpriteLayer {
    //just like how dolls do it
    int renderingType = 0;
  DynamicLayer(String name, String imgNameBase, int imgNumber, int maxImageNumber) : super(name, imgNameBase, imgNumber, maxImageNumber);

  static DynamicLayer instantiateLayer(ImprovedByteReader reader) {

  }

}