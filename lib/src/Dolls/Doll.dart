import 'package:DollLibCorrect/src/Dolls/Layers/DynamicLayer.dart';
import "package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart";
import "dart:typed_data";
import "dart:html";
import 'dart:convert';
import 'dart:async';

import "../../DollRenderer.dart";

import 'package:RenderingLib/src/Misc/weighted_lists.dart';
import 'package:RenderingLib/src/includes/bytebuilder.dart'as OldByteBuilder;
abstract class Doll {
    static String labelPattern = ":___";
    //whatever calls me is responsible for deciding if it wants to be url encoded or not
    String get label => "$dollName$labelPattern";

    //useful for the builder
    static List<int> allDollTypes = <int>[1,2,16,12,13,3,4,7,9,10,14,113,15,8,151,17,18,19,20,41,42,22,23,25,27,21,28,34,35];


    static Map<int, Doll> get  allDollsMappedByType {
        Map<int, Doll> ret = new Map<int, Doll>();
            for(Doll doll in allDollsEvenWIPS) {
                ret[doll.renderingType]= doll;
            }
        return ret;
    }

    static List<Doll> cachedAllDolls = new List<Doll>();

    static List<Doll> get allDollsEvenWIPS {
        //never cache this
        //okay so like, past jr SAYS that, but now that i have tree dolls caching makes a LOT of sense.
        //except that makes it crash so whatever, uncache for now
        cachedAllDolls.clear();
        if(cachedAllDolls.isEmpty) {
            //passing true means the tree doll won't try to make any fruit, which would let it accidentally recurse if its fruit were a random doll
            cachedAllDolls.add(new TreeDoll());
            cachedAllDolls.add(new LeafDoll());
            cachedAllDolls.add(new FlowerDoll());
            cachedAllDolls.add(new FruitDoll());
            cachedAllDolls.add(new AncestorDoll());
            cachedAllDolls.add(new FekDoll());
            cachedAllDolls.add(new BlobMonsterDoll());
            cachedAllDolls.add(new BroDoll());
            cachedAllDolls.add(new BroomDoll());
            cachedAllDolls.add(new CatDoll());
            cachedAllDolls.add(new ConsortDoll());
            cachedAllDolls.add(new DadDoll());
            cachedAllDolls.add(new DenizenDoll());
            cachedAllDolls.add(new DocDoll());
            cachedAllDolls.add(new DogDoll());
            cachedAllDolls.add(new EasterEggDoll());
            cachedAllDolls.add(new EggDoll());
            cachedAllDolls.add(new HatchedChick());
            cachedAllDolls.add(new HiveswapDoll());
            cachedAllDolls.add(new HomestuckBabyDoll());
            cachedAllDolls.add(new HomestuckCherubDoll());
            cachedAllDolls.add(new HomestuckDoll());
            cachedAllDolls.add(new HomestuckGrubDoll());
            cachedAllDolls.add(new HomestuckHeroDoll());
            cachedAllDolls.add(new HomestuckSatyrDoll());
            cachedAllDolls.add(new HomestuckTrollDoll());
            cachedAllDolls.add(new MomDoll());
            cachedAllDolls.add(new MonsterPocketDoll());
            cachedAllDolls.add(new OpenBoundDoll());
            cachedAllDolls.add(new PigeonDoll());
            cachedAllDolls.add(new PupperDoll());
            cachedAllDolls.add(new QueenDoll());
            cachedAllDolls.add(new SuperbSuckDoll());
            cachedAllDolls.add(new TalkSpriteDoll());
            cachedAllDolls.add(new TrollEggDoll());
            cachedAllDolls.add(new VirusDoll());
        }
        return cachedAllDolls;
    }

    String originalCreator = "???";

    //in case i want controlled random
    Random rand = new Random();

    Quirk quirkButDontUse;

    String name = "Unknown";
    //used for labeling and things like rom sim
    String dollName = "";

    //things can optionally cause the doll's orientation to change, like grub body 7 and 8
    static int NORMALWAYS = 0; //flipped horizontal
    //is this not working? turnways is fighting me
    static int TURNWAYS = 1; //flipped horizontal
    static int TURNWAYSBUTUP = 2; //flipped horizontal and vertical
    static int UPWAYS = 3; //flipped vertical

    bool useAbsolutePath = true;

    int get seed {
        int s = associatedColor.red + associatedColor.green + associatedColor.blue;
        //print("getting seed, colors added up is $s");
        for(SpriteLayer imageLayer in renderingOrderLayers) {
            //print('rendering layer ${imageLayer.imgNumber}');
            s += imageLayer.imgNumber;
        }
       // print("colors and layers added up is $s");
        return s;
    }

    Quirk get quirk {
        if(quirkButDontUse == null) {
            setQuirk();
        }
        return quirkButDontUse;
    }


    String relativefolder;
    String absolutePathStart = "/DollSource/";

    String get folder {
        if(useAbsolutePath) {
            return "$absolutePathStart$relativefolder";
        }else {
            return relativefolder;
        }
    }


    int orientation = NORMALWAYS;

    // in degrees, things like 0, 90, 180, etc. used for auto rendering
    int rotation = 0;

    int width;
    int height;
    int renderingType = 0;
    static String localStorageKey = "doll";

    List<Palette> get validPalettes => <Palette>[];
    Map<String, Palette> get validPalettesMap =>new  Map<String, Palette>();


    //IMPORTANT  if i want save strings to not break if new rendering order, then rendering order and load order must be different things.

    ///in rendering order.
    List<SpriteLayer>  get renderingOrderLayers => new List<SpriteLayer>();
    //what order do we save load these. things humans have first, then trolls, then new layers so you don't break save data strings
    List<SpriteLayer>  get dataOrderLayers => new List<SpriteLayer>();
    List<SpriteLayer>  get oldDataLayers => dataOrderLayers; //if i change shit for a specific doll (like homestuck) go here


    Palette palette;

    Palette paletteSource = ReferenceColours.SPRITE_PALETTE;

    //i used to cache it here, but no longer. because if i cache it, it won't respond to color changes
    Colour get associatedColor {

        if(palette is HomestuckPalette || palette is HomestuckTrollPalette) {
            return  (palette as HomestuckPalette).aspect_light;
        }else {
            return  palette.first;
        }
    }

    Doll() {
        if(window.location.hostname.contains("localhost")) {
            useAbsolutePath = false;
             //absolutePathStart = "http://www.farragofiction.com/DollSource/";
        }

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
        if(source is HomestuckDoll && replacement is HomestuckDoll) {
            HomestuckDoll r = replacement as HomestuckDoll;
            HomestuckDoll s = source as HomestuckDoll;
            //print("before replacement source hair is ${s.extendedHairBack.imgNumber} and replacement hair is ${r.extendedHairBack.imgNumber}");
        }
        for(SpriteLayer sourceLayer in source.dataOrderLayers) {
            for(SpriteLayer replacementLayer in replacement.dataOrderLayers) {
                //don't compare imgNameBase since it'll be diff on local vs remote apparently
                if(sourceLayer.name == replacementLayer.name) {
                    //print("${sourceLayer.imgNameBase} is ${replacementLayer.imgNameBase}");
                    //even if similar doll typesp might have different maxes
                    replacementLayer.imgNumber = sourceLayer.imgNumber % (replacementLayer.maxImageNumber+1);
                }else {
                    //print("${sourceLayer.imgNameBase} is not ${replacementLayer.imgNameBase}");
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

        if(source is HomestuckDoll && replacement is HomestuckDoll) {
            HomestuckDoll r = replacement as HomestuckDoll;
            HomestuckDoll s = source as HomestuckDoll;
            //print("after replacement source hair is ${s.extendedHairBack.imgNumber} and replacement hair is ${r.extendedHairBack.imgNumber}");
        }
        return replacement;
    }

    void makeOtherColorsDarker(Palette p, String sourceKey, List<String> otherColorKeys) {
        String referenceKey = sourceKey;
        //print("$name, is going to make other colors darker than $sourceKey, which is ${p[referenceKey]}");
        for(String key in otherColorKeys) {
            //print("$name is going to make $key darker than $sourceKey");
            p.add(key, new Colour(p[referenceKey].red, p[referenceKey].green, p[referenceKey].blue)..setHSV(p[referenceKey].hue, p[referenceKey].saturation, 2*p[referenceKey].value / 3), true);
            //print("$name made  $key darker than $referenceKey, its ${p[key]}");

            referenceKey = key; //each one is progressively darker
        }
    }

    void randomizeColors() {
        List<String> names = new List<String>.from(palette.names);
        for(String name in names) {
            palette.add(name, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        }
    }

    void setQuirk() {
        Random rand  = new Random(seed);
        quirkButDontUse = Quirk.randomHumanQuirk(rand);
    }

    void randomizeNotColors() {
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

    List<String> getAllNeededDirectories() {
        List<String> ret = new List<String>();
        for(SpriteLayer layer in dataOrderLayers) {
            ret.add(layer.imgNameBase);
        }
        return ret;
    }



    void save() {
        int id = Doll.getFirstFreeID();
        window.localStorage["${Doll.localStorageKey}$id"] = toDataBytesX();
        //window.alert("Saved Doll $id!");
    }

    static Doll andAlchemizeDolls(List<Doll> dolls) {
        Random rand = new Random();
        Doll ret = Doll.randomDollOfType(rand.pickFrom(dolls).renderingType);
        dolls.removeWhere((Doll doll) => doll is NamedLayerDoll);
        for(Doll d in dolls) {
            for(int i = 0; i<ret.renderingOrderLayers.length; i++) {
                SpriteLayer mine = ret.renderingOrderLayers[i];
                SpriteLayer yours;
                if(d.renderingOrderLayers.length > i) yours = d.renderingOrderLayers[i];
                if(yours != null) {
                    //print("my ${mine} was ${mine.imgNumber}, your ${yours} was ${yours.imgNumber}, them together is ${mine.imgNumber & yours.imgNumber}");
                    int max = mine.maxImageNumber;
                    if(max == 0) max = 1;
                    mine.imgNumber = (mine.imgNumber & yours.imgNumber) % max;
                    //print("mine after alchemy is ${mine.imgNumber}");
                }
            }

            for(int i = 0; i<ret.palette.length; i++) {
                Colour mine = ret.palette[i];
                Colour yours;
                if(d.palette.length > i) yours = d.palette[i];
                if(yours != null) {
                    mine.red = (mine.red & yours.red) % 256;
                    mine.green = (mine.green & yours.green) % 256;
                    mine.blue = (mine.blue & yours.blue) % 256;
                }
            }
        }
        return ret;
    }

    static Doll orAlchemizeDolls(List<Doll> dolls) {
        dolls.removeWhere((Doll doll) => doll is NamedLayerDoll);
        Random rand = new Random();
        Doll ret = Doll.randomDollOfType(rand.pickFrom(dolls).renderingType);
        for(Doll d in dolls) {
            for(int i = 0; i<ret.renderingOrderLayers.length; i++) {
                SpriteLayer mine = ret.renderingOrderLayers[i];
                SpriteLayer yours;
                if(d.renderingOrderLayers.length > i) yours = d.renderingOrderLayers[i];
                if(yours != null) {
                    //print("my ${mine} was ${mine.imgNumber}, your ${yours} was ${yours.imgNumber}, them together is ${mine.imgNumber & yours.imgNumber}");
                    int max = mine.maxImageNumber;
                    if(max == 0) max = 1;
                    mine.imgNumber = (mine.imgNumber | yours.imgNumber) % max;
                    //print("mine after alchemy is ${mine.imgNumber}");

                }
            }

            for(int i = 0; i<ret.palette.length; i++) {
                Colour mine = ret.palette[i];
                Colour yours;
                if(d.palette.length > i) yours = d.palette[i];
                if(yours != null) {
                    mine.red = (mine.red | yours.red) % 256;
                    mine.green = (mine.green | yours.green) % 256;
                    mine.blue = (mine.blue | yours.blue) % 256;
                }
            }
        }
        return ret;
    }

    //set things like subdolls
    void afterBreeding(List<Doll> dolls) {
        //dolls only do this if needed.
    }

    Future<CanvasElement> getNewCanvas([bool testTime = false]) async {
        CanvasElement newCanvas = new CanvasElement(width: width, height: height);
        await DollRenderer.drawDoll(newCanvas, this, false, testTime);
        return newCanvas;
    }


    //before pl's color swap updates to make them faster
    Future<CanvasElement> getNewCanvasLegacy([bool testTime = false]) async {
        CanvasElement newCanvas = new CanvasElement(width: width, height: height);
        await DollRenderer.drawDoll(newCanvas, this,true, testTime);
        return newCanvas;
    }

    static Doll breedDolls(List<Doll> dolls) {
        dolls.removeWhere((Doll doll) => doll is NamedLayerDoll);
        Random rand = new Random();
        int firstEye = -113;
        Doll ret = Doll.randomDollOfType(rand.pickFrom(dolls).renderingType);
            for(int i = 0; i<ret.dataOrderLayers.length; i++) {
                SpriteLayer mine = ret.dataOrderLayers[i];
                //decide what to do with dynamics in individual dollsets
                if(!(mine is DynamicLayer)) {
                    Doll d = rand.pickFrom(dolls);
                    SpriteLayer yours;
                    if (d.dataOrderLayers.length > i)
                        yours = d.dataOrderLayers[i];
                    //for each doll in the thing, pick one to be the source of this part
                    //if i don't pick any it's a 'mutant' since it's the random doll
                    if (yours != null && rand.nextDouble() > .1) {
                        //print("my ${mine} was ${mine.imgNumber}, your ${yours} was ${yours.imgNumber}, them together is ${mine.imgNumber & yours.imgNumber}");
                        int max = mine.maxImageNumber;
                        if (max == 0) max = 1;
                        mine.imgNumber =
                            yours.imgNumber % max; //dont' go over you dick
                        //print("mine after alchemy is ${mine.imgNumber}");
                        if (firstEye > 0 && mine.imgNameBase.contains("Eye"))
                            mine.imgNumber = firstEye;
                        if (firstEye < 0 && mine.imgNameBase.contains("Eye"))
                            firstEye = mine.imgNumber;
                    }
                }
            }

            for(int i = 0; i<ret.palette.length; i++) {
                Doll d = rand.pickFrom(dolls);
                Colour mine = ret.palette[i];
                Colour yours;
                if(d.palette.length > i) yours = d.palette[i];
                if(yours != null && rand.nextDouble() > .1) {
                    mine.red = yours.red;
                    mine.green =yours.green;
                    mine.blue = yours.blue;
                }
            }
            ret.afterBreeding(dolls);

        return ret;

    }

    //who is shogun???
    static int convertSentenceToNumber(String sentence) {
       // print("converting sentence ${sentence}");
        int ret = 0;
        for(int s in sentence.codeUnits) {
            //print ("code unit ${new String.fromCharCode(s)}");
            ret += s;
        }
        return ret;
    }

    static int getFirstFreeID() {
        //fuck you if you want to store more than 1k dolls.
        for(int i = 0; i<255; i++) {
            if(!window.localStorage.containsKey("${Doll.localStorageKey}$i")) return i;
        }
    }

    void copy(Doll source) {
        copyPalette(source.palette);
        copyLayers(source.dataOrderLayers);
        dollName = source.dollName;
    }

    Doll clone() {
        Doll ret = allDollsMappedByType[renderingType];
        ret.copy(this);
        return ret;
    }

    void copyPalette(Palette newP) {
        int i = 0;
        List<String> names = new List.from(palette.names);
        //handles if the two paletttes match, or not.
        for(String name in newP.names) {
            if(palette.names.contains(name)) {
                palette.add(name, newP[name], true);
            }else {
                if(i < palette.names.length)palette.add(names[i], newP[name], true);
            }
            i++;
        }
    }

    //most dolls do nothing, but things with positioned layers, like trees, will do things.
    Future<Null> beforeRender() async {

    }

    void copyLayers(List<SpriteLayer> layers) {
        //print("copying layers $layers and dataOrderLayers is $dataOrderLayers");
        for(int i = 0; i<dataOrderLayers.length; i++) {
            if(i >= layers.length) {
                print("skipping because $i is out of index for layers ${layers.length}");
            }else{
                //print("$i is in index for layers ${layers.length}");
                dataOrderLayers[i].imgNumber = layers[i].imgNumber;
            }
        }
    }



    //if its a subdoll, can skip the name, it won't be legacy anywyas
    void load(ImprovedByteReader reader, String dataString, bool nameExpected) {
        setDollNameFromString(removeURLFromString(dataString), nameExpected);//i know it has a name, or else it's legacy and this will throw an error.
        String dataStringWithoutName = removeLabelFromString(dataString);
        Uint8List thingy = BASE64URL.decode(dataStringWithoutName);
        if(reader == null) {
            reader = new ImprovedByteReader(thingy.buffer, 0);
            reader.readExpGolomb(); //pop it off, i already know my type
        }
        initFromReader(reader, false);
        initFromReader(reader, false);
    }


    void addDynamicLayer(DynamicLayer d) {
        //IMPORTANT: will only work if data and rendering layers are not gets
        //worry about refacatoring this l8r
        dataOrderLayers.add(d);
        renderingOrderLayers.add(d);
    }

    //i am assuming type was already read at this point. Type, Exo is required.
    //IMPORTANT: WHATEVER CALLS ME SHOULD try/catch FOR OLD DATA
    void initFromReader(ImprovedByteReader reader, [bool layersNeedInit = true]) {
        if(layersNeedInit) {
            //print("initalizing layers");
            initLayers();
        }
        int numColors = reader.readExpGolomb();
        //print("Number of colors is $numColors");
        List<String> names = new List<String>.from(palette.names);
        names.sort();

        for(int i = 0; i< numColors; i++) {
            //print("reading color ${names[i]}");
            Colour newColor = new Colour(reader.readByte(),reader.readByte(),reader.readByte());
            palette.add(names[i], newColor, true);
        }

        int numLayers = reader.readExpGolomb();
        //print("Number of layers is $numLayers");
        for(int i = 0; i<numLayers; i++) {
            if( i < dataOrderLayers.length) {
                dataOrderLayers[i].loadFromReader(reader);
            }else {
                print("more layers than expected, is it a dynamic layer?");
                DynamicLayer d = DynamicLayer.instantiateLayer(reader);
                addDynamicLayer(d);
            }
        }

        try {
            //builder.appendExpGolomb(rotation);
            //        builder.appendExpGolomb(orientation);
            rotation = reader.readExpGolomb();
            orientation = reader.readExpGolomb();
        }catch(e) {
            //print("no rotation data but that's okay");
        }



    }


    void initFromReaderOld(OldByteBuilder.ByteReader reader, [bool layersNeedInit = true]) {
        if(layersNeedInit) {
            //print("initalizing layers");
            initLayers();
        }
        int numFeatures = reader.readExpGolomb();
       // print("in legacy reader, I think there are ${numFeatures} features");
        int featuresRead = 2; //for exo and doll type

        List<String> names = new List<String>.from(palette.names);
        names.sort();
        for(String name2 in names) {
            featuresRead +=1;
            Colour newColor = new Colour(reader.readByte(),reader.readByte(),reader.readByte());
            palette.add(name2, newColor, true);
        }
        //print ("ready to start reading old data layers $oldDataLayers");

        //layer is last so can add new layers.
        for(SpriteLayer l in oldDataLayers) {
            //older strings with less layers
          //  print("layer ${l.name}, features read is $featuresRead and num features is $numFeatures");

            //<= is CORRECT DO NOT FUCKING CHANGE IT OR THE LAST LAYER WILL GET EATEN. ALSO: Fuck you, i don't know why i have to have a try catch in there since that if statement SHOULD mean only try to read if there's more to read but what fucking ever it works.
            if(featuresRead <= numFeatures) {
                try {
                    l.loadFromReaderOld(reader); //handles knowing if it's 1 or more bytes
                    // print("reading (${l.name}), its ${l.imgNumber} ");
                }catch(exception, stackTrace) {
            //        print("exo said I have $numFeatures and i've only read $featuresRead, but still can't read (${l.name}) for some reason. this is a caught error");
                    l.imgNumber = 0; //don't have.
                }
                //l.imgNumber = reader.readByte();
            }else {
              //  print("skipping a feature (${l.name}) i don't have in string");
                l.imgNumber = 0; //don't have.
            }
            //print("loading layer ${l.name}. Value: ${l.imgNumber} bytesRead: $featuresRead  numFeatures: $numFeatures");
            if(l.imgNumber > l.maxImageNumber) l.imgNumber = 0;
            featuresRead += 1;

        }
    }


    void setPalette(Palette chosen) {
        for(String name in chosen.names) {
            palette.add(name, chosen[name],true);
        }
    }



    void beforeSaving() {
        //nothing to do but other dolls might sync old and new parts
    }

    //what goes after a ?
    String toDataUrlPart() {
        String dataString = toDataBytesX();
        //need to escape name shit
        return Uri.encodeQueryComponent(dataString);
    }

    //will always be new format, since it calls toDataBytesX itself
    void visualizeData(Element container, [String dataString]) {
        DivElement me = new DivElement();
        container.append(me);
        if(dataString == null) {
            dataString = toDataBytesX();
        }
        String dataStringWithoutName = removeLabelFromString(dataString);
        Uint8List thingy = BASE64URL.decode(dataStringWithoutName);
        ImprovedByteReader reader = new ImprovedByteReader(thingy.buffer);
        TableElement table = new TableElement();
        me.append(table);
        oneRowOfDataTable("Type",table, reader);
        oneRowOfDataTable("Number of Colors",table, reader);

        List<String> names = new List<String>.from(palette.names);
        names.sort();
        for(String name2 in names) {
            //print("saving color $name2 with value red ${color.red}, green${color.green} blue${color.blue}");
            oneRowOfDataTable("$name2 Red",table, reader, true);
            oneRowOfDataTable("$name2 Green",table, reader, true);
            oneRowOfDataTable("$name2 Blue",table, reader, true);
        }

        oneRowOfDataTable("Number of Layers",table, reader);
        for(SpriteLayer l in dataOrderLayers) {
            oneRowOfDataTable("${l.name}",table, reader, false, l);
        }

        oneRowOfDataTable("Rotation:",table, reader);
        oneRowOfDataTable("Orientation",table, reader);


        try {
            for(int i = 0; i<113; i++) {
                oneRowOfDataTable("???", table, reader);
            }

        }catch(e) {
            print("ran out of data, $e");
        }


    }

    void oneRowOfDataTable( String label, TableElement table, ImprovedByteReader reader, [bool oneByte = false, SpriteLayer layer]) {
        TableRowElement row = new TableRowElement();
        table.append(row);

        TableCellElement td1 = new TableCellElement()..setInnerHtml("<b>$label</b>");
        TableCellElement td2;
        row.append(td1);
        if(oneByte) {
            //colors
            td2 = new TableCellElement()..setInnerHtml("${reader.readByte()}");
        }else if (layer != null) {
            //layer
            td2 = new TableCellElement()..append(layer.parseDataForDebugging(reader));
        }else {
            //misc
            td2 = new TableCellElement()..setInnerHtml("${reader.readExpGolomb()}");
        }
        row.append(td2);
    }

    ByteBuilder appendDataBytesToBuilder(ByteBuilder builder) {
        builder.appendExpGolomb(renderingType); //value of 1 means homestuck doll, etc. exo whatever so can have more than 255 dolltypes becaues i am thinking ahead for once. you won't get any 'no way we'll have more than 250 dolls' from me anytime soon


        List<String> names = new List<String>.from(palette.names);
        names.sort();
        builder.appendExpGolomb(names.length); //for length of palette
        //print("saved color length");
        for(String name2 in names) {
            Colour color = palette[name2];
            //print("saving color $name2 with value red ${color.red}, green${color.green} blue${color.blue}");
            builder.appendByte(color.red);
            builder.appendByte(color.green);
            builder.appendByte(color.blue);
        }
        //print('saved colors');
        builder.appendExpGolomb(dataOrderLayers.length); //for length of layers
        //print('saved data length');
        //layer is last so can add new layers
        for(SpriteLayer l in dataOrderLayers) {
            //print("adding ${l.name}  with value ${l.imgNumber} to data string builder.");
            l.saveToBuilder(builder);
            //builder.appendByte(l.imgNumber);
        }
        //print("saved data, now for rotaiton of $rotation");
        builder.appendExpGolomb(rotation);
        //print("saved rotation, now for orientation of $orientation");
        builder.appendExpGolomb(orientation);
        //print("saved orientation");
        return builder;
    }
    //first, the rendering type. (this will get taken off before being passed to the loader)
    //numColors, colors, numLayers, layers
    String toDataBytesX([ByteBuilder builder = null]) {
        if(dollName == null || dollName.isEmpty) dollName = name;

        beforeSaving();
         //print("saving to data bytes x");
        if(builder == null) builder = new ByteBuilder();
        builder = appendDataBytesToBuilder(builder);

        return "$label${BASE64URL.encode(builder.toBuffer().asUint8List())}";
    }

    //legacy as of 6/18/18
    String toDataBytesXOld([ByteBuilder builder = null]) {
        beforeSaving();
       // print("saving to data bytes x");
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
           // print("saving color $name");
            Colour color = palette[name];
            builder.appendByte(color.red);
            builder.appendByte(color.green);
            builder.appendByte(color.blue);
        }

        //layer is last so can add new layers
        for(SpriteLayer l in dataOrderLayers) {
            //print("adding ${l.name}  with value ${l.imgNumber} to data string builder.");
            l.saveToBuilder(builder);
            //builder.appendByte(l.imgNumber);
        }

        return BASE64URL.encode(builder.toBuffer().asUint8List());
    }

    //if it's in url form, it has a ? right before the text.
    static String removeURLFromString(String ds) {
        if(!ds.contains("index.html")) return ds; //make sure it at least looks url like
        List<String> ret = ds.split("?");
        if(ret.length == 1) return ret[0];
        return ret[1];
    }

    static String removeLabelFromString(String ds) {
        ds = Uri.decodeQueryComponent(ds); //get rid of any url encoding that might exist
        List<String> parts = ds.split("$labelPattern");
        if(parts.length == 1) {
            return parts[0];
        }else {
            return parts[1];
        }
    }

    void setDollNameFromString(String ds, bool nameExpected) {
        ds = Uri.decodeQueryComponent(ds); //get rid of any url encoding that might exist
        List<String> parts = ds.split("$labelPattern");
        if(parts.length == 1) {
            //this should defeat DQ0N
            if(nameExpected) throw "ERROR: THERE WAS NO NAME IN $ds WHICH MEANS THIS WAS LEGACY. ABORTING SO I CAN SWITCH TO LEGACY MODE.";
        }else {
            dollName = parts[0];
        }
       // print("after loading, doll name is $dollName");
    }


    /* first part of any data string tells me what type of doll to load.*/
    static Doll loadSpecificDoll(String ds) {
        //print("loading doll from string $ds");
        String dataStringWithoutName = removeURLFromString(ds);
        //print("datastring without url is $dataStringWithoutName");
        dataStringWithoutName = removeLabelFromString(dataStringWithoutName);
        //print("dataString without name is $dataStringWithoutName");
        Uint8List thingy = BASE64URL.decode(dataStringWithoutName);
        ImprovedByteReader reader = new ImprovedByteReader(thingy.buffer, 0);
        int type = -99;
        //FUTURE JR, PAY ATTENTION
        //IF THE EXOWHATEVER ACCIDENTALLY READS SOMETHING THAT MAKES SENSE
        //YOU MIGHT NOT REALIZE IT'S GOT AN ERROR
        //BUT WHEN IT TRIES TO LOAD THE WRONG TYPE IT WILL
        //BUT BY THEN IT WILL ALREADY BE IN THE WRONG DOLL
        //WORRY ABOUT THIS IF IT HAPPENS, FOR NOW

        //ACTUALLY, RET.LOAD DOESN'T TRY CATCH ANYMORE, SO IT COMES OUT AND SHOULD HAVE THE
        //RIGHT TYPE, BUT IT'S STILL LOADING WRONG AND I DON'T KNOW WHY???
        Doll ret;
        try {
            type = reader.readExpGolomb();
            //print("reading exo whatever, type is $type");
            Doll source = allDollsMappedByType[type];
            if(source == null) throw "ERROR: COULD NOT FIND DOLL OF TYPE $type.";
            ret = source.clone();
            ret.load(reader, ds,true);
        }catch(e,trace){
            thingy = BASE64URL.decode(dataStringWithoutName);
            OldByteBuilder.ByteReader reader = new OldByteBuilder.ByteReader(thingy.buffer, 0);
            type = reader.readByte();
            ret = allDollsMappedByType[type].clone();
            print("reading legacy because of error $e with trace $trace, type is $type");
            ret.initFromReaderOld(reader);
        }
        return ret;
    }

    CanvasElement get blankCanvas {
        return new CanvasElement(width: width, height: height);
    }

    static Doll loadSpecificDollFromReader(ImprovedByteReader reader) {
        //print("loading doll from string $ds");
        int type = -99;
        //FUTURE JR, PAY ATTENTION
        //IF THE EXOWHATEVER ACCIDENTALLY READS SOMETHING THAT MAKES SENSE
        //YOU MIGHT NOT REALIZE IT'S GOT AN ERROR
        //BUT WHEN IT TRIES TO LOAD THE WRONG TYPE IT WILL
        //BUT BY THEN IT WILL ALREADY BE IN THE WRONG DOLL
        //WORRY ABOUT THIS IF IT HAPPENS, FOR NOW

        //ACTUALLY, RET.LOAD DOESN'T TRY CATCH ANYMORE, SO IT COMES OUT AND SHOULD HAVE THE
        //RIGHT TYPE, BUT IT'S STILL LOADING WRONG AND I DON'T KNOW WHY???
        Doll ret;
        try {
            print("reading exo whatever in load from reader, reader is ${reader}");
            type = reader.readExpGolomb();
            print("reading exo whatever in load from reader, type is $type");
            ret = allDollsMappedByType[type].clone();
            print("load from reader, ret is $ret");
            //name is NOT expected because if i'm loading from a reader this is a subdoll or similar, no plain text in any case
            ret.load(reader, "doesnotexist",false);
        }catch(e,trace){
            print("ERROR: this method does not support legacy strings, but had error $e in parsing with trace $trace");
        }
        return ret;
    }

    static Doll randomHomestuckDoll() {
        Random rand = new Random();;
        WeightedList<Doll> choices = new WeightedList<Doll>();
        choices.addAll(<Doll>[new HomestuckTrollDoll(), new HomestuckDoll(), new HomestuckCherubDoll(), new HomestuckSatyrDoll()]);
        choices.add(new HomestuckBabyDoll(), 0.5);
        choices.add(new HomestuckGrubDoll(), 0.5);
        choices.add(new EggDoll(), 0.1);
        choices.add(new TrollEggDoll(), 0.1);
        return rand.pickFrom(choices);
    }

    /* first part of any data string tells me what type of doll to load.*/
    static Doll randomDollOfType(int type) {
        return allDollsMappedByType[type].clone();
    }

    static List<SavedDoll> loadAllFromLocalStorage() {
        int last = 255; //don't care about first ree id cuz they can be deleted.
        List<SavedDoll> ret = new List<SavedDoll>();
        for(int i = 0; i< last; i++) {
           // print("processing doll from storage $i, already have processed ${ret.length} dolls");
            if(window.localStorage.containsKey("${Doll.localStorageKey}$i")) {
                String dataString = window.localStorage["${Doll
                    .localStorageKey}$i"];
                //print("doll actually exists and is $dataString");

                if (dataString != null) {
                    try {
                        Doll doll = loadSpecificDoll(dataString);
                        //print("I loaded the doll and it was $doll");
                        ret.add(new SavedDoll(doll, i));
                    }catch(e, stacktrace) {
                      print("error processing loaded doll $dataString, because $e at $stacktrace");
                    }
                }
            }
        }
        print("returning ${ret.length} saved dolls from local storage");
        return ret;
    }

    static Doll makeRandomDoll()  {
        Random rand = new Random();;
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

//name color pair but short
class NCP
{
    String name;
    String styleString;

    NCP(String this.name, String this.styleString);

    void addToPalette(Palette p) {
        p.add(name, new Colour.fromStyleString(styleString), true);
    }

}