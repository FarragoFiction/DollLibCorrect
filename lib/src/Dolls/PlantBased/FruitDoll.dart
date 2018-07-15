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
    int maxBody = 26;
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
        initPalettes(); //since a fruit makes a tree, needs same palettes
        initLayers();
        randomize();
        setName();
    }

    void initPalettes() {
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
        genericStarts.addAll(<String>["Star","Bread","Yum","Sweet","Juicy","Tart","Sour","Bitter","Musk","Dragon","Bird","Lizard","Horse","Pigeon"]);
        genericStarts.addAll(<String>["Planet","Cosmic","Delicious","Rice","Snack","Dinner","Hazle","Pea","Chest","Song","Pain","Tall","Hard","Soft"]);
        genericStarts.addAll(<String>["Canary","Duck","Monkey","Ape","Bat","Pony","Shogun","Jaded","Paradox","Karmic","Manic","Table","Aspiring","Recursive"]);
        genericStarts.addAll(<String>["Woo","Chew","Bite","Dilletant","Oracle","Insomniac","Insufferable","Some","Body","Mathematician","Guardian","Mod","Watcher","Slacker"]);
        genericStarts.addAll(<String>["Dog","Land","Retribution","Researcher","Cat","Troll","Canine","Gull","Wing","Pineapple","Cactus","Coma","Catatonic","Cumulus"]);
        genericStarts.addAll(<String>["Moon","Cool","Yogistic","Doctor","Knight","Seer","Page","Mage","Rogue","Sylph","Fairy","Thief","Maid","Heir","Prince","Witch","Hag","Mermaid"]);
        genericStarts.addAll(<String>["Fish","Corpse","Cake","Muffin","Bacon","Pig","Taco","Salsa","Carpet","Kiwi","Snake","Salamander","Breath","Time","King","Queen","Royal","Clubs"]);
        genericStarts.addAll(<String>["Spades","Heart","Diamond","Butler","Doom","Blood","Heart","Mind","Space","Light","Void","Rage","Bacchus","Drunk","Hope","Life"]);
        genericStarts.addAll(<String>["Wine","Jelly","Jam","Juice","Gum","Fire","Icy","Blanket","Cool","Heat","Dour","Shadow","Luck","Rattle"]);

        WeightedList<String> genericEnds = new WeightedList<String>();
        genericEnds.add("Seed", 1.0);
        genericEnds.add("Fruit", 1.0);
        genericEnds.add("Berry", 1.0);
        genericEnds.add("Nut", 1.0);
        genericEnds.add("Melon", 1.0);
        if(body.imgNumber == 0 || body.imgNumber == 11) genericEnds.add("Apple");
        if(body.imgNumber == 5 || body.imgNumber == 6) genericEnds.add("Grape");
        if(body.imgNumber == 12) genericEnds.add("Cherry");

        if(body.imgNumber == 24 ) genericStarts.add("Eye",100.0);
        if(body.imgNumber == 26 ) genericStarts.add("Cod",100.0);
        if(body.imgNumber == 15 ) genericStarts.add("Frog",100.0);

        String start = rand.pickFrom(genericStarts);
        String end = rand.pickFrom(genericEnds);

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
    }



    @override
    void randomizeNotColors() {
                if(rand == null) rand = new Random();;
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
        }
    }

    void randomizeColors() {
        if(rand == null) rand = new Random();;

        Palette newPallete = rand.pickFrom(validPalettes);
        copyPalette(newPallete);
    }


}


