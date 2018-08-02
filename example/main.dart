import 'dart:html';
import 'package:DollLibCorrect/DollRenderer.dart';
import 'dart:async';
import 'package:RenderingLib/RendereringLib.dart';
import 'package:RenderingLib/src/loader/loader.dart';

Element output = querySelector('#output');
void main() {
    querySelector('#output').text = 'Your Dart app is running.';
    DateTime startTime = new DateTime.now();
    Doll doll = Doll.randomDollOfType(33);
    new TimeProfiler("load doll", startTime);
    start();
}

//remember you can turn debug statements on to print on screen     //doll.visualizeData(output);
Future<bool> start() async {
    await Loader.preloadManifest();
    await breedTest();
   // await renderEverythingAndLoad();
    //await testPartial();
    //speedTest();
    DateTime startTime = new DateTime.now();
    TreeDoll doll = Doll.randomDollOfType(33);
    new TimeProfiler("load doll", startTime);
    await drawDoll(doll);
    doll.flowerTime = true;
    await drawDoll(doll);
    doll.transformHangablesInto();
    await drawDoll(doll);
    doll = Doll.loadSpecificDoll(doll.toDataBytesX());
    doll.transformHangablesInto();
    await drawDoll(doll);
    //runTests();
}

Future<Null> runTests() async{
   await renderEverythingAndLoad();
   await speedTest();
   await breedTest();
   await clickTest();
   await testPartial();
}

Future<Null> testPartial() async {
    DivElement me = new DivElement()..style.border = "3px solid black";
    output.append(me);
    TreeDoll tree = new TreeDoll();
    tree.flowerTime = true;
    CanvasElement canvas = await tree.getNewCanvas(true);
    me.append(canvas);

    CanvasElement branchCanvas = await tree.renderJustBranches();
    me.append(branchCanvas);

    CanvasElement leavesAndBranches = await tree.renderJustLeavesAndBranches();
    me.append(leavesAndBranches);

    CanvasElement flowers = await tree.renderJustHangables();
    me.append(flowers);

    tree.transformHangablesInto();
    CanvasElement fruit = await tree.renderJustHangables();
    me.append(fruit);
}

Future<Null> renderEverythingAndLoad() async {
    for(int type in Doll.allDollTypes) {
        DivElement us = new DivElement()..style.border = "3px solid black";
        output.append(us);
        try {

            Doll doll = Doll.randomDollOfType(type);
            String dollString = doll.toDataBytesX();
            //(doll as TreeDoll).fruitTemplate = new FruitDoll()..body.imgNumber = 24;
            //(doll as TreeDoll).fruitTime = true;
            CanvasElement canvas = await doll.getNewCanvas(true);
            us.append(canvas);
            Doll doll2 = Doll.loadSpecificDoll(dollString);
            CanvasElement canvas2 = await doll2.getNewCanvas(true);
            us.append(canvas2);
        }catch(e) {
            us.append(new SpanElement()..text = "no alt form for $type");
        }
    }
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

//if a cloned fruit is identical to its parent does it have the same name?
Future<Null> breedTest() async {
    FruitDoll fruit = new FruitDoll();
    print("first fruit in breed test has body of ${fruit.body.imgNumber}, hue of ${fruit.associatedColor.hue}, saturation of ${fruit.associatedColor.saturation} and value of  ${fruit.associatedColor.value} and a seed of ${fruit.seed}");
    CanvasElement canvas = await fruit.getNewCanvas(true);
    Doll child = Doll.breedDolls(<Doll>[fruit]);
    output.append(canvas);
    output.append(new SpanElement()..text = "${fruit.dollName}");
    for(int i = 0; i <10; i++) {
        //FruitDoll fruit2 = new FruitDoll();
        Doll child = Doll.breedDolls(<Doll>[fruit]);
        CanvasElement childCanvas = await child.getNewCanvas(true);
        output.append(childCanvas);
        (child as FruitDoll).setName();
        output.append(new SpanElement()..text = "${child.dollName}");
    }
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


class TimeProfiler {
    String label;
    DateTime start;
    DateTime end;

    TimeProfiler(String this.label, DateTime this.start) {
        end = new DateTime.now();
        Duration diff = end.difference(start);
        print("$label stopped after ${diff.inMilliseconds} ms.");
    }
}