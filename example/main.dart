import 'dart:html';
import 'package:DollLibCorrect/DollRenderer.dart';
import 'dart:async';
import 'package:RenderingLib/RendereringLib.dart';
import 'package:RenderingLib/src/loader/loader.dart';

Element output = querySelector('#output');
void main() {
    querySelector('#output').text = 'Your Dart app is running.';
    start();

}

//remember you can turn debug statements on to print on screen     //doll.visualizeData(output);
Future<bool> start() async {
    await Loader.preloadManifest();
    await clickTest();
    //speedTest();
    Doll doll = Doll.randomDollOfType(33);
    doll.palette = ReferenceColours.CORRUPT;
    (doll as TreeDoll).fruitTemplate = new FruitDoll()..body.imgNumber = 24;
    (doll as TreeDoll).fruitTime = true;
    await drawDoll(doll);
    Doll doll2 = Doll.randomDollOfType(2);
    doll2.palette = ReferenceColours.CORRUPT;
    await drawDoll(doll2);
}

Future<Null> clickTest() async {
    TreeDoll tree = new TreeDoll();
    tree.fruitTime = true;
    CanvasElement canvas = await tree.getNewCanvas(true);
    output.append(canvas);

    canvas.onClick.listen((MouseEvent e){
        for(PositionedDollLayer dollLayer in tree.hangables) {
            Rectangle rect = canvas.getBoundingClientRect();
            Point point = new Point(e.client.x-rect.left, e.client.y-rect.top);
            bool clicked = dollLayer.pointInsideMe(point);
            print("Did click on ${dollLayer.doll.dollName} with seed ${dollLayer.doll.seed}: $clicked");
        }
    });

}

Future<Null> speedTest() async {
    Doll doll = Doll.randomDollOfType(33);
        (doll as TreeDoll).fruitTime = true;
    CanvasElement canvas = await doll.getNewCanvas(true);
    output.append(canvas);

    canvas = await doll.getNewCanvasLegacy(true);
    output.append(canvas);

    canvas = await doll.getNewCanvas(true);
    output.append(canvas);
}

Future<Null>  drawDollScaled(Doll doll, int w, int h) async {
    CanvasElement monsterElement = new CanvasElement(width:w, height: h);
    CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);

    await DollRenderer.drawDoll(dollCanvas, doll);
    //Renderer.drawBG(monsterElement, ReferenceColours.RED, ReferenceColours.WHITE);

    dollCanvas = Renderer.cropToVisible(dollCanvas);

    Renderer.drawToFitCentered(monsterElement, dollCanvas);
    querySelector('#output').append(monsterElement);
}





Future<CanvasElement>  drawDoll(Doll doll, [CanvasElement finishedProduct = null]) async{

    output.appendHtml(doll.quirk.translate("<br><br>The quick brown fox jumped over the lazy dog, yes?"));

    Element innerDiv   = new DivElement();
    bool fresh = false;
    if(finishedProduct == null) {
        finishedProduct = new CanvasElement(width: doll.width, height: doll.height);
        fresh = true;
    }else {
        Renderer.clearCanvas(finishedProduct);
    }
    innerDiv.className = "cardWithForm";
    finishedProduct.style.border = "3px solid black";
    await DollRenderer.drawDoll(finishedProduct, doll);


    if(fresh) {
        finishedProduct.className = "cardCanvas";
        innerDiv.append(finishedProduct);

        output.append(innerDiv);
        for (SpriteLayer i in doll.dataOrderLayers) {
            Element e = new DivElement();
            e.text = "${i.name}: ${i.imgLocation}";

            output.append(e);
        }
        output.appendHtml(doll.toDataBytesX());
    }
    
    if(doll is EasterEggDoll) {
        AnchorElement a = new AnchorElement(href: (doll as EasterEggDoll).getEasterEgg());
        a.text = "${(doll as EasterEggDoll).getEasterEgg()} (${EasterEggDoll.eggs.length} possible)";
        output.append(a);
    }

    //TODO turn this back on
    //doll.visualizeData(output);
    return finishedProduct;
}


Future<Null> makeForestOfDollOfType(Doll doll, int type) async {
    int width = 2000;
    int height = 800;
    CanvasElement canvas = new CanvasElement(width: width, height: height);
    Doll sampleDoll = Doll.randomDollOfType(type);
    int x = -1 * doll.width;
    int y = height - doll.height;
    while(x < width) {
        print("drawing a thing of type $type, x is $x");
        Doll tmpDoll = Doll.randomDollOfType(type);
        if(tmpDoll is TreeDoll) {
            if(doll.rand.nextBool()) {
                (tmpDoll as TreeDoll).flowerTime = true;
            }else {
                (tmpDoll as TreeDoll).fruitTime = true;

            }
        }
        tmpDoll.copyPalette(sampleDoll.palette);
        CanvasElement dollCanvas = new CanvasElement(width: tmpDoll.width, height: tmpDoll.height);
        await DollRenderer.drawDoll(dollCanvas, tmpDoll);
        canvas.context2D.drawImage(dollCanvas,x, y);
        x += sampleDoll.rand.nextIntRange((sampleDoll.width*.25).round(), (sampleDoll.width*.75).round());
        print("finished drawing, x is $x");

    }
    print("appending canvas to output");
    output.append(canvas);
}