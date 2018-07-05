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
        builder.appendExpGolomb(x);
        builder.appendExpGolomb(y);
        builder.appendExpGolomb(width);
        builder.appendExpGolomb(height);
        builder.appendExpGolomb(doll.rotation);
        builder.appendExpGolomb(doll.orientation);

        builder.appendExpGolomb(y);

    }

    @override
    void loadFromReader(ImprovedByteReader reader) {
        doll = Doll.loadSpecificDollFromReader(reader);
    }

    @override
    Element parseDataForDebugging(ImprovedByteReader reader) {
        TableElement table = new TableElement();
        TableRowElement row1 = new TableRowElement();
        table.append(row1);

        TableCellElement td1 = new TableCellElement()..text = "Image Number:";
        TableCellElement td2 = new TableCellElement()..text = "$imgNumber";
        row1.append(td1);
        row1.append(td2);

        TableRowElement row2 = new TableRowElement();
        table.append(row2);
        td1 = new TableCellElement()..text = "X:";
        td2 = new TableCellElement()..text = "$x";
        row2.append(td1);
        row2.append(td2);

        TableRowElement row3 = new TableRowElement();
        table.append(row3);
        td1 = new TableCellElement()..text = "Y:";
        td2 = new TableCellElement()..text = "$y";
        row3.append(td1);
        return table;
    }

    @override
    Future<Null> drawSelf(CanvasElement buffer) async {
        //print("drawing a positioned doll layer named $name");
        CanvasElement dollCanvas = doll.blankCanvas;
        await DollRenderer.drawDoll(dollCanvas, doll);
        buffer.context2D.drawImageScaled(dollCanvas, x, y, width, height);
    }

}