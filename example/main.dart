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
    //doll = Doll.makeRandomDoll();
    doll = new HomestuckDoll();
    await drawDoll();
    doll = Doll.convertOneDollToAnother(doll, new HomestuckTrollDoll());
    await drawDoll();
    doll = Doll.convertOneDollToAnother(doll, new HomestuckGrubDoll());
    drawDoll();
    //drawDoll();
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
