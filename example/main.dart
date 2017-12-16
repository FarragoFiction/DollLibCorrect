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
    doll = new HomestuckTrollDoll();
    HomestuckTrollDoll c = doll as HomestuckTrollDoll;
    c.mouth.imgNumber = 63;
    c.leftEye.imgNumber = 74;

    c.rightEye.imgNumber = 73;
    c.hairTop.imgNumber = 122;
    c.leftHorn.imgNumber = 124;
    c.rightHorn.imgNumber = 124;

    await drawDoll();
   // doll = Doll.convertOneDollToAnother(doll, new HomestuckTrollDoll());
    //await drawDoll();
    //doll = Doll.convertOneDollToAnother(doll, new HomestuckGrubDoll());
    //drawDoll();
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
