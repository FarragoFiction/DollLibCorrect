import 'package:CommonLib/Compression.dart';

import "../../Dolls/Doll.dart";
import 'package:DollLibCorrect/src/Dolls/KidBased/HomestuckDoll.dart';
import "package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import 'package:RenderingLib/RendereringLib.dart';

import "../../Rendering/ReferenceColors.dart";
import 'package:RenderingLib/src/Misc/weighted_lists.dart';
class FruitDoll extends Doll {

    List <int> mutants = <int>[56,50,55,44,50,48,46,27,24,15,14];

    @override
    Colour get associatedColor {

        if(palette is HomestuckPalette ) {
            return  (palette as HomestuckPalette).shoe_light;
        }else {
            return  palette.first;
        }
    }
    @override
    List<Palette> validPalettes = new List<Palette>.from(ReferenceColours.paletteList.values);

    int maxBody = 33;
    String relativefolder = "images/Fruit";

    SpriteLayer body;

    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[body];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[body];


    @override
    int width = 50;
    @override
    int height = 50;

    @override
    int renderingType =35;

    @override
    String name = "Fruit";

    @override
    Palette palette = new HomestuckPalette()
        ..accent = '#FF9B00'
        ..aspect_light = '#FF9B00'
        ..aspect_dark = '#FF8700'
        ..shoe_light = '#7F7F7F'
        ..shoe_dark = '#727272'
        ..cloak_light = '#A3A3A3'
        ..cloak_mid = '#999999'
        ..cloak_dark = '#898989'
        ..shirt_light = '#EFEFEF'
        ..shirt_dark = '#DBDBDB'
        ..pants_light = '#C6C6C6'
        ..eye_white_left = '#ffffff'
        ..eye_white_right = '#ffffff'
        ..pants_dark = '#ADADAD'
        ..hair_main = '#ffffff'
        ..hair_accent = '#ADADAD'
        ..skin = '#ffffff';

    @override
    String originalCreator = "jadedResearcher and dystopicFuturism";

    FruitDoll([Random setRand]) {
        if(setRand != null) rand = setRand;
        if(rand == null) rand = new Random();
        initPalettes(); //since a fruit makes a tree, needs same palettes
        initLayers();
        randomize();
        rand = new Random(seed);
        setName();
    }

    void initPalettes() {
        rand.nextInt(); //initialize it before palette time
        for(int i = 0; i < 13*2; i++) {
            validPalettes.add(makeRandomPalette());
        }
    }

    Colour getRandomFruitColor() {
        //reds, purples, yellows are all valid, so lets go for hsv, max s and at least 50% v?
        double color = rand.nextDouble(0.16); //up to green
        //60 to 180 is green so avoid that
        //.16 to 0.5
        if(rand.nextBool()) {
            color = rand.nextDouble(0.5) + 0.5; //blue to pink
        }
        return new Colour.hsv(color,1.0,rand.nextDouble()+0.5);
    }

    Colour getRandomLeafColor() {
        //reds, purples, yellows are all valid, so lets go for hsv, max s and at least 50% v?
        double color = rand.nextDouble(0.44-0.16)+0.16;// up to green minus the reds
        return new Colour.hsv(color,rand.nextDouble()+0.5,rand.nextDouble()+0.1);
    }

    Colour getRandomBarkColor() {
        //reds, purples, yellows are all valid, so lets go for hsv, max s and at least 50% v?
        double color = rand.nextDouble(0.13);// up to yellow
        return new Colour.hsv(color,rand.nextDouble()+0.25,rand.nextDouble()+0.1);
    }

    Palette makeRandomPalette() {
        //print("making a random palette for $name");
        HomestuckPalette newPalette = new HomestuckPalette();

        newPalette.add(HomestuckPalette.SHOE_LIGHT, getRandomFruitColor(),true);
        makeOtherColorsDarker(newPalette, HomestuckPalette.SHOE_LIGHT, <String>[HomestuckPalette.SHOE_DARK, HomestuckPalette.ACCENT]);

        newPalette.add(HomestuckPalette.ASPECT_LIGHT, getRandomFruitColor(),true);
        makeOtherColorsDarker(newPalette, HomestuckPalette.ASPECT_LIGHT, <String>[HomestuckPalette.ASPECT_DARK]);

        newPalette.add(HomestuckPalette.HAIR_MAIN, getRandomFruitColor(),true);
        makeOtherColorsDarker(newPalette, HomestuckPalette.HAIR_MAIN, <String>[HomestuckPalette.HAIR_ACCENT]);

        newPalette.add(HomestuckPalette.SHIRT_LIGHT, getRandomBarkColor(),true);
        makeOtherColorsDarker(newPalette, HomestuckPalette.SHIRT_LIGHT, <String>[HomestuckPalette.SHIRT_DARK]);

        newPalette.add(HomestuckPalette.PANTS_LIGHT, getRandomBarkColor(),true);
        makeOtherColorsDarker(newPalette, HomestuckPalette.PANTS_LIGHT, <String>[HomestuckPalette.PANTS_DARK]);

        newPalette.add(HomestuckPalette.CLOAK_LIGHT, getRandomLeafColor(),true);
        makeOtherColorsDarker(newPalette, HomestuckPalette.CLOAK_LIGHT, <String>[HomestuckPalette.CLOAK_MID, HomestuckPalette.CLOAK_DARK]);
        return newPalette;
    }



    void setName() {
        WeightedList<String> genericStarts = new WeightedList<String>();
        genericStarts.addAll(<String>["Fox","Badger","Honey Badger","Skunk","Bird","Birb","Borb","Cloud","Servant","Logan","Elder","Young","Deer","Antelope","Mull","Chintz"]);
        genericStarts.addAll(<String>["Dry","Crocodile","Rose","Bed","Service","Sea","Gulf","Golf","Base","Fort","Saw","Spiny","Strawberry","Tamarind","Thimble","Vanilla","Wax","Choke","Alien"]);
        genericStarts.addAll(<String>["Alligator","Crocodile","Snake","Salamander","Turtle","Guava","Grape","Hairless","Ice Cream","Hardy","Huckle","Jack","Juniper","Palm","Kumquat","Lady"]);
        genericStarts.addAll(<String>["Shenanigan","Crazy","Adult","Truth","Lie","Bone","Honey","Tiger","Relish","Salsa","Giggle","Dance","Party","Fiesta","Ground","Button"]);
        genericStarts.addAll(<String>["Rock","Stone","Pit","Wood","Metal","Bone","Custard","Hair","Fluffy","Fae","Claw","Beach","Bitter","Buffalo", "Bush","Tree","Vine","Yew"]);
        genericStarts.addAll(<String>["Medicinal","Cleaning","Cleansing","Mowhawk","Hawk","Sparrow","Parrot","Tropical","Mop","Gravity","Vision","Eagle","Winter","Spring","Summer","Fall"]);
        genericStarts.addAll(<String>["Straw","Hay","Barn","Field","Farm","Mine","Craft","Compote","Curry","Sauce","Yes","No","Bob","Donkey","Cape","Cashew"]);
        genericStarts.addAll(<String>["Salt","Sugar","Pepper","Spicy","Cran","Gum","Razz","Pepo","Banana","Mango","Bay","Nutrient","Health","Citris","Cherry"]);
        genericStarts.addAll(<String>["Goose","Duck","Pawpaw","Quince","Bully","Cow","Ox","Rabbit","Ginko","Medicine","Syrup","Roll","Cheese","Dimple"]);
        genericStarts.addAll(<String>["Crab","Ugli","Pawpaw","Passion","Apricot","Key","Island","Ocean","Lake","River","One","Angel","Devil","Hand","Energy","Coffee"]);
        genericStarts.addAll(<String>["Dust","Mud","Leaf","Seed","Juicey","Moose","Squirrell","Bone","Pain","Blush","Skull","Finger","Haste","Sleep","Eastern","Northern","Southern","Western"]);
        genericStarts.addAll(<String>["Mob","Psycho","Psychic","Butter","Drink","Ghost","Magic","Wizard","Chocolate","Pudding","Desert","Dessert","Sand","Jungle","Snow"]);
        genericStarts.addAll(<String>["Meadow","Forest","City","Exotic","Socratic","Historical","Wood","Spice","Meat","Fast","Family","Plum","Temper","Wolf"]);
        genericStarts.addAll(<String>["Plant","Star","Bread","Yum","Sweet","Juicy","Tart","Sour","Bitter","Musk","Dragon","Bird","Lizard","Horse","Pigeon","Emu","Elephant","Fig"]);
        genericStarts.addAll(<String>["Planet","Cosmic","Delicious","Rice","Snack","Dinner","Hazle","Pea","Chest","Song","Pain","Tall","Hard","Soft","Cola","Crow","Common"]);
        genericStarts.addAll(<String>["Canary","Duck","Monkey","Ape","Bat","Pony","Shogun","Jaded","Paradox","Karmic","Manic","Table","Aspiring","Recursive"]);
        genericStarts.addAll(<String>["Woo","Chew","Bite","Dilletant","Oracle","Insomniac","Insufferable","Some","Body","Mathematician","Guardian","Mod","Watcher","Slacker"]);
        genericStarts.addAll(<String>["Dog","Land","Retribution","Researcher","Cat","Troll","Canine","Gull","Wing","Pineapple","Cactus","Coma","Catatonic","Cumulus"]);
        genericStarts.addAll(<String>["Moon","Cool","Yogistic","Doctor","Knight","Seer","Page","Mage","Rogue","Sylph","Fairy","Thief","Maid","Heir","Prince","Witch","Hag","Mermaid"]);
        genericStarts.addAll(<String>["Fish","Corpse","Cake","Muffin","Bacon","Pig","Taco","Salsa","Carpet","Kiwi","Snake","Salamander","Breath","Time","King","Queen","Royal","Clubs"]);
        genericStarts.addAll(<String>["Spades","Heart","Diamond","Butler","Doom","Blood","Heart","Mind","Space","Light","Void","Rage","Bacchus","Drunk","Hope","Life","Durian"]);
        genericStarts.addAll(<String>["Ring","Pomelo","Sharp","Prickly","Donut","Baby","Papaya","Oil","Poisonous","Toxic","Generic","Wine","Jelly","Jam","Juice","Gum","Fire","Icy","Blanket","Cool","Heat","Dour","Shadow","Luck","Rattle"]);
        genericStarts.addAll(<String>["Script","Java","Dart","Dank","Muse","Lord","Meme","May","June","Mock","Mountain","Nut","Apple","Grape","Sauce","Dream","Rain","Mist","Sand","Mighty","Orange","Tangerine","Water","Cave","Dirt","Clam","Apple","Berry","Date","Marriage"]);
        genericStarts.add("Tidepod", 0.5);
        genericStarts.add("Forbidden", 0.5);
        genericStarts.add("God", 0.5);
        genericStarts.add("Rare", 0.5);


        WeightedList<String> genericEnds = new WeightedList<String>();
        genericEnds.addAll(<String>["Seed","Fruit","Berry","Nut"]);
        genericEnds.add("Melon", 0.3);
        genericEnds.add("Fig", 0.3);
        genericEnds.add("Mango", 0.3);
        genericEnds.add("Apple", 0.3);

        genericEnds.add("Lemon", 0.3);
        genericEnds.add("Peach", 0.3);
        genericEnds.add("Plum", 0.3);
        genericEnds.add("Gum", 0.1);
        genericEnds.add("Currant", 0.1);
        genericEnds.add("Apricot", 0.3);

        if(body.imgNumber == 0 || body.imgNumber == 11) genericEnds.add("Apple",12.0);
        if(body.imgNumber == 5 || body.imgNumber == 6) genericEnds.add("Grape",12.0);
        if(body.imgNumber == 12) genericEnds.add("Cherry",1.0);
        if(body.imgNumber == 33) genericEnds.add("Star",12.0);
        if(body.imgNumber == 17) genericEnds.add("Pepper",12.0);
        if(body.imgNumber == 27) genericEnds.add("Bulb",12.0);

        if(body.imgNumber == 24 ) genericStarts.add("Eye",100.0);
        if(body.imgNumber == 26 ) genericStarts.add("Cod",100.0);
        if(body.imgNumber == 14 ) genericStarts.add("Justice",100.0);
        if(body.imgNumber == 15 ) genericStarts.add("Frog",100.0);

        Random freshRand = new Random(seed);
        String start = freshRand.pickFrom(genericStarts);
        String end = freshRand.pickFrom(genericEnds);

        dollName = "$start $end";
    }


    @override
    void initLayers() {
        body = new SpriteLayer("Body", "$folder/Body/", 1, maxBody);
    }

    @override
    void randomize() {
                if(rand == null) rand = new Random();;
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
        }
        randomizeColors();
        setName();
    }



    @override
    void randomizeNotColors() {
                if(rand == null) rand = new Random();;
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
        }
        setName();
    }

    void randomizeColors() {
        if(rand == null) rand = new Random();

        Palette newPallete = rand.pickFrom(validPalettes);
        copyPalette(newPallete);
        setName();
    }


}


