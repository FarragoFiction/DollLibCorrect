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
    doll = Doll.randomDollOfType(33);

   TreeDoll tree = doll as TreeDoll;
   //tree.branches.imgNumber =23;
    tree.barren = false;

    //doll = new HomestuckDoll();
    //doll = Doll.loadSpecificDoll("Tree:___BEEv8AAP8hBq0WBFEGBjwEBB8AAP_______62trf___44VFmQHB7cNDpcCAwMDAyQkJP___wawJgCXLAmAJdglCX-AAH-Qg1aLAiiDAx4CAg-AAH_______9bW1v___8cKizIDg9uGh0uBAYGBgZISEn___6MAYiAywGUAxgGMwShL_AAD_IQatFgRRBgY8BAQfAAD_______-tra3___-OFRZkBwe3DQ6XAgMDAwMkJCT___9GGIB0AOcBGAIxglCX-AAH-Qg1aLAiiDAx4CAg-AAH_______9bW1v___8cKizIDg9uGh0uBAYGBgZISEn___6MHoHIDiAXgAvDBKEv8AAP8hBq0WBFEGBjwEBB8AAP_______62trf___44VFmQHB7cNDpcCAwMDAyQkJP___0YAxaAewD2A3gb2CUJf4AAf5CDVosCKIMDHgICD4AAf_______1tbW____xwqLMgOD24aHS4EBgYGBkhISf___oxIC8AaAC7AXbBKEv8AAP8hBq0WBFEGBjwEBB8AAP_______62trf___44VFmQHB7cNDpcCAwMDAyQkJP___0YbAtAbQDAAGAYJQl_gAB_kINWiwIogwMeAgIPgAB________W1tb____HCosyA4PbhodLgQGBgYGSEhJ___-jAF7gJEBIAE6AJ0wShL_AAD_IQatFgRRBgY8BAQfAAD_______-tra3___-OFRZkBwe3DQ6XAgMDAwMkJCT___9GD6AUACfAI4ARxglCX-AAH-Qg1aLAiiDAx4CAg-AAH_______9bW1v___8cKizIDg9uGh0uBAYGBgZISEn___6MIgJsBNgElAJKwShL_AAD_IQatFgRRBgY8BAQfAAD_______-tra3___-OFRZkBwe3DQ6XAgMDAwMkJCT___9GAMUgHaA7QECAgWCUJf4AAf5CDVosCKIMDHgICD4AAf_______1tbW____xwqLMgOD24aHS4EBgYGBkhISf___owXgMABgANsBtsEoS_wAA_yEGrRYEUQYGPAQEHwAA________ra2t____jhUWZAcHtw0OlwIDAwMDJCQk____RgDNIBjAMYBngM9glCX-AAH-Qg1aLAiiDAx4CAg-AAH_______9bW1v___8cKizIDg9uGh0uBAYGBgZISEn___6MAX1AJ4BbAO4B3MEoS_wAA_yEGrRYEUQYGPAQEHwAA________ra2t____jhUWZAcHtw0OlwIDAwMDJCQk____RgDHwHAA4AE2Am2CUJf4AAf5CDVosCKIMDHgICD4AAf_______1tbW____xwqLMgOD24aHS4EBgYGBkhISf___owBfoGwDWAYQAwjBKEv8AAP8hBq0WBFEGBjwEBB8AAP_______62trf___44VFmQHB7cNDpcCAwMDAyQkJP___0YAzEBtgNoBTAKZgkCX-AAH-Qg1aLAiiDAx4CAg-AAH_______9bW1v___8cKizIDg9uGh0uBAYGBgZISEn___6JgEtAJaDMGbBIEv8AAP8hBq0WBFEGBjwEBB8AAP_______62trf___44VFmQHB7cNDpcCAwMDAyQkJP___0TAJaAS0GYM2CQJf4AAf5CDVosCKIMDHgICD4AAf_______1tbW____xwqLMgOD24aHS4EBgYGBkhISf___omAS0AloMwZsEgS_wAA_yEGrRYEUQYGPAQEHwAA________ra2t____jhUWZAcHtw0OlwIDAwMDJCQk____RMAk4BLQZgzYJAl_gAB_kINWiwIogwMeAgIPgAB________W1tb____HCosyA4PbhodLgQGBgYGSEhJ___-iYBLACWgzBmwSBL_AAD_IQatFgRRBgY8BAQfAAD_______-tra3___-OFRZkBwe3DQ6XAgMDAwMkJCT___9EwCPAEtBmDNgkCX-AAH-Qg1aLAiiDAx4CAg-AAH_______9bW1v___8cKizIDg9uGh0uBAYGBgZISEn___6JgElAJaDMGbBIEv8AAP8hBq0WBFEGBjwEBB8AAP_______62trf___44VFmQHB7cNDpcCAwMDAyQkJP___0TAJaAS0GYM2CQJf4AAf5CDVosCKIMDHgICD4AAf_______1tbW____xwqLMgOD24aHS4EBgYGBkhISf___omAS0AloMwZsEgS_wAA_yEGrRYEUQYGPAQEHwAA________ra2t____jhUWZAcHtw0OlwIDAwMDJCQk____RMAloBLQZgzYJAl_gAB_kINWiwIogwMeAgIPgAB________W1tb____HCosyA4PbhodLgQGBgYGSEhJ___-iYBLQCWgzBmwSBL_AAD_IQatFgRRBgY8BAQfAAD_______-tra3___-OFRZkBwe3DQ6XAgMDAwMkJCT___9EwCWgEtBmDNgkCX-AAH-Qg1aLAiiDAx4CAg-AAH_______9bW1v___8cKizIDg9uGh0uBAYGBgZISEn___6JgEtAJaDMGbBIEv8AAP8hBq0WBFEGBjwEBB8AAP_______62trf___44VFmQHB7cNDpcCAwMDAyQkJP___0TAJIAS0GYM2CQJf4AAf5CDVosCKIMDHgICD4AAf_______1tbW____xwqLMgOD24aHS4EBgYGBkhISf___omARUAloMwZsEgS_wAA_yEGrRYEUQYGPAQEHwAA________ra2t____jhUWZAcHtw0OlwIDAwMDJCQk____RMAloBLQZgzYJAl_gAB_kINWiwIogwMeAgIPgAB________W1tb____HCosyA4PbhodLgQGBgYGSEhJ___-iYBLACWgzBmwSBL_AAD_IQatFgRRBgY8BAQfAAD_______-tra3___-OFRZkBwe3DQ6XAgMDAwMkJCT___9EwCWgEtBmDNgkCX-AAH-Qg1aLAiiDAx4CAg-AAH_______9bW1v___8cKizIDg9uGh0uBAYGBgZISEn___6JgEtAJaDMGbBIEv8AAP8hBq0WBFEGBjwEBB8AAP_______62trf___44VFmQHB7cNDpcCAwMDAyQkJP___0TAJOAS0GYM2CQJf4AAf5CDVosCKIMDHgICD4AAf_______1tbW____xwqLMgOD24aHS4EBgYGBkhISf___omAS0AloMwZsEgS_wAA_yEGrRYEUQYGPAQEHwAA________ra2t____jhUWZAcHtw0OlwIDAwMDJCQk____RMAloBLQZgzYJAl_gAB_kINWiwIogwMeAgIPgAB________W1tb____HCosyA4PbhodLgQGBgYGSEhJ___-iYBLQCWgzBmwSBL_AAD_IQatFgRRBgY8BAQfAAD_______-tra3___-OFRZkBwe3DQ6XAgMDAwMkJCT___9EwCRAEtBmDNgkCX-AAH-Qg1aLAiiDAx4CAg-AAH_______9bW1v___8cKizIDg9uGh0uBAYGBgZISEn___6JgEgAJaDMGbBIEv8AAP8hBq0WBFEGBjwEBB8AAP_______62trf___44VFmQHB7cNDpcCAwMDAyQkJP___0TAJSAS0GYM2CQJf4AAf5CDVosCKIMDHgICD4AAf_______1tbW____xwqLMgOD24aHS4EBgYGBkhISf___omAS0AloMwZsEgS_wAA_yEGrRYEUQYGPAQEHwAA________ra2t____jhUWZAcHtw0OlwIDAwMDJCQk____RMAloBLQZgzYJAl_gAB_kINWiwIogwMeAgIPgAB________W1tb____HCosyA4PbhodLgQGBgYGSEhJ___-iYBLQCWgzBmwSBL_AAD_IQatFgRRBgY8BAQfAAD_______-tra3___-OFRZkBwe3DQ6XAgMDAwMkJCT___9EwCWgEtBmDNgkCX-AAH-Qg1aLAiiDAx4CAg-AAH_______9bW1v___8cKizIDg9uGh0uBAYGBgZISEn___6JgEtAJaDMGbBIEv8AAP8hBq0WBFEGBjwEBB8AAP_______62trf___44VFmQHB7cNDpcCAwMDAyQkJP___0TAJaAS0GYM2CQJf4AAf5CDVosCKIMDHgICD4AAf_______1tbW____xwqLMgOD24aHS4EBgYGBkhISf___omAS0AloMwZ4A==");
    // doll = Doll.loadSpecificDoll("http://farragofiction.com/DollSim/index.html?EPD_AQD-QwwsCgGiDAyABAQ-AAD-_______z-f____0dKyzIDg5uGxwuBQZWVla2trYWggBQenoCAgQ4AAAAAAgA");
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
    //makeForestOfDollOfType(33);
    /*
    doll.orientation = Doll.TURNWAYS;
    await drawDoll();
    doll.orientation = Doll.UPWAYS;
    await drawDoll();
    doll.orientation = Doll.TURNWAYSBUTUP;
    await drawDoll();
    */




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

    doll.visualizeData(output);
    return finishedProduct;
}


Future<Null> makeForestOfDollOfType(int type) async {
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
            (tmpDoll as TreeDoll).barren = false;
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