import 'package:DollLibCorrect/DollRenderer.dart';

class MonsterGirlDoll extends MagicalDoll {
    @override
    String originalCreator = "yearnfulNode and karmicRetribution";

    @override
    int renderingType =427;

    @override
    int width = 600;
    @override
    int height = 600;

    @override
    String name = "MonsterDoll";

    @override
    String relativefolder = "images/MonsterDoll";

    // yes technically its not REALLY these things. But it sure does make the transformation easier.
    SpriteLayer headDecorations;
    SpriteLayer notHairBack;
    SpriteLayer head;
    SpriteLayer arms;
    SpriteLayer skirts;
    SpriteLayer clothing;
    SpriteLayer legs;
    SpriteLayer torso;
    SpriteLayer notHairFront;
    SpriteLayer wings;
    SpriteLayer tail;
    SpriteLayer fx;

    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[fx,tail,wings,notHairFront,torso,legs,clothing,skirts,arms,head,notHairBack,headDecorations];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[fx,tail,wings,notHairFront,torso,legs,clothing,skirts,arms,head,notHairBack,headDecorations];

    MonsterDoll() {
        initLayers();
        randomize();
    }

    @override
    void initLayers() {

        {
            headDecorations = layer("$name.HeadDecorations", "1HeadDecorations/", 1);
            notHairBack = layer("$name.Nothair", "2Nothair/", 1);
            head = layer("$name.Head", "3Head/", 1);
            arms = layer("$name.Arms", "4Arms/", 1);
            skirts = layer("$name.Skirts", "5Skirts/", 1);
            clothing = layer("$name.Clothing", "6Clothing/", 1);
            legs = layer("$name.Legs", "7Legs/", 1);
            torso = layer("$name.Torso", "8Torso/", 1);
            notHairFront = layer("$name.NothairBack", "9NothairBack/", 1)..slaveTo(notHairBack);
            wings = layer("$name.Wings", "10Wings/", 1);
            tail = layer("$name.Tail", "11Tail/", 1);
            fx = layer("$name.FX", "12FX/", 1);


        }
    }

    @override
    Doll hatch() {

        MagicalDoll girl = new MagicalDoll();
        girl.copyPalette(palette);
        //same color, same layers (but don't go over max)

        if(girl.headDecorations.maxImageNumber == 0) {
            girl.headDecorations.imgNumber = 0;
        }else {
            girl.headDecorations.imgNumber = headDecorations.imgNumber % girl.headDecorations.maxImageNumber;
        }

        if(girl.notHairBack.maxImageNumber == 0) {
            girl.notHairBack.imgNumber = 0;
        }else {
            girl.notHairBack.imgNumber = notHairBack.imgNumber % girl.notHairBack.maxImageNumber;
        }

        if(girl.head.maxImageNumber == 0) {
            girl.head.imgNumber = 0;
        }else {
            girl.head.imgNumber = head.imgNumber % girl.head.maxImageNumber;
        }

        if(girl.arms.maxImageNumber == 0) {
            girl.arms.imgNumber = 0;
        }else {
            girl.arms.imgNumber = arms.imgNumber % girl.arms.maxImageNumber;
        }

        if(girl.skirts.maxImageNumber == 0) {
            girl.skirts.imgNumber = 0;
        }else {
            girl.skirts.imgNumber = skirts.imgNumber % girl.skirts.maxImageNumber;
        }

        if(girl.clothing.maxImageNumber == 0) {
            girl.clothing.imgNumber = 0;
        }else {
            girl.clothing.imgNumber = clothing.imgNumber % girl.clothing.maxImageNumber;
        }

        if(girl.legs.maxImageNumber == 0) {
            girl.legs.imgNumber = 0;
        }else {
            girl.legs.imgNumber = legs.imgNumber % girl.legs.maxImageNumber;
        }

        if(girl.torso.maxImageNumber == 0) {
            girl.torso.imgNumber = 0;
        }else {
            girl.torso.imgNumber = torso.imgNumber % girl.torso.maxImageNumber;
        }

        if(girl.notHairFront.maxImageNumber == 0) {
            girl.notHairFront.imgNumber = 0;
        }else {
            girl.notHairFront.imgNumber = notHairFront.imgNumber % girl.notHairFront.maxImageNumber;
        }

        if(girl.wings.maxImageNumber == 0) {
            girl.wings.imgNumber = 0;
        }else {
            girl.wings.imgNumber = wings.imgNumber % girl.wings.maxImageNumber;
        }

        if(girl.tail.maxImageNumber == 0) {
            girl.tail.imgNumber = 0;
        }else {
            girl.tail.imgNumber = tail.imgNumber % girl.tail.maxImageNumber;
        }

        if(girl.fx.maxImageNumber == 0) {
            girl.fx.imgNumber = 0;
        }else {
            girl.fx.imgNumber = fx.imgNumber % girl.fx.maxImageNumber;
        }

        //print("bird head is ${bird.head.imgNumber} and egg top was ${top.imgNumber}");
        return girl;

    }


}