import "../../../DollRenderer.dart";
import "../../commonImports.dart";
import "../Doll.dart";
import "../Layers/SpriteLayer.dart";
import "HomestuckDoll.dart";


class HomestuckTreeBab extends HomestuckLamiaDoll {

    @override
    String originalCreator = "karmicRetribution";

    
    @override
    int renderingType =85;
    @override
    String relativeFolder = "images/Homestuck";

    @override
    String name = "TreeBab";
    @override
    final int maxBody = 3;

    @override
    Palette paletteSource = ReferenceColours.LAMIA_PALETTE;

    @override
    Palette palette = new HomestuckLamiaPalette()
        ..accent = '#FF9B00'
        ..shoe_light = '#ffa8ff'
        ..shoe_dark = '#ff5bff'
        ..cloak_light = '#f8dc57'
        ..cloak_mid = '#d1a93b'
        ..cloak_dark = '#ad871e'
        ..shirt_light = '#eae8e7'
        ..shirt_dark = '#bfc2c1'
        ..pants_light = '#03500e'
        ..pants_dark = '#00341a'
        ..eye_white_left = "#ffa8ff"
        ..eye_white_right = "#ffa8ff"
        ..aspect_light = '#FF9B00'
        ..aspect_dark = '#FF8700'
        ..hair_accent = '#aa0000'
        ..hair_main = '#000000'
        ..skinDark = '#69b8c8'
        ..horn1 = "#000000"
        ..horn2 = "#000000"
        ..horn3 = "#000000"

        ..skin = '#8ccad6';



    HomestuckTreeBab([int sign]) {
        initLayers();
        randomize();
        if(sign != null) {
           // print("sign is $sign");
            canonSymbol.imgNumber = sign;
            //print("used sign to set canon Symbol to ${canonSymbol.imgNumber}");

            //makes sure palette is sign appropriate
            randomize(false);
            //print("after randomize, canon symbol is ${canonSymbol.imgNumber}");

        }
    }

    @override
    Doll hatch() {
        SmolTrollDoll newDoll = new SmolTrollDoll();
        int seed = associatedColor.red + associatedColor.green + associatedColor.blue + renderingOrderLayers.first.imgNumber ;
        newDoll.rand = new Random(seed);
        newDoll.randomize();
        Doll.convertOneDollToAnother(this, newDoll);
        newDoll.extendedBody.imgNumber = newDoll.rand.nextInt(newDoll.extendedBody.maxImageNumber);
        newDoll.symbol.imgNumber = 0; //use canon sign you dunkass.
        //(newDoll as HomestuckTrollDoll).mutantEyes(false);
        return newDoll;
    }


    void mutantWings([bool force = false]) {
        //grubs don't have wings. trolls do.
    }

    @override
    void randomizeNotColors()

    {
        super.randomizeNotColors();
        canonSymbol.imgNumber = 0;
    }



    @override
    void regularEyes(older) {
        HomestuckPalette h = palette as HomestuckPalette;
        if(older) {
            palette.add(HomestuckPalette.EYE_WHITE_LEFT, new Colour.fromStyleString("#ffba29"), true);
            palette.add(HomestuckPalette.EYE_WHITE_RIGHT, new Colour.fromStyleString("#ffba29"), true);
        }else {
            h.add(HomestuckPalette.EYE_WHITE_LEFT, h.aspect_light, true);
            h.add(HomestuckPalette.EYE_WHITE_RIGHT, h.aspect_light, true);
        }
    }

    @override
    void randomizeColors() {
        super.randomizeColors();
        HomestuckLamiaPalette h = palette as HomestuckLamiaPalette;
        copyPalette(ReferenceColours.PURIFIED);
        //print("trying to set horn to ${h.aspect_light.toStyleString()}");
        String light = h.aspect_light.toStyleString();
        String dark = h.aspect_dark.toStyleString();
        if (rand.nextBool()) {
            h.horn1 = new Colour.fromStyleString(light);
        } else {
            h.horn1 = new Colour.fromStyleString(dark);
        }
        if (rand.nextBool()) {
            h.horn2 = new Colour.fromStyleString(light);
        } else {
            h.horn2 = new Colour.fromStyleString(dark);
        }

        if (rand.nextBool()) {
            h.horn3 = new Colour.fromStyleString(light);
        } else {
            h.horn3 = new Colour.fromStyleString(dark);
        }
    }

    @override
    void randomize([bool chooseSign = true])

    {
        super.randomize(chooseSign);
        canonSymbol.imgNumber = 0;
        HomestuckPalette h = palette as HomestuckPalette;
        h.add(HomestuckPalette.EYE_WHITE_LEFT, h.aspect_light,true);
        h.add(HomestuckPalette.EYE_WHITE_RIGHT, h.aspect_light,true);
    }



    @override
    void initLayers()

    {
        super.initLayers();
        body = new SpriteLayer("Body","$folder/TreeBab/", 0, maxBody, legacy:true);
        extendedBody = layer("HomestuckTreeBab.Body", "TreeBab/", 0, mb:true);//new SpriteLayer("Body","$folder/Grub/", 0, maxBody, supportsMultiByte: true);


    }








}