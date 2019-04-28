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
    SpriteLayer hairBack;
    SpriteLayer bowBack;
    SpriteLayer body;
    SpriteLayer socks;
    SpriteLayer shoes;
    SpriteLayer skirt;
    SpriteLayer frontBow;
    SpriteLayer eyes;
    SpriteLayer eyebrows;
    SpriteLayer mouth;
    SpriteLayer hairFront;
    SpriteLayer glasses;

    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[glasses,hairFront,mouth,eyebrows,eyes,frontBow,skirt,shoes,socks,body,bowBack,hairBack];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[glasses,hairFront,mouth,eyebrows,eyes,frontBow,skirt,shoes,socks,body,bowBack,hairBack];

    MonsterDoll() {
        initLayers();
        randomize();
    }

    @override
    void initLayers() {

        {
            hairBack = layer("$name.HeadDecorations", "1HeadDecorations/", 1);
            bowBack = layer("$name.Whatever", "2Whatever/", 1);
            body = layer("$name.Head", "3Head/", 1);
            socks = layer("$name.Arms", "4Arms/", 1);
            shoes = layer("$name.Skirts", "5Skirts/", 1);
            skirt = layer("$name.Clothing", "6Clothing/", 1);
            frontBow = layer("$name.Legs", "7Legs/", 1);
            eyes = layer("$name.Torso", "8Torso/", 1);
            eyebrows = layer("$name.Capes", "9Capes/", 1)..slaveTo(bowBack);
            mouth = layer("$name.Wings", "10Wings/", 1);
            hairFront = layer("$name.Tail", "11Tail/", 1);
            glasses = layer("$name.FX", "12FX/", 1);


        }
    }

    @override
    Doll hatch() {

        MagicalDoll girl = new MagicalDoll();
        girl.copyPalette(palette);
        //same color, same layers (but don't go over max)

        if(girl.hairBack.maxImageNumber == 0) {
            girl.hairBack.imgNumber = 0;
        }else {
            girl.hairBack.imgNumber = hairBack.imgNumber % girl.hairBack.maxImageNumber;
        }

        if(girl.bowBack.maxImageNumber == 0) {
            girl.bowBack.imgNumber = 0;
        }else {
            girl.bowBack.imgNumber = bowBack.imgNumber % girl.bowBack.maxImageNumber;
        }

        if(girl.body.maxImageNumber == 0) {
            girl.body.imgNumber = 0;
        }else {
            girl.body.imgNumber = body.imgNumber % girl.body.maxImageNumber;
        }

        if(girl.socks.maxImageNumber == 0) {
            girl.socks.imgNumber = 0;
        }else {
            girl.socks.imgNumber = socks.imgNumber % girl.socks.maxImageNumber;
        }

        if(girl.shoes.maxImageNumber == 0) {
            girl.shoes.imgNumber = 0;
        }else {
            girl.shoes.imgNumber = shoes.imgNumber % girl.shoes.maxImageNumber;
        }

        if(girl.skirt.maxImageNumber == 0) {
            girl.skirt.imgNumber = 0;
        }else {
            girl.skirt.imgNumber = skirt.imgNumber % girl.skirt.maxImageNumber;
        }

        if(girl.frontBow.maxImageNumber == 0) {
            girl.frontBow.imgNumber = 0;
        }else {
            girl.frontBow.imgNumber = frontBow.imgNumber % girl.frontBow.maxImageNumber;
        }

        if(girl.eyes.maxImageNumber == 0) {
            girl.eyes.imgNumber = 0;
        }else {
            girl.eyes.imgNumber = eyes.imgNumber % girl.eyes.maxImageNumber;
        }

        if(girl.eyebrows.maxImageNumber == 0) {
            girl.eyebrows.imgNumber = 0;
        }else {
            girl.eyebrows.imgNumber = eyebrows.imgNumber % girl.eyebrows.maxImageNumber;
        }

        if(girl.mouth.maxImageNumber == 0) {
            girl.mouth.imgNumber = 0;
        }else {
            girl.mouth.imgNumber = mouth.imgNumber % girl.mouth.maxImageNumber;
        }

        if(girl.hairFront.maxImageNumber == 0) {
            girl.hairFront.imgNumber = 0;
        }else {
            girl.hairFront.imgNumber = hairFront.imgNumber % girl.hairFront.maxImageNumber;
        }

        if(girl.glasses.maxImageNumber == 0) {
            girl.glasses.imgNumber = 0;
        }else {
            girl.glasses.imgNumber = glasses.imgNumber % girl.glasses.maxImageNumber;
        }

        //print("bird head is ${bird.head.imgNumber} and egg top was ${top.imgNumber}");
        return girl;

    }


}