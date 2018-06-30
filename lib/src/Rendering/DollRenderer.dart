import "../Dolls/Doll.dart";
import "package:DollLibCorrect/src/Dolls/KidBased/HomestuckDoll.dart";
import "package:DollLibCorrect/src/Dolls/KidBased/HomestuckTrollDoll.dart";
import "dart:html";
import 'dart:async';
import "package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart";
import 'package:RenderingLib/RendereringLib.dart';


import "dart:math" as Math;

import "../Dolls/ConsortDoll.dart";
import 'package:RenderingLib/src/loader/loader.dart';

class DollRenderer {
    static int imagesWaiting = 0;
    static int imagesLoaded = 0;


    static  Future<bool>  drawDoll(CanvasElement canvas, Doll doll) async {
        //print("Drawing a doll of width ${doll.width}");
        if(doll.width == null) {
            ImageElement image = await Loader.getResource((doll.renderingOrderLayers.first.imgLocation));
            doll.width = image.width;
            doll.height = image.height;
           // print("loaded image of ${doll.width} and height ${doll.height}. ");

        }
        CanvasElement buffer = new CanvasElement(width: doll.width, height: doll.height);
        buffer.context2D.imageSmoothingEnabled = false;
        doll.setUpWays();
        if(doll.orientation == Doll.TURNWAYS) {
                //print("drawing turnways");
            //fuck is anything ever using this? this seems wrong, should be
            //buffer.context2D.translate(dollCanvas.width, 0);
            buffer.context2D.translate(buffer.width/2, buffer.height/2);
            buffer.context2D.scale(-1, 1);
        }else if(doll.orientation == Doll.UPWAYS) {
            //print("drawing up ways");
            buffer.context2D.translate(0, buffer.height);
            //buffer.context2D.rotate(1);
            buffer.context2D.scale(1, -1);
        }else if(doll.orientation == Doll.TURNWAYSBUTUP) {
            //print("drawing turnways but up");
            buffer.context2D.translate(0, buffer.height);
            buffer.context2D.scale(-1, -1);
        }else {
            buffer.context2D.scale(1, 1);
        }

        for(SpriteLayer l in doll.renderingOrderLayers) {
            await l.drawSelf(buffer);
        }
        //print("done drawing images");

        if(doll.palette.isNotEmpty) Renderer.swapPalette(buffer, doll.paletteSource, doll.palette);
        scaleCanvasForDoll(canvas, doll);
        canvas.context2D.imageSmoothingEnabled = false;

        if(doll.orientation == Doll.TURNWAYS) {
            canvas.context2D.drawImage(buffer, -1*buffer.width/2, -1*buffer.height/2);

        }else {
            Renderer.copyTmpCanvasToRealCanvasAtPos(canvas, buffer, 0, 0);
        }

    }

    static  Future<bool>  drawDollEmbossed(CanvasElement canvas, Doll doll) async {
        //print("Drawing a doll");
        CanvasElement buffer = new CanvasElement(width: doll.width, height: doll.height);
        for(SpriteLayer l in doll.renderingOrderLayers) {
            if(l.preloadedElement != null) {
                print("I must be testing something, it's a preloaded Element");
                bool res = await Renderer.drawExistingElementFuture(buffer, l.preloadedElement);
            }else {
                bool res = await Renderer.drawWhateverFuture(buffer, l.imgLocation);
            }
        }
        //print("done drawing images");

        buffer.context2D.imageSmoothingEnabled = false;

        Renderer.grayscale(buffer);
        Renderer.emboss(buffer);
        scaleCanvasForDoll(canvas, doll);
        canvas.context2D.imageSmoothingEnabled = false;

        if(doll.orientation == Doll.TURNWAYS) {
            canvas.context2D.drawImage(buffer, -buffer.width/2, -buffer.height/2);

        }else {
            Renderer.copyTmpCanvasToRealCanvasAtPos(canvas, buffer, 0, 0);
        }

    }





    //the doll should fit into the canvas. use largest size
    static scaleCanvasForDoll(CanvasElement canvas, Doll doll) {
        double ratio = 1.0;
        if(doll.width > doll.height) {
            ratio = canvas.width/doll.width;
        }else {
            ratio = canvas.height/doll.height;
        }
        canvas.context2D.scale(ratio, ratio);
        //don't let it be all pixelated
        canvas.context2D.imageSmoothingEnabled = false;

    }

}




