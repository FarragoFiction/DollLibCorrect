import "dart:async";
import "dart:html";

import "package:DollLibCorrect/DollRenderer.dart";
import 'package:DollLibCorrect/src/commonImports.dart';
import "package:LoaderLib/Loader.dart";

Element output = querySelector('#output');
Future<void> main() async {
    await Doll.loadFileData();

    DateTime startTime = new DateTime.now();
    //Doll doll = Doll.randomDollOfType(85);
    //new TimeProfiler("load doll", startTime);
    start();
}

//remember you can turn debug statements on to print on screen     //doll.visualizeData(output);
Future<void> start() async {
    await Loader.loadManifest();
    await breedTest();
    await breedGrubTest();
   // runTests();


    //await renderEverythingAndLoad();
    //await testPartial();
    //speedTest();
    print("starting");
    //Doll doll = Doll.loadSpecificDoll("Despap Citato:___ArBhlggBlggBDYACFr_94nuZzk9BlggBlggAA_wAAAABAUwBQaABlggATExMAAAApHVMgFUYA_wAA_wBJSUlpuMgHhEYDQiMIgSwJYDtgLQBpeAp0AxgGMAqAFRg");
    Doll doll = new CookieDoll();
    Doll doll2 = new Magical2Doll();

    // testMaxParts(85);
    //makeForestOfDollOfTypeNewColors(doll,doll.renderingType);

    try {
        await drawDoll(doll);
        await drawDoll(doll2);
        //convertDollToTreeBab();
    }catch(error,trace) {
        output.appendHtml("ERROR DRAWING DOLL: $error");
        window.console.error([error,trace]);
    }

    //makeForestOfDollOfTypeNewColors(doll,44);
}

void convertDollToTreeBab() async {
    Doll doll = Doll.loadSpecificDoll("Othala Grigor:___ArBiZAE3y4Onju8-Fr_94nuZzk9AAAAAAAAAA_wAAAADy4Onyqs7y4OkTExMAAAApHVMgFUYA_wAA_wBJSUlpuMgzMzMREREIgE_AJ-AUrANWl0AbcA24BowDR4=");
    await drawDoll(doll);
    doll = Doll.convertOneDollToAnother(doll, new HomestuckTreeBab());
    (doll as HomestuckTreeBab).extendedBody.imgNumber = 1;
    (doll as HomestuckTreeBab).body.imgNumber = 1;
    HomestuckLamiaPalette h = doll.palette;
    final String light = h.aspect_light.toStyleString();
        h.horn1 = new Colour.fromStyleString(light);

    makeOtherColorsDarker(h, "horn1", <String>["horn2","horn3"]);

    doll.dollName = "Othala Grigor";
    await drawDoll(doll);
}

void makeOtherColorsDarker(Palette p, String sourceKey, List<String> otherColorKeys) {
    String referenceKey = sourceKey;
    //print("$name, is going to make other colors darker than $sourceKey, which is ${p[referenceKey]}");
    for(String key in otherColorKeys) {
        //print("$name is going to make $key darker than $sourceKey");
        p.add(key, new Colour(p[referenceKey].red, p[referenceKey].green, p[referenceKey].blue)..setHSV(p[referenceKey].hue, 7*p[referenceKey].saturation/3, 5*p[referenceKey].value / 5), true);
        //print("$name made  $key darker than $referenceKey, its ${p[key]}");

        referenceKey = key; //each one is progressively darker
    }
}

void testMaxParts(int dollType) {
    Doll doll = Doll.randomDollOfType(dollType);
    doll.renderingOrderLayers.forEach((SpriteLayer layer) => layer.imgNumber = layer.maxImageNumber);
    drawDoll(doll);
}

Future<void> lifeSpanTest() async {
    //want to have three lifestages displayed
    HomestuckGrubDoll wiggler = new HomestuckGrubDoll();

    CanvasElement newCanvas = new CanvasElement(width: wiggler.width*2, height: wiggler.height);
    output.append(newCanvas);


    CanvasElement canvas = await wiggler.getNewCanvas(true);

    SmolTrollDoll doll = wiggler.hatch();

    CanvasElement canvas2 = await doll.getNewCanvas(true);

    Doll doll2 = doll.hatch();
    CanvasElement canvas3 = await doll2.getNewCanvas(true);


    newCanvas.context2D.drawImage(canvas2,-50,0);
    newCanvas.context2D.drawImage(canvas3,50,0);
    newCanvas.context2D.drawImageScaled(canvas,0,wiggler.height-100,wiggler.width/3, wiggler.height/3);



}

Future<void> monstrousTest() async {
    List<Palette> choices = <Palette>[MagicalDoll().pinkGirl,MagicalDoll().blueGirl,MagicalDoll().orangeGirl,MagicalDoll().greenGirl,MagicalDoll().purpleGirl];
    for(Palette choice in choices) {
        DivElement div = new DivElement();
        MagicalDoll doll = new MagicalDoll();
        doll.copyPalette(choice);
        div.append(await doll.getNewCanvas()..style.display = "inline-block");
        MonsterGirlDoll monster = doll.hatch();
        div.append(await monster.getNewCanvas()..style.display = "inline-block");
        output.append(div);
        DivElement doop = new DivElement()..text = "Not Hair: ${monster.notHairFront.imgNumber}";
        output.append(doop);

    }

    for(int i = 0; i<6; i++) {
        DivElement div = new DivElement();
        MagicalDoll doll = new MagicalDoll();
        div.append(await doll.getNewCanvas()..style.display = "inline-block");
        MonsterGirlDoll monster = doll.hatch();
        div.append(await monster.getNewCanvas()..style.display = "inline-block");
        output.append(div);
        DivElement doop = new DivElement()..text = "Not Hair: ${monster.notHairFront.imgNumber}";
        output.append(doop);
    }

}

Future<void> runTests() async{
    await monstrousTest();
    await renderEverythingAndLoad();
    //await renderAndLoadDoll(8); // queen
    //await speedTest();
    //await breedTest();
    //await breedTestTrees();
    //await clickTest();
    //await testPartial();
}

Future<void> testPartial() async {
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

void dumbshittest(Doll doll) async {
    Future<CanvasElement> futureCanvas = doll.getNewCanvas();
    CanvasElement canvas1 = await futureCanvas;
    CanvasElement canvas2 = await futureCanvas;
    window.alert("canvas 1 is $canvas1, and canvas 2 is $canvas2");

}

Future<void> renderEverythingAndLoad() async {
    for(int type in Doll.allDollTypes) {
        print("rendering type $type");
        try {
            await renderAndLoadDoll(type);
        }catch(e,trace) {
            window.alert("error rendering type $type, $e");
            print("error rendering type $type, $e");
        }
    }

    await renderAndLoadDoll(34);
    await renderAndLoadDoll(35);
    await renderAndLoadDoll(36);
    await renderAndLoadDoll(33);


}

void maxAllLayers(Doll doll) {
    for(SpriteLayer layer in doll.renderingOrderLayers) {
        layer.imgNumber = layer.maxImageNumber;
    }
}

Future<void> renderAndLoadDoll(int type) async {
    DivElement us = new DivElement()..style.border = "3px solid black";
    output.append(us);
    try {

        Doll doll = Doll.randomDollOfType(type);
        maxAllLayers(doll);

        //print("type $type - ${doll.name}");
        await doll.setNameFromEngine();
        //print("save");
        String dollString = doll.toDataBytesX();
        //(doll as TreeDoll).fruitTemplate = new FruitDoll()..body.imgNumber = 24;
        //(doll as TreeDoll).fruitTime = true;
        DivElement nameElement = new DivElement()..text = "${doll.dollName} (ID: ${doll.seed})";
        us.append(nameElement);
        CanvasElement canvas = await doll.getNewCanvas(true);
        us.append(canvas);
        //print("load");
        Doll doll2 = Doll.loadSpecificDoll(dollString);
        CanvasElement canvas2 = await doll2.getNewCanvas(true);
        us.append(canvas2);
    }catch(e,trace) {
        us.append(new SpanElement()..text = "no alt form for $type, OR error $e");
        print("Error $e and trace $trace");
        window.console.error(e);
    }
}

Future<void> clickTest() async {
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
Future<void> breedGrubTest() async {
    HomestuckGrubDoll fruit = new HomestuckGrubDoll();
    HomestuckGrubDoll fruit2 = new HomestuckGrubDoll();

    CanvasElement canvas = await fruit.getNewCanvas(true);
    Doll child = Doll.breedDolls(<Doll>[fruit,fruit2]);
    output.append(canvas);
    output.append(new SpanElement()..text = "${fruit.dollName}");
    for(int i = 0; i <10; i++) {
        //FruitDoll fruit2 = new FruitDoll();
        Doll child = Doll.breedDolls(<Doll>[fruit,fruit2]);
        CanvasElement childCanvas = await child.getNewCanvas(true);
        output.append(childCanvas);
        output.append(new SpanElement()..text = "${child.dollName}");
    }
}

//if a cloned fruit is identical to its parent does it have the same name?
Future<void> breedTest() async {
    FruitDoll fruit = new FruitDoll();
    fruit.body.imgNumber = 85;
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

Future<void> breedTestTrees() async {
    //loading from string so its as close as possible to LOHAE
    TreeDoll tree = new TreeDoll();
    tree.fruitTime = true;
    tree.maxFruit = 33;
    tree.fruitTemplate = new PigeonDoll();

    //fruit.body.imgNumber = 74;
    CanvasElement canvas = await tree.getNewCanvas(true);
    output.append(canvas);
    output.append(new SpanElement()..text = "${tree.fruitTemplate.dollName}");
    for(int i = 0; i <3; i++) {
        //FruitDoll fruit2 = new FruitDoll();
        TreeDoll child = Doll.breedDolls(<Doll>[tree]);
        print("after breeding the fruit template of the child is ${child.fruitTemplate}");
        child.fruitTime = true;
        CanvasElement childCanvas = await child.getNewCanvas(true);
        output.append(childCanvas);
        output.append(new SpanElement()..text = "${child.fruitTemplate.dollName}");
    }
}

Future<void> speedTest() async {
    Future<void> test(Future<void> stuff()) async {
        final int then = DateTime.now().millisecondsSinceEpoch;
        await stuff();
        final int now = DateTime.now().millisecondsSinceEpoch;
        print("elapsed: ${now - then}ms");
    }

    final TreeDoll doll = Doll.randomDollOfType(33);
    doll.fruitTime = true;

    CanvasElement canvas = await doll.getNewCanvas(true);
    output.append(canvas);

    await test(() async{
        CanvasElement canvas = await doll.getNewCanvasLegacy(true);
        output.append(canvas);
    });

    await test(() async{
        CanvasElement canvas = await doll.getNewCanvas(true);
        output.append(canvas);
    });
}

Future<void>  drawDollScaled(Doll doll, int w, int h) async {
    CanvasElement monsterElement = new CanvasElement(width:w, height: h);
    CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);

    await DollRenderer.drawDoll(dollCanvas, doll);
    //Renderer.drawBG(monsterElement, ReferenceColours.RED, ReferenceColours.WHITE);

    dollCanvas = Renderer.cropToVisible(dollCanvas);

    Renderer.drawToFitCentered(monsterElement, dollCanvas);
    querySelector('#output').append(monsterElement);
}





Future<CanvasElement>  drawDoll(Doll doll, [CanvasElement finishedProduct = null]) async{
    print("trying to draw doll with debug shit");
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


Future<void> makeForestOfDollOfType(Doll doll, int type) async {
    int width = 2000;
    int height = 800;
    CanvasElement canvas = new CanvasElement(width: width, height: height);
    Doll sampleDoll = Doll.randomDollOfType(type);
    int x = -1 * doll.width;
    int y = height - doll.height;
    while(x < width) {
        //print("drawing a thing of type $type, x is $x"); //TODO uncomment
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
        //print("finished drawing, x is $x"); //TODO uncomment

    }
    print("appending canvas to output");
    output.append(canvas);
}

Future<void> makeForestOfDollOfTypeNewColors(Doll doll, int type) async {
    int width = 2000;
    int height = 800;
    CanvasElement canvas = new CanvasElement(width: width, height: height);
    Doll sampleDoll = Doll.randomDollOfType(type);
    int x = -1 * doll.width;
    int y = height - doll.height;
    while(x < width) {
        //print("drawing a thing of type $type, x is $x"); //TODO uncomment
        Doll tmpDoll = Doll.randomDollOfType(type);
        if(tmpDoll is TreeDoll) {
            if(doll.rand.nextBool()) {
                (tmpDoll as TreeDoll).flowerTime = true;
            }else {
                (tmpDoll as TreeDoll).fruitTime = true;

            }
        }
        CanvasElement dollCanvas = new CanvasElement(width: tmpDoll.width, height: tmpDoll.height);
        await DollRenderer.drawDoll(dollCanvas, tmpDoll);
        canvas.context2D.drawImage(dollCanvas,x, y);
        x += sampleDoll.rand.nextIntRange((sampleDoll.width*.25).round(), (sampleDoll.width*.75).round());
        //print("finished drawing, x is $x"); //TODO uncomment

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