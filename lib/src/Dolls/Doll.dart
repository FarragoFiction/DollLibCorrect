import "SpriteLayer.dart";
import "dart:typed_data";
import "dart:html";
import 'dart:convert';
import 'dart:async';
import 'package:RenderingLib/RendereringLib.dart';

import "../../DollRenderer.dart";
abstract class Doll {
    //things can optionally cause the doll's orientation to change, like grub body 7 and 8
    static String NORMALWAYS = "normalways"; //flipped horizontal
    static String TURNWAYS = "turnways"; //flipped horizontal
    static String TURNWAYSBUTUP = "turnwaysFlipped"; //flipped horizontal and vertical
    static String UPWAYS = "upways"; //flipped vertical


    String folder;
    String orientation = NORMALWAYS;
    Colour _associatedColor;
    int width = 400;
    int height = 300;
    int renderingType = 0;
    static String localStorageKey = "doll";

    List<Palette> get validPalettes => <Palette>[];
    Map<String, Palette> get validPalettesMap =>new  Map<String, Palette>();


    //IMPORTANT  if i want save strings to not break if new rendering order, then rendering order and load order must be different things.

    ///in rendering order.
    List<SpriteLayer>  get renderingOrderLayers => new List<SpriteLayer>();
    //what order do we save load these. things humans have first, then trolls, then new layers so you don't break save data strings
    List<SpriteLayer>  get dataOrderLayers => new List<SpriteLayer>();

    Palette palette;

    Palette paletteSource = ReferenceColours.SPRITE_PALETTE;

    Colour get associatedColor {
        if(_associatedColor == null) {
            if(palette is HomestuckPalette || palette is HomestuckTrollPalette) {
                _associatedColor = (palette as HomestuckPalette).aspect_light;
            }else {
                _associatedColor = palette.first;
            }
        }
        return _associatedColor;
    }

    //does nothing by default
    void setUpWays() {

    }


    void initLayers();
    void randomize() {
        randomizeColors();
        randomizeNotColors();
    }

    static Doll convertOneDollToAnother(Doll source, Doll replacement) {
        for(SpriteLayer sourceLayer in source.renderingOrderLayers) {
            for(SpriteLayer replacementLayer in replacement.renderingOrderLayers) {
                if(sourceLayer.imgNameBase == replacementLayer.imgNameBase) {
                    replacementLayer.imgNumber = sourceLayer.imgNumber;
                }
            }
        }
        List<String> keysToReplace = new List<String>();

        for(String sourceName in source.palette.names) {
            for (String replacementName in replacement.palette.names) {
                if (sourceName == replacementName) {
                    keysToReplace.add(sourceName);
                }
            }
        }

        for(String key in keysToReplace) {
            replacement.palette.add(key, source.palette[key], true);
        }
        return replacement;
    }

    void randomizeColors() {
        Random rand = new Random();
        List<String> names = new List<String>.from(palette.names);
        for(String name in names) {
            palette.add(name, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        }
    }

    void randomizeNotColors() {
        Random rand = new Random();
        int firstEye = -100;
        for(SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber+1);
            //keep eyes synced unless player decides otherwise
            if(firstEye > 0 && l.imgNameBase.contains("Eye")) l.imgNumber = firstEye;
            if(firstEye < 0 && l.imgNameBase.contains("Eye")) firstEye = l.imgNumber;
            if(l.imgNumber == 0) l.imgNumber = 1;
            if(l.imgNameBase.contains("Glasses") && rand.nextDouble() > 0.35) l.imgNumber = 0;
        }
    }

    void save() {
        int id = Doll.getFirstFreeID();
        window.localStorage["${Doll.localStorageKey}$id"] = toDataBytesX();
        window.alert("Saved Doll $id!");
    }

    static int getFirstFreeID() {
        //fuck you if you want to store more than 1k dolls.
        for(int i = 0; i<255; i++) {
            if(!window.localStorage.containsKey("${Doll.localStorageKey}$i")) return i;
        }
    }

    void copyPalette(Palette newP) {
        for(String name in newP.names) {
            palette.add(name, newP[name], true);
        }
    }

    void load(String dataString) {
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte(); //not gonna use, but needs to be gone for reader
        initFromReader(reader, new Palette(), false);
    }

    //i am assuming type was already read at this point. Type, Exo is required.
    void initFromReader(ByteReader reader, Palette newP, [bool layersNeedInit = true]) {
        if(layersNeedInit) {
            //print("initalizing layers");
            initLayers();
        }
        int numFeatures = reader.readExpGolomb();
        //print("I think there are ${numFeatures} features");
        int featuresRead = 2; //for exo and doll type

        List<String> names = new List<String>.from(palette.names);
        names.sort();
        for(String name in names) {
            featuresRead +=1;
            Colour newColor = new Colour(reader.readByte(),reader.readByte(),reader.readByte());
            newP.add(name, newColor, true);
        }

        for(String name in newP.names) {
            //print("loading color $name");
            palette.add(name, newP[name], true);
        }

        //layer is last so can add new layers.
        for(SpriteLayer l in dataOrderLayers) {
            //older strings with less layers
            //print("layer ${l.name}, features read is $featuresRead and num features is $numFeatures");

            //<= is CORRECT DO NOT FUCKING CHANGE IT OR THE LAST LAYER WILL GET EATEN. ALSO: Fuck you, i don't know why i have to have a try catch in there since that if statement SHOULD mean only try to read if there's more to read but what fucking ever it works.
            if(featuresRead <= numFeatures) {
                try {
                    l.loadFromReader(reader); //handles knowing if it's 1 or more bytes
                }catch(exception, stackTrace) {
                    //print("exo said I have $numFeatures and i've only read $featuresRead, but still can't read (${l.name}) for some reason. this is a caught error");
                    l.imgNumber = 0; //don't have.
                }
                //l.imgNumber = reader.readByte();
            }else {
               // print("skipping a feature (${l.name}) i don't have in string");
                l.imgNumber = 0; //don't have.
            }
           // print("loading layer ${l.name}. Value: ${l.imgNumber} bytesRead: $featuresRead  numFeatures: $numFeatures");
            if(l.imgNumber > l.maxImageNumber) l.imgNumber = 0;
            featuresRead += 1;

        }
    }


    void setPalette(Palette chosen) {
        for(String name in chosen.names) {
            palette.add(name, chosen[name],true);
        }
    }



    String toDataBytesX([ByteBuilder builder = null]) {
        //("saving to data bytes x");
        if(builder == null) builder = new ByteBuilder();
        int length = palette.names.length + 1;//one byte for doll type

        for(SpriteLayer layer in dataOrderLayers) {
            length += layer.numbytes;
        }
        builder.appendByte(renderingType); //value of 1 means homestuck doll
        builder.appendExpGolomb(length); //for length


        List<String> names = new List<String>.from(palette.names);
        names.sort();
        for(String name in names) {
            Colour color = palette[name];
            builder.appendByte(color.red);
            builder.appendByte(color.green);
            builder.appendByte(color.blue);
        }

        //layer is last so can add new layers
        for(SpriteLayer l in dataOrderLayers) {
           // print("adding ${l.name}  with value ${l.imgNumber} to data string builder.");
            l.saveToBuilder(builder);
            //builder.appendByte(l.imgNumber);
        }

        return BASE64URL.encode(builder.toBuffer().asUint8List());
    }

    //if it's in url form, it has a ? right before the text.
    static String removeURLFromString(String ds) {
        List<String> ret = ds.split("?");
        if(ret.length == 1) return ret[0];
        return ret[1];
    }


    /* first part of any data string tells me what type of doll to load.*/
    static Doll loadSpecificDoll(String ds) {
        String dataString = removeURLFromString(ds);
       // print("dataString is $dataString");
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        int type = reader.readByte();
       // print("type is $type");

        if(type == new HomestuckDoll().renderingType) {
            return new HomestuckDoll.fromReader(reader);
        }

        if(type == new HomestuckSatyrDoll().renderingType) {
            return new HomestuckSatyrDoll.fromReader(reader);
        }

        if(type == new HiveswapDoll().renderingType) {
            return new HiveswapDoll.fromReader(reader);
        }

        if(type == new PigeonDoll().renderingType) {
            return new PigeonDoll.fromReader(reader);
        }

        if(type == new HomestuckTrollDoll().renderingType) {
            return new HomestuckTrollDoll.fromReader(reader);
        }

        if(type == new ConsortDoll().renderingType) {
            return new ConsortDoll.fromReader(reader);
        }

        if(type == new HiveswapDoll().renderingType) {
            return new HiveswapDoll.fromReader(reader);
        }

        if(type == new DenizenDoll().renderingType) {
            return new DenizenDoll.fromReader(reader);
        }

        if(type == new DadDoll().renderingType) {
            return new DadDoll.fromReader(reader);
        }

        if(type == new SuperbSuckDoll().renderingType) {
            return new SuperbSuckDoll.fromReader(reader);
        }

        if(type == new QueenDoll().renderingType) {
            return new QueenDoll.fromReader(reader);
        }

        if(type == new MomDoll().renderingType) {
            return new MomDoll.fromReader(reader);
        }

        if(type == new BroDoll().renderingType) {
            return new BroDoll.fromReader(reader);
        }

        if(type == new HomestuckBabyDoll().renderingType) {
            return new HomestuckBabyDoll.fromReader(reader);
        }

        if(type == new HomestuckGrubDoll().renderingType) {
            return new HomestuckGrubDoll.fromReader(reader);
        }

        if(type == new MonsterPocketDoll().renderingType) {
            return new MonsterPocketDoll.fromReader(reader);
        }
    }

    /* first part of any data string tells me what type of doll to load.*/
    static Doll randomDollOfType(int type) {

        if(type == new HomestuckDoll().renderingType) {
            return new HomestuckDoll();
        }

        if(type == new HomestuckTrollDoll().renderingType) {
            return new HomestuckTrollDoll();
        }

        if(type == new HomestuckSatyrDoll().renderingType) {
            return new HomestuckSatyrDoll();
        }

        if(type == new HiveswapDoll().renderingType) {
            return new HiveswapDoll();
        }


        if(type == new ConsortDoll().renderingType) {
            return new ConsortDoll();
        }

        if(type == new DenizenDoll().renderingType) {
            return new DenizenDoll();
        }

        if(type == new DadDoll().renderingType) {
            return new DadDoll();
        }

        if(type == new QueenDoll().renderingType) {
            return new QueenDoll();
        }

        if(type == new PigeonDoll().renderingType) {
            return new PigeonDoll();
        }

        if(type == new MomDoll().renderingType) {
            return new MomDoll();
        }

        if(type == new SuperbSuckDoll().renderingType) {
            return new SuperbSuckDoll();
        }

        if(type == new BroDoll().renderingType) {
            return new BroDoll();
        }

        if(type == new HomestuckBabyDoll().renderingType) {
            return new HomestuckBabyDoll();
        }

        if(type == new HomestuckGrubDoll().renderingType) {
            return new HomestuckGrubDoll();
        }

        if(type == new MonsterPocketDoll().renderingType) {
            return new MonsterPocketDoll();
        }
    }

    static List<SavedDoll> loadAllFromLocalStorage() {
        int last = 255; //don't care about first ree id cuz they can be deleted.
        List<SavedDoll> ret = new List<SavedDoll>();
        for(int i = 0; i< last; i++) {
            String dataString = window.localStorage["${Doll.localStorageKey}$i"];

            if(dataString != null) {
                Doll doll = loadSpecificDoll(dataString);
                ret.add(new SavedDoll(doll,i));
            }
        }
        return ret;
    }

    static Doll makeRandomDoll()  {
        Random rand = new Random();
        WeightedList<Doll> dolls = new WeightedList<Doll>();
        dolls.add(new HomestuckDoll());
        dolls.add(new HomestuckTrollDoll());
        dolls.add(new ConsortDoll(),0.3);
        dolls.add(new DenizenDoll(),0.3);
        dolls.add(new QueenDoll(),0.3);
        dolls.add(new EggDoll(),0.05);
        dolls.add(new TrollEggDoll(), 0.05);
        dolls.add(new HomestuckBabyDoll(),0.1);
        dolls.add(new HomestuckGrubDoll(), 0.1);
        dolls.add(new DadDoll(),0.3);
        dolls.add(new BroDoll(),0.3);
        dolls.add(new MomDoll(),0.3);
        //return new BroDoll(); //hardcoded for testing
        return rand.pickFrom(dolls);
    }


}





class SavedDoll {
    Doll doll;
    int id;
    CanvasElement canvas;
    TextAreaElement textAreaElement;

    SavedDoll(this.doll, this.id) {

    }

    void drawSelf(Element container, dynamic refreshMethod) {
        Element bluh = new DivElement();
        bluh.style.display = "inline-block";
        container.append(bluh);
        renderSelfToContainer(bluh);
        renderDataUrlToContainer(bluh, refreshMethod);
    }


    Future<Null> renderSelfToContainer(Element container) async {
        canvas = new CanvasElement(width: doll.width, height: doll.height);
        container.append(canvas);
        DollRenderer.drawDoll(canvas, doll);
    }

    Future<Null> renderDataUrlToContainer(Element container, dynamic refreshMethod) async {
        Element bluh = new DivElement();
        container.append(bluh);
        textAreaElement = new TextAreaElement();
        textAreaElement.setInnerHtml(doll.toDataBytesX());
        bluh.append(textAreaElement);

        ButtonElement copyButton = new ButtonElement();
        bluh.append(copyButton);
        copyButton.setInnerHtml("Copy Doll $id");
        copyButton.onClick.listen((Event e) {
            textAreaElement.select();
            document.execCommand('copy');
        });

        ButtonElement deleteButton = new ButtonElement();
        bluh.append(deleteButton);
        deleteButton.setInnerHtml("Delete Doll $id");
        deleteButton.onClick.listen((Event e) {
            if(window.confirm("Are you sure you want to delete it???")) {
                window.localStorage.remove("${Doll.localStorageKey}$id");
                refreshMethod();
            }
        });

        AnchorElement a = new AnchorElement();
        a.href = "index.html?${doll.toDataBytesX()}";
        a.target = "_blank";
        a.text = "Edit Doll Link";
        bluh.append(a);
    }




}