import 'dart:async';
import 'dart:html';
import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart';
import 'package:CommonLib/Compression.dart';

class PositionedLayer extends SpriteLayer {
    //assume doll's upper left is 0,0
    int x;
    int y;
  PositionedLayer(int this.x, int this.y, String name, String imgNameBase, int imgNumber, int maxImageNumber) : super(name, imgNameBase, imgNumber, maxImageNumber);

  @override
    void saveToBuilder(ByteBuilder builder) {
        builder.appendExpGolomb(imgNumber);
        builder.appendExpGolomb(x);
        builder.appendExpGolomb(y);
    }

    @override
    void loadFromReader(ImprovedByteReader reader) {
        imgNumber = reader.readExpGolomb();
        x = reader.readExpGolomb();
        y = reader.readExpGolomb();
    }

    @override
    Future<Null> drawSelf(CanvasElement buffer) async {
        if(preloadedElement != null) {
            //print("I must be testing something, it's a preloaded Element");
            bool res = await Renderer.drawExistingElementFuture(buffer, preloadedElement,x,y);
        }else {
            bool res = await Renderer.drawWhateverFuture(buffer, imgLocation,x,y);
        }
    }
}