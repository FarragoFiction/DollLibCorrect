import "Doll.dart";
import "SpriteLayer.dart";
import 'package:RenderingLib/RendereringLib.dart';

import "PNGWrapperSpriteLayer.dart";
/*
    A doll in name only. This is a simple wrapper for a png file, so that things that use the doll libarary
    can interchangeably use dolls or pngs at will.

    TODO: do i need to care about width/height?

    NOTE an indivudual project can extend this to, for example, always draw jail cell bars on top of an image
    the laeyrs will work like normal
 */

class PngDoll extends Doll {
  PNGWrapperSpriteLayer pngWrapper;
  @override
  List<SpriteLayer>  renderingOrderLayers  =  new List<SpriteLayer>();
  Palette palette = new Palette();

    //relative or absolute, it's just the entire path to the png.
   PngDoll(String imgName, String imgPath):super() {
          pngWrapper = new PNGWrapperSpriteLayer(imgName, imgPath);
          renderingOrderLayers.add(pngWrapper);
  }
  void initLayers() {
    // does nothing
  }
}