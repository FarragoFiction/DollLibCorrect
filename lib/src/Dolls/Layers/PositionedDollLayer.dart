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
        print("saving positioned doll layer $name to builder");
        builder = doll.appendDataBytesToBuilder(builder);
        print("doll done, time for everything else");
        builder.appendExpGolomb(x);
        builder.appendExpGolomb(y);
        builder.appendExpGolomb(width);
        builder.appendExpGolomb(height);

    }

    @override
    void loadFromReader(ImprovedByteReader reader) {
        print("loading positioned doll layer from reader");
        doll = Doll.loadSpecificDollFromReader(reader);
        x = reader.readExpGolomb();
        y = reader.readExpGolomb();
        width = reader.readExpGolomb();
        height = reader.readExpGolomb();
    }

    @override
    Element parseDataForDebugging(ImprovedByteReader reader) {
        print("debugging positioned doll layer from reader");
        TableElement table = new TableElement();
        table.style.border = "3px solid black";

        TableRowElement row0 = new TableRowElement();
        table.append(row0);

        TableCellElement td1 = new TableCellElement()..text = "Doll:";
        doll = Doll.loadSpecificDollFromReader(reader);
        TableCellElement td2 = new TableCellElement()..text = "TODO, but it's a ${doll.name}";
        row0.append(td1);
        row0.append(td2);


        TableRowElement row2 = new TableRowElement();
        table.append(row2);
        td1 = new TableCellElement()..text = "X:";
        td2 = new TableCellElement()..text = "${reader.readExpGolomb()}";
        row2.append(td1);
        row2.append(td2);

        TableRowElement row3 = new TableRowElement();
        table.append(row3);
        td1 = new TableCellElement()..text = "Y:";
        td2 = new TableCellElement()..text = "${reader.readExpGolomb()}";
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