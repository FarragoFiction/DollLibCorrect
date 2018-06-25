import 'dart:html';
import 'package:DollLibCorrect/DollRenderer.dart';
import 'dart:async';
import 'package:RenderingLib/RendereringLib.dart';
import 'package:RenderingLib/src/loader/loader.dart';

Element output = querySelector('#output');
Doll doll;
void main() {
    querySelector('#output').text = 'Your Dart app is running.';
    start();

}

Future<bool> start() async {
    await Loader.preloadManifest();
    print("done awaiting");
    //doll =  Doll.randomDollOfType(28);
   //doll = Doll.randomDollOfType(2);
    //doll = new HomestuckDoll();
    //doll = Doll.loadSpecificDoll("KWghqQ8BvkiVPqMuGpIkFqEwAAAA");
     doll = Doll.loadSpecificDoll("http://farragofiction.com/DollSim/index.html?EPD_AQD-QwwsCgGiDAyABAQ-AAD-_______z-f____0dKyzIDg5uGxwuBQZWVla2trYWggBQenoCAgQ4AAAAAAgA");
    //doll = Doll.loadSpecificDoll("manicInsomniac??:___QSADMADw8PAQEBHiEeFBYUCw0L________AAAAaz4UGSwWEh8QIEAgESAP6AIDxwMA____Fh0Oh-CLA0AtBa");
    //doll = Doll.randomDollOfType(18);
    //HomestuckCherubDoll t = doll as HomestuckCherubDoll;
    //doll.useAbsolutePath = false;
   // doll.initLayers();
    //vandalize body 1 to see if its absolute or relative
    //t.body.imgNumber = 1;
    //print("going to use folder ${t.folder}");

    //HiveswapDoll t = doll as HiveswapDoll;
    //HomestuckTrollDoll t = doll as HomestuckTrollDoll;

    //t.extendedRightHorn.imgNumber = 0;
    //t.extendedLeftHorn.imgNumber = 0;

    //print("body is ${t.body.imgNumber}");

    /*

    int minus = 9;
    t.extendedHairTop.imgNumber = t.maxHair-minus;
    t.extendedHairBack.imgNumber = t.maxHair-minus;
    t.mouth.imgNumber = t.maxMouth-minus;
    t.extendedLeftHorn.imgNumber = t.maxHorn-minus;
    t.extendedRightHorn.imgNumber = t.maxHorn-minus;
    t.leftEye.imgNumber = t.maxEye-minus;
    t.rightEye.imgNumber = t.maxEye-minus;
    t.extendedBody.imgNumber = t.maxBody - minus;
    t.facePaint.imgNumber = t.maxFacePaint-minus;
    //t.glasses2.imgNumber = 120;
    */





    // doll = new DadDoll();
   // doll = Doll.loadSpecificDoll("DiC0tLQ8IDQaEBo5IDRKME4bEBr510351005IDSqqKhYWlrS0dGpqKgAAACIiIiYmZkhJiY-IDQaEBoZICAgMDBAQCgAABAA");

    await drawDoll(); //normal




    //doll.orientation = Doll.TURNWAYS;
    //await drawDoll();

    /*
    Doll tmp = new HomestuckTrollDoll();
    doll = Doll.convertOneDollToAnother(doll, tmp);
    await drawDoll(); //normal
    */


    //test png doll
    //doll = new PngDoll("Bed","images/Homestuck/Items/bed.png");
    //await (doll as PngDoll).getWidthFiguredOut();
    //await drawDoll(); //normal

    //test animtions
   // Doll regular = Doll.loadSpecificDoll("ASDsGdUy-E8mQC3suHKxKCKJuOn4_______3nIzuEcnY8XsyiZrpGdVy0Rtyc3BRQsD4__8XaWgAAAC4AAAAEAFoaAA=");
    //Doll edna = Doll.loadSpecificDoll("ASDsGdUy-E8mQC3suHKxKCKJuOn4_______3nIzuEcnY8XsyiZrpGdVy0Rtyc3BRQsD4__8XaWgAAAC4AAAAEAFoaAA=");
    //(edna as HomestuckDoll).extendedHairTop.imgNumber = 0;
    //(edna as HomestuckDoll).extendedHairBack.imgNumber = 0;

    //doll = new MatryoshkaDoll(<Doll>[regular, edna]);
    //await drawDollLoop();


    //await drawDollScaled(doll,375,480); //char sheet
    //await drawDollScaled(doll,256,208); //trading card
    //await drawDollScaled(doll,300,450);//troll call




    // doll = Doll.convertOneDollToAnother(doll, new HomestuckTrollDoll());
    //await drawDoll();
    //doll = Doll.convertOneDollToAnother(doll, new HomestuckGrubDoll());
    //drawDoll();
    //drawDoll();
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



Future<bool>  drawDollLoop([CanvasElement canvas = null]) async {
    CanvasElement ret = await drawDoll(canvas);
    new Timer(new Duration(milliseconds: 100), () => drawDollLoop(ret));

}


Future<CanvasElement>  drawDoll([CanvasElement finishedProduct = null]) async{

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

    doll.visualizeData(output);
    return finishedProduct;
}
