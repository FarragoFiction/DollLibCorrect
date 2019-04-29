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
    SpriteLayer notHairFront;
    SpriteLayer head;
    SpriteLayer arms;
    SpriteLayer skirt;
    SpriteLayer clothing;
    SpriteLayer legs;
    SpriteLayer torso;
    SpriteLayer notHairBack;
    SpriteLayer wings;
    SpriteLayer tail;
    SpriteLayer fx;


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
            headDecorations = layer("$name.HeadDecorations", "1HeadDecorations/", 1);
            notHairFront = layer("$name.Nothair", "2Nothair/", 1);
            head = layer("$name.Head", "3Head/", 1);
            arms = layer("$name.Arms", "4Arms/", 1);
            skirt = layer("$name.Skirts", "5Skirts/", 1);
            clothing = layer("$name.Clothing", "6Clothing/", 1);
            legs = layer("$name.Legs", "7Legs/", 1);
            torso = layer("$name.Torso", "8Torso/", 1);
            notHairBack = layer("$name.NothairBack", "9NothairBack/", 1)..slaveTo(notHairFront);
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