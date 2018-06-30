import "Doll.dart";
import "package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart";
import 'package:RenderingLib/RendereringLib.dart';
import "dart:html";
import 'dart:async';

import "package:DollLibCorrect/src/Dolls/Layers/PNGWrapperSpriteLayer.dart";
import 'package:RenderingLib/src/loader/loader.dart';
/*
    before drawing:     await (doll as PngDoll).getWidthFiguredOut();


    A doll in name only. This is a simple wrapper for a png file, so that things that use the doll libarary
    can interchangeably use dolls or pngs at will.

        cannot be loaded/saved.


    NOTE an indivudual project can extend this to, for example, always draw jail cell bars on top of an image
    the laeyrs will work like normal
 */

class PngDoll extends Doll {
  PNGWrapperSpriteLayer pngWrapper;
  @override
  List<SpriteLayer>  renderingOrderLayers  =  new List<SpriteLayer>();
  //empty
  Palette palette = new Palette();

    //relative or absolute, it's just the entire path to the png.
   PngDoll(String imgName, String imgPath):super() {
          pngWrapper = new PNGWrapperSpriteLayer(imgName, imgPath);
          renderingOrderLayers.add(pngWrapper);
  }

  Future<Null> getWidthFiguredOut() async {
      if(width == null) {
          ImageElement image = await Loader.getResource((renderingOrderLayers.first.imgLocation));
          width = image.width;
          height = image.height;
          print("loaded image of ${width} and height ${height}. ");
      }
  }

  void initLayers() {
    // does nothing
  }
}