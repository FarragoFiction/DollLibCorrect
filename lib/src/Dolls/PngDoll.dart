import "Doll.dart";
import "SpriteLayer.dart";
import "PNGWrapperSpriteLayer.dart";
/*
    A doll in name only. This is a simple wrapper for a png file, so that things that use the doll libarary
    can interchangeably use dolls or pngs at will.

    TODO: do i need to care about width/height?
 */

class PngDoll extends Doll {
  PNGWrapperSpriteLayer pngWrapper;
  @override
  List<SpriteLayer>  renderingOrderLayers  =  new List<SpriteLayer>();

    //relative or absolute, it's just the entire path to the png.
    PngDoll(String imgName, String imgPath):super() {
          pngWrapper = new PNGWrapperSpriteLayer(imgName, imgPath);
          renderingOrderLayers.add(pngWrapper);

    }
  void initLayers() {
    // does nothing
  }
}