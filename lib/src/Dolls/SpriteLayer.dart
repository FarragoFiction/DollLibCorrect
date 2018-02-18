import 'package:RenderingLib/RendereringLib.dart';
import 'dart:convert';
import "dart:typed_data";
import "dart:html";


typedef void JROnClick();

//one byte of data
class SpriteLayer {

    //if this isn't set will throw an error if you try to have multiple bytes
    bool supportsMultiByte = false;
    int numbytes = 1; //hardcoded to be 1 for this layer type
    String imgFormat;
    String imgNameBase;
    String name;
    int _imgNumber;
    int maxImageNumber;
    //used for testing layers that aren't yet part of the sim
    ImageElement preloadedElement;
    String description = "";
    //slaves just match whatever another thingy tells them to do.
    bool slave = false;
    List<SpriteLayer> syncedWith; //for things like hair where they should always match.

    bool changed = true; //generate descriptions when created, that will set it to false

    SpriteLayer(this.name, this.imgNameBase, this._imgNumber, this.maxImageNumber, {this.supportsMultiByte = false, this.syncedWith:null, this.imgFormat:"png"}) {
        numbytes = (maxImageNumber/255).ceil();
        if(syncedWith == null) syncedWith = new List<SpriteLayer>();
    }

    String get imgLocation {
        return "$imgNameBase${imgNumber}.${imgFormat}";
    }

    @override
    String toString() {
        return name;
    }

    void saveToBuilder(ByteBuilder builder) {
        if(numbytes == 1 || numbytes == 0) {
            builder.appendByte(imgNumber);
        }else if(!supportsMultiByte) {
            //should first write the exo, then the numberm
            throw("not  supported for ${numbytes} bytes, max is ${maxImageNumber} is invalid");
        }else {
            //first step, convert 4 byte signed integer into byte array
            //then store number of bytes, chopping off any excess beyond numBytes
            //v2: can store shorts and can store ints.
            if(numbytes == 2) {
                builder.appendShort(imgNumber);

            }else {
                builder.appendInt32(imgNumber);
            }
        }
    }

    void randomize() {
        Random rand  = new Random();
        imgNumber = rand.nextInt(maxImageNumber);
        for(SpriteLayer l in syncedWith) {
            l.imgNumber = imgNumber;
        }
    }

    void loadFromReader(ByteReader reader) {
        if(numbytes == 1 || numbytes == 0) {
            imgNumber = reader.readByte();
        }else if(!supportsMultiByte) {
            throw("not  supported for ${numbytes} bytes, max is ${maxImageNumber} is invalid");
        }else {
            if(numbytes == 2) {
                imgNumber = reader.readShort();
            }else {
                imgNumber = reader.readInt32();
            }
        }
    }



    int get imgNumber {
        return _imgNumber;
    }

    //so i know to update the description
    void set imgNumber(int i) {
        _imgNumber = i;
        changed = true;
        //things like hair top/back
        for(SpriteLayer l in syncedWith) {
            if(l.imgNumber != i) l.imgNumber = i; //no infinite loops, dunkass
        }
    }

}
