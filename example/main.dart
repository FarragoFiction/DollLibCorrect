import 'dart:html';
import 'package:DollLibCorrect/DollRenderer.dart';
import 'dart:async';
import 'package:RenderingLib/RendereringLib.dart';


Doll doll;
void main() {
    querySelector('#output').text = 'Your Dart app is running.';
    start();

}

Future<bool> start() async {
    await Loader.preloadManifest();
    print("done awaiting");
   // doll = Doll.makeRandomDoll();
    doll = new HiveswapDoll();



    HiveswapDoll t = doll as HiveswapDoll;
    //t.leftHorn.imgNumber = t.maxHorn-minus;
    //t.rightHorn.imgNumber = t.maxHorn-minus;

    //print("body is ${t.body.imgNumber}");

    int minus = 0;
    t.leftHorn.imgNumber = t.maxHorn-minus;
    t.rightHorn.imgNumber = t.maxHorn-minus;
    t.hairTop.imgNumber = t.maxHair-minus;
    t.hairBack.imgNumber = t.maxHair-minus;
    t.mouth.imgNumber = t.maxMouth;
    t.leftHorn.imgNumber = t.maxHorn;
    t.rightHorn.imgNumber = t.maxHorn;
    t.leftEye.imgNumber = t.maxEyes;
    t.rightEye.imgNumber = t.maxEyes;
    t.body.imgNumber = t.maxBody - minus;
    t.facepaint.imgNumber = t.maxFacepaint;
    //t.glasses2.imgNumber = 120;
    t.hairTop.imgNumber = t.maxHair-minus;
    t.hairBack.imgNumber = t.maxHair-minus;




    // doll = new DadDoll();
   // doll = Doll.loadSpecificDoll("DiC0tLQ8IDQaEBo5IDRKME4bEBr510351005IDSqqKhYWlrS0dGpqKgAAACIiIiYmZkhJiY-IDQaEBoZICAgMDBAQCgAABAA");

    await drawDoll(); //normal
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


Future<bool>  drawDoll() async{
    Element innerDiv   = new DivElement();
    CanvasElement finishedProduct = new CanvasElement(width: doll.width, height: doll.height);
    innerDiv.className = "cardWithForm";
    await DollRenderer.drawDoll(finishedProduct, doll);
    finishedProduct.className = "cardCanvas";
    innerDiv.append(finishedProduct);
    querySelector('#output').append(innerDiv);
    querySelector('#output').appendHtml(doll.toDataBytesX());
    for(SpriteLayer i in doll.renderingOrderLayers) {
        Element e = new DivElement();
        e.text = "${i.name}: ${i.imgNumber}";

        querySelector('#output').append(e);

    }

}
