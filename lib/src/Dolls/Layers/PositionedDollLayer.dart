import 'dart:async';
import 'dart:html';
import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:DollLibCorrect/src/Dolls/Doll.dart';
import 'package:DollLibCorrect/src/Dolls/Layers/PositionedLayer.dart';
import 'package:CommonLib/Compression.dart';
//it's a layer which is an entire doll (like fruit or flower or whatever, or evne a kid)
class PositionedDollLayer extends PositionedLayer{
    Doll doll;
    int width;
    int height;
  PositionedDollLayer(Doll this.doll, int this.width, int this.height, int x, int y, String name) : super(x, y, name, "n/a", 0, 1);


    @override
    void saveToBuilder(ByteBuilder builder) {
        doll.toDataBytesX(builder);
    }

    @override
    void loadFromReader(ImprovedByteReader reader) {
        doll = Doll.loadSpecificDollFromReader(reader);
    }

    @override
    Future<Null> drawSelf(CanvasElement buffer) async {
        //print("drawing a positioned doll layer named $name");
        CanvasElement dollCanvas = doll.blankCanvas;
        await DollRenderer.drawDoll(dollCanvas, doll);
        buffer.context2D.drawImageScaled(dollCanvas, x, y, width, height);
    }

}