import "../Dolls/Doll.dart";
import "../Dolls/HomestuckDoll.dart";
import "../Dolls/HomestuckTrollDoll.dart";
import "dart:html";
import 'dart:async';
import "../Dolls/SpriteLayer.dart";
import "../includes/colour.dart";
import "../includes/palette.dart";
import "../Misc/random.dart";
import "dart:math" as Math;

import "../loader/loader.dart";
import "../Dolls/ConsortDoll.dart";

class Renderer {
    static int imagesWaiting = 0;
    static int imagesLoaded = 0;


    static  Future<bool>  drawDoll(CanvasElement canvas, Doll doll) async {
        //print("Drawing a doll");
        CanvasElement buffer = new CanvasElement(width: doll.width, height: doll.height);
        buffer.context2D.imageSmoothingEnabled = false;
        doll.setUpWays();
        if(doll.orientation == Doll.TURNWAYS) {
                //print("drawing turnways");
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
            if(l.preloadedElement != null) {
                print("I must be testing something, it's a preloaded Element");
                bool res = await drawExistingElementFuture(buffer, l.preloadedElement);
            }else {
                bool res = await drawWhateverFuture(buffer, l.imgLocation);
            }
        }
        //print("done drawing images");

        if(doll.palette.isNotEmpty) swapPalette(buffer, doll.paletteSource, doll.palette);
        scaleCanvasForDoll(canvas, doll);
        canvas.context2D.imageSmoothingEnabled = false;

        copyTmpCanvasToRealCanvasAtPos(canvas, buffer, 0, 0);

    }

    static  Future<bool>  drawDollEmbossed(CanvasElement canvas, Doll doll) async {
        //print("Drawing a doll");
        CanvasElement buffer = new CanvasElement(width: doll.width, height: doll.height);
        for(SpriteLayer l in doll.renderingOrderLayers) {
            if(l.preloadedElement != null) {
                print("I must be testing something, it's a preloaded Element");
                bool res = await drawExistingElementFuture(buffer, l.preloadedElement);
            }else {
                bool res = await drawWhateverFuture(buffer, l.imgLocation);
            }
        }
        //print("done drawing images");

        buffer.context2D.imageSmoothingEnabled = false;

        grayscale(buffer);
        emboss(buffer);
        scaleCanvasForDoll(canvas, doll);
        canvas.context2D.imageSmoothingEnabled = false;

        copyTmpCanvasToRealCanvasAtPos(canvas, buffer, 0, 0);

    }

    static void grayscale(CanvasElement canvas) {
        CanvasRenderingContext2D ctx = canvas.context2D;
        ImageData img_data = ctx.getImageData(0, 0, canvas.width, canvas.height);
        //4 byte color array

        for (int i = 0; i < img_data.data.length; i += 4) {
            if (img_data.data[i + 3] > 0) {
                num brightness = 0.34 * img_data.data[i] + 0.5 * img_data.data[i + 1] + 0.16 * img_data.data[i + 2];
                int b = 5+(brightness/10).round();
                img_data.data[i] = b;
                img_data.data[i+1] = b;
                img_data.data[i+2] = b;
            }
        }
        ctx.putImageData(img_data, 0, 0);

    }

    static void emboss(CanvasElement canvas) {
        bool opaque = false;
        CanvasRenderingContext2D ctx = canvas.getContext('2d');
        ImageData pixels = ctx.getImageData(0, 0, canvas.width, canvas.height);
        List<int> weights = <int>[ -3, 2, 0, -3, 2, 2, 0, 2, 3];
        int side = (Math.sqrt(weights.length)).round();
        int halfSide = (side ~/ 2);
        List<int> src = pixels.data;
        int sw = pixels.width;
        int sh = pixels.height;
        // pad output by the convolution matrix
        int w = sw;
        int h = sh;
        ImageData output = ctx.getImageData(0, 0, canvas.width, canvas.height);
        List<int> dst = output.data;
        // go through the destination image pixels
        int alphaFac = opaque ? 1 : 0;
        for (int y = 0; y < h; y++) {
            for (int x = 0; x < w; x++) {
                int sy = y;
                int sx = x;
                int dstOff = (y * w + x) * 4;
                // calculate the weighed sum of the source image pixels that
                // fall under the convolution matrix
                int r = 0,
                    g = 0,
                    b = 0,
                    a = 0;
                for (int cy = 0; cy < side; cy++) {
                    for (int cx = 0; cx < side; cx++) {
                        int scy = sy + cy - halfSide;
                        int scx = sx + cx - halfSide;
                        if (scy >= 0 && scy < sh && scx >= 0 && scx < sw) {
                            int srcOff = (scy * sw + scx) * 4;
                            int wt = weights[cy * side + cx];
                            r += src[srcOff] * wt;
                            g += src[srcOff + 1] * wt;
                            b += src[srcOff + 2] * wt;
                            a += src[srcOff + 3] * wt;
                        }
                    }
                }
                dst[dstOff] = r;
                dst[dstOff + 1] = g;
                dst[dstOff + 2] = b;
                dst[dstOff + 3] = a + alphaFac * (255 - a);
            }
        }
        canvas.context2D.putImageData(output, 0, 0);
    }


    //the doll should fit into the canvas. use largest size
    static double scaleForSize(int sourcewidth, int sourceheight, int destwidth, int destheight) {
        double widthratio = destwidth / sourcewidth;
        double heightratio = destheight / sourceheight;
        return Math.min(widthratio, heightratio);
    }


    static drawToFitCentered(CanvasElement destination, CanvasElement source) {
        //print("Drawing to fit width: ${destination.width}, height: ${destination.height}, native width is ${source.width} by ${source.height}");
        double ratio = scaleForSize(source.width, source.height, destination.width, destination.height);
        int newWidth = (source.width * ratio).ceil();
        int newHeight = (source.height * ratio).ceil();
        //doesn't look right :(
        //int x = (destination.width/2 - source.width/2).round();
        int x = (destination.width/2 - newWidth/2).ceil();
        print("New dimensions: ${newWidth}, height: ${newHeight}");
        source.context2D.imageSmoothingEnabled = false;
        destination.context2D.imageSmoothingEnabled = false;


        destination.context2D.drawImageScaled(source, x,0,newWidth,newHeight);
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


    static CanvasElement getBufferCanvas(CanvasElement canvas) {
        return new CanvasElement(width: canvas.width, height: canvas.height);
    }
    static void copyTmpCanvasToRealCanvasAtPos(CanvasElement canvas, CanvasElement tmp_canvas, int x, int y) {
        CanvasRenderingContext2D ctx = canvas.getContext('2d');
        ctx.drawImage(tmp_canvas, x, y);
    }

    static void swapPalette(CanvasElement canvas, Palette source, Palette replacement) {
        //print("swapping ${source.names} for ${replacement.names}");
        CanvasRenderingContext2D ctx = canvas.getContext('2d');
        ImageData img_data = ctx.getImageData(0, 0, canvas.width, canvas.height);

        for (int i = 0; i < img_data.data.length; i += 4) {
            Colour sourceColour = new Colour(img_data.data[i], img_data.data[i + 1], img_data.data[i + 2]);
            for (String name in source.names) {
                if (source[name] == sourceColour) {
                    Colour replacementColour = replacement[name];
                    img_data.data[i] = replacementColour.red;
                    img_data.data[i + 1] = replacementColour.green;
                    img_data.data[i + 2] = replacementColour.blue;
                    break;
                }
            }
        }
        ctx.putImageData(img_data, 0, 0);
    }

    static void drawBGRadialWithWidth(CanvasElement canvas, num startX, num endX, num width, Colour color1, Colour color2) {
        CanvasRenderingContext2D ctx = canvas.getContext("2d");

        CanvasGradient grd = ctx.createRadialGradient(width / 2, canvas.height / 2, 5, width, canvas.height, width);
        grd.addColorStop(0, color1.toStyleString());
        grd.addColorStop(1, color2.toStyleString());

        ctx.fillStyle = grd;
        ctx.fillRect(startX, 0, endX, canvas.height);
    }

    static void drawBG(CanvasElement canvas, Colour color1, Colour color2) {
        CanvasRenderingContext2D ctx = canvas.getContext("2d");

        CanvasGradient grd = ctx.createLinearGradient(0, 0, 170, 0);
        grd.addColorStop(0, color1.toStyleString());
        grd.addColorStop(1, color2.toStyleString());

        ctx.fillStyle = grd;
        ctx.fillRect(0, 0, canvas.width, canvas.height);
    }


    //anything not transparent becomes a shade
    static void swapColors(CanvasElement canvas, Colour newc) {
        CanvasRenderingContext2D ctx = canvas.getContext('2d');
        ImageData img_data = ctx.getImageData(0, 0, canvas.width, canvas.height);
        //4 byte color array
        for (int i = 0; i < img_data.data.length; i += 4) {
            if (img_data.data[i + 3] > 100) {
                Colour replacementColor = new Colour(img_data.data[i],img_data.data[i + 1],img_data.data[i + 2],img_data.data[i + 3]);
                double value = 0.0;
                //keep black lines black, but otherwise let them somewhat pick their own brightness.
                if(replacementColor.value != 0.0)  value = (replacementColor.value + newc.value)/2;
                replacementColor.setHSV(newc.hue, newc.saturation, value);
                img_data.data[i] = replacementColor.red;
                img_data.data[i + 1] = replacementColor.green;
                img_data.data[i + 2] = replacementColor.blue;
                //img_data.data[i + 3] = alpha;
            }
        }
        ctx.putImageData(img_data, 0, 0);
    }


    static void drawWhatever(CanvasElement canvas, String imageString) {
        print("Trying to draw $imageString");
        Loader.getResource(imageString).then((ImageElement loaded) {
            print("image $loaded loaded");
            canvas.context2D.imageSmoothingEnabled = false;
            canvas.context2D.drawImage(loaded, 0, 0);
        });

    }

    static Future<bool>  drawWhateverFuture(CanvasElement canvas, String imageString) async {
        ImageElement image = await Loader.getResource((imageString));
        //print("got image $image");
        canvas.context2D.imageSmoothingEnabled = false;
        canvas.context2D.drawImage(image, 0, 0);
        return true;
    }

    static Future<bool>  drawExistingElementFuture(CanvasElement canvas, ImageElement image) async {
        //print("got image $image");
        canvas.context2D.imageSmoothingEnabled = false;
        canvas.context2D.drawImage(image, 0, 0);
        return true;
    }

    static ImageElement imageSelector(String path) {
        return querySelector("#${escapeId(path)}");
    }

    static String escapeId(String toEscape) {
        return toEscape.replaceAll(new RegExp(r"\.|\/"),"_");
    }

    static void clearCanvas(CanvasElement canvas) {
        CanvasRenderingContext2D ctx = canvas.context2D;
        ctx.clearRect(0, 0, canvas.width, canvas.height);
    }

    static void loadHomestuckDollParts(HomestuckDoll doll, dynamic callback) {

        for(int i = 0; i<=doll.maxBody; i++) {
            loadImage("${doll.folder}/Body/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxMouth; i++) {
            loadImage("${doll.folder}/Mouth/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxSymbol; i++) {
            loadImage("${doll.folder}/Symbol/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxHair; i++) {
            loadImage("${doll.folder}/HairTop/$i.png", callback);
            loadImage("${doll.folder}/HairBack/$i.png", callback);

        }


        for(int i = 0; i<=doll.maxEye; i++) {
            loadImage("${doll.folder}/LeftEye/$i.png", callback);
            loadImage("${doll.folder}/RightEye/$i.png", callback);
        }
    }

    static void loadHomestuckTrollDollParts(HomestuckTrollDoll doll, dynamic callback) {

        for(int i = 0; i<=doll.maxBody; i++) {
            loadImage("${doll.folder}/Body/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxMouth; i++) {
            loadImage("${doll.folder}/Mouth/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxWing; i++) {
            loadImage("${doll.folder}/Wings/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxSymbol; i++) {
            loadImage("${doll.folder}/Symbol/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxHair; i++) {
            loadImage("${doll.folder}/HairTop/$i.png", callback);
            loadImage("${doll.folder}/HairBack/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxHorn; i++) {
            loadImage("${doll.folder}/LeftHorn/$i.png", callback);
            loadImage("${doll.folder}/RightHorn/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxFin; i++) {
            loadImage("${doll.folder}/LeftFin/$i.png", callback);
            loadImage("${doll.folder}/RightFin/$i.png", callback);
        }


        for(int i = 0; i<=doll.maxEye; i++) {
            loadImage("${doll.folder}/LeftEye/$i.png", callback);
            loadImage("${doll.folder}/RightEye/$i.png", callback);
        }
    }

    static void loadImage(String img, dynamic callback) {
        ////print(img);
        imagesWaiting ++;
        ImageElement imageObj = new ImageElement();
        imageObj.onLoad.listen((Event e) {
            //  context.drawImage(imageObj, 69, 50); //i don't want to draw it. i could put it in image staging?
            addImageTagLoading(img);
            imagesLoaded ++;
            checkDone(callback);
        });

        imageObj.onError.listen((Event e){
            querySelector("#loading_stats").appendHtml("Error loading image: " + imageObj.src);
            print("Error loading image: " + imageObj.src);
        });
        imageObj.src = "images/"+img;
    }

    static void checkDone(dynamic callback){
        if(querySelector("#loading_stats") != null) querySelector("#loading_stats").text = ("Images Loaded: $imagesLoaded");
        if((imagesLoaded != 0 && imagesWaiting == imagesLoaded)){
            callback();
        }
    }

    static CanvasElement cropToVisible(CanvasElement canvas) {
        int leftMostX = canvas.width; //if i find a pixel with an x value smaler than this, it is now leftMostX
        int rightMostX = 0; //if i find a pixel with an x value bigger than this, it is not rightMost X
        //or is it the other way around?
        int topMostY = canvas.height;
        int bottomMostY = 0;

        ImageData img_data = canvas.context2D.getImageData(0, 0, canvas.width, canvas.height);

        for(int x = 0; x<canvas.width; x ++) {
            for(int y = 0; y<canvas.height; y++) {
                int i = (y * canvas.width + x) * 4;
                if(img_data.data[i+3] >100) {
                    if(x < leftMostX) leftMostX = x;
                    if(x > rightMostX) rightMostX = x;
                    if(y > bottomMostY) bottomMostY = y;
                    if(y < topMostY) topMostY = y;
                }
            }

        }

        return cropToCoordinates(canvas, leftMostX, rightMostX, topMostY, bottomMostY);

    }

    //https://stackoverflow.com/questions/45866873/cropping-an-html-canvas-to-the-width-height-of-its-visible-pixels-content
    static CanvasElement cropToCoordinates(CanvasElement canvas, int leftMostX, int rightMostX, int topMostY, int bottomMostY) {
        int width = rightMostX - leftMostX;
        int height = bottomMostY - topMostY;
        //print("old width is ${canvas.width} x is $leftMostX right x is $rightMostX width is: $width, height is $height");
        CanvasElement ret = new CanvasElement(width: width, height: height);
        ret.context2D.drawImageToRect(canvas,new Rectangle(0,0,width,height), sourceRect: new Rectangle(leftMostX,topMostY,width,height));
        return ret;
    }



    static void addImageTagLoading(url){
        ////print(url);
        //only do it if image hasn't already been added.
        if(querySelector("#${escapeId(url)}") == null) {
            ////print("I couldn't find a document with id of: " + url);
            String tag = '<img id="' + escapeId(url) + '" src = "images/' + url + '" class="loadedimg">';
            //var urlID = urlToID(url);
            //String tag = '<img id ="' + urlID + '" src = "' + url + '" style="display:none">';
            querySelector("#loading_image_staging").appendHtml(tag,treeSanitizer: NodeTreeSanitizer.trusted);
        }else{
            ////print("I thought i found a document with id of: " + url);

        }

    }


    static int simulateWrapTextToGetFontSize(CanvasRenderingContext2D ctx, String text, num x, num y, num lineHeight, int maxWidth, int maxHeight) {
        List<String> words = text.split(' ');
        List<String> lines = <String>[];
        int sliceFrom = 0;
        for (int i = 0; i < words.length; i++) {
            String chunk = words.sublist(sliceFrom, i).join(' ');
            bool last = i == words.length - 1;
            bool bigger = ctx
                .measureText(chunk)
                .width > maxWidth;
            if (bigger) {
                lines.add(words.sublist(sliceFrom, i).join(' '));
                sliceFrom = i;
            }
            if (last) {
                lines.add(words.sublist(sliceFrom, words.length).join(' '));
                sliceFrom = i;
            }
        }
        //need to return how many lines i created so that whatever called me knows where to put ITS next line.;
        return lines.length;

    }


    //http://stackoverflow.com/questions/5026961/html5-canvas-ctx-filltext-wont-do-line-breaks
    static int wrap_text(CanvasRenderingContext2D ctx, String text, num x, num y, num lineHeight, int maxWidth, String textAlign) {
        if (textAlign == null) textAlign = 'center';
        ctx.textAlign = textAlign;
        List<String> words = text.split(' ');
        List<String> lines = <String>[];
        int sliceFrom = 0;
        for (int i = 0; i < words.length; i++) {
            String chunk = words.sublist(sliceFrom, i).join(' ');
            bool last = i == words.length - 1;
            bool bigger = ctx
                .measureText(chunk)
                .width > maxWidth;
            if (bigger) {
                lines.add(words.sublist(sliceFrom, i).join(' '));
                sliceFrom = i;
            }
            if (last) {
                lines.add(words.sublist(sliceFrom, words.length).join(' '));
                sliceFrom = i;
            }
        }
        num offsetY = 0.0;
        num offsetX = 0;
        if (textAlign == 'center') offsetX = maxWidth ~/ 2;
        for (int i = 0; i < lines.length; i++) {
            ctx.fillText(lines[i], x + offsetX, y + offsetY);
            offsetY = offsetY + lineHeight;
        }
        //need to return how many lines i created so that whatever called me knows where to put ITS next line.;
        return lines.length;
    }


}


class Size2D {
    int width;
    int height;

    Size2D(int this.width, int this.height);

}