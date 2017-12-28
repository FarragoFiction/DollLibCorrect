import 'dart:html';
import 'package:DollLibCorrect/DollRenderer.dart';
import 'dart:async';

Doll doll;
void main() {
    querySelector('#output').text = 'Your Dart app is running.';
    start();

}

Future<bool> start() async {
    await Loader.preloadManifest();
    print("done awaiting");
    doll = Doll.makeRandomDoll();
    //doll = new MonsterPocketDoll();
    //doll = new DadDoll();
    //doll = Doll.loadSpecificDoll("http://localhost:63342/DollBuilder/web/index.html?AiCT3qkPDQWAggIIDQWAhweAggL41035100JDQUAAABYWlrS0dGJiIgAAACIiIiYmZkhJiYODQWAggJAJSNDQLAAqAEoLAQAACgCAAA=");

   // await drawDoll(); //normal
    await drawDollScaled(doll,375,480); //char sheet
    await drawDollScaled(doll,256,208); //trading card
    await drawDollScaled(doll,300,450);//troll call


    // doll = Doll.convertOneDollToAnother(doll, new HomestuckTrollDoll());
    //await drawDoll();
    //doll = Doll.convertOneDollToAnother(doll, new HomestuckGrubDoll());
    //drawDoll();
    //drawDoll();
}

Future<Null>  drawDollScaled(Doll doll, int w, int h) async {
    CanvasElement monsterElement = new CanvasElement(width:w, height: h);
    CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);
    await Renderer.drawDoll(dollCanvas, doll);
    //Renderer.drawBG(monsterElement, ReferenceColours.RED, ReferenceColours.WHITE);

    dollCanvas = Renderer.cropToVisible(dollCanvas);

    Renderer.drawToFitCentered(monsterElement, dollCanvas);
    querySelector('#output').append(monsterElement);
}


Future<bool>  drawDoll() async{
    Element innerDiv   = new DivElement();
    CanvasElement finishedProduct = new CanvasElement(width: doll.width, height: doll.height);
    innerDiv.className = "cardWithForm";
    await Renderer.drawDoll(finishedProduct, doll);
    finishedProduct.className = "cardCanvas";
    innerDiv.append(finishedProduct);
    querySelector('#output').append(innerDiv);

}
