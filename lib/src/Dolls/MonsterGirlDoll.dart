import 'package:DollLibCorrect/DollRenderer.dart';

class MonsterGirlDoll extends MagicalDoll {
    @override
    String originalCreator = "yearnfulNode, karmicRetribution, insufferableOracle, and nebulousHarmony";

    @override
    int renderingType =427;
    @override
    bool facesRight = false;
    @override
    int width = 600;
    @override
    int height = 600;

    @override
    String name = "MonsterDoll";

    @override
    String relativefolder = "images/MonsterDoll";

    // yes technically its not REALLY these things. But it sure does make the transformation easier.
    late SpriteLayer headDecorations;
    late SpriteLayer notHairFront;
    late SpriteLayer head;
    late SpriteLayer arms;
    late SpriteLayer skirt;
    late SpriteLayer clothing;
    late SpriteLayer legs;
    late SpriteLayer torso;
    late SpriteLayer notHairBack;
    late SpriteLayer wings;
    late SpriteLayer tail;
    late SpriteLayer fx;


    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[fx,tail,wings, notHairBack, torso, legs, clothing, skirt, arms, head, notHairFront, headDecorations];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[fx,tail,wings, notHairBack, torso, legs, clothing, skirt, arms, head, notHairFront, headDecorations];

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

        MagicalDoll monster = new MagicalDoll();
        monster.copyPalette(palette);
        //same color, same layers (but don't go over max)

        if(monster.bowBack.maxImageNumber == 0) {
            monster.bowBack.imgNumber = 0;
        }else {
            monster.bowBack.imgNumber = headDecorations.imgNumber % monster.bowBack.maxImageNumber;
        }

        if(monster.hairBack.maxImageNumber == 0) {
            monster.hairBack.imgNumber = 0;
        }else {
            monster.hairBack.imgNumber = notHairBack.imgNumber % monster.hairBack.maxImageNumber;
        }

        if(monster.body.maxImageNumber == 0) {
            monster.body.imgNumber = 0;
        }else {
            monster.body.imgNumber = head.imgNumber % monster.body.maxImageNumber;
        }

        if(monster.socks.maxImageNumber == 0) {
            monster.socks.imgNumber = 0;
        }else {
            monster.socks.imgNumber = clothing.imgNumber % monster.socks.maxImageNumber;
        }



        if(monster.shoes.maxImageNumber == 0) {
            monster.shoes.imgNumber = 0;
        }else {
            monster.shoes.imgNumber = arms.imgNumber % monster.shoes.maxImageNumber;
        }

        if(monster.skirt.maxImageNumber == 0) {
            monster.skirt.imgNumber = 0;
        }else {
            monster.skirt.imgNumber = skirt.imgNumber % monster.skirt.maxImageNumber;
        }



        if(monster.frontBow.maxImageNumber == 0) {
            monster.frontBow.imgNumber = 0;
        }else {
            monster.frontBow.imgNumber = legs.imgNumber % monster.frontBow.maxImageNumber;
        }

        if(monster.eyes.maxImageNumber == 0) {
            monster.eyes.imgNumber = 0;
        }else {
            monster.eyes.imgNumber = torso.imgNumber % monster.eyes.maxImageNumber;
        }

        if(monster.eyebrows.maxImageNumber == 0) {
            monster.eyebrows.imgNumber = 0;
        }else {
            monster.eyebrows.imgNumber = wings.imgNumber % monster.eyebrows.maxImageNumber;
        }

        if(monster.mouth.maxImageNumber == 0) {
            monster.mouth.imgNumber = 0;
        }else {
            monster.mouth.imgNumber = tail.imgNumber % monster.mouth.maxImageNumber;
        }

        if(monster.hairFront.maxImageNumber == 0) {
            monster.hairFront.imgNumber = 0;
        }else {
            monster.hairFront.imgNumber = notHairFront.imgNumber % monster.hairFront.maxImageNumber;
        }

        if(monster.glasses.maxImageNumber == 0) {
            monster.glasses.imgNumber = 0;
        }else {
            monster.glasses.imgNumber = fx.imgNumber % monster.glasses.maxImageNumber;
        }

        //print("bird head is ${bird.head.imgNumber} and egg top was ${top.imgNumber}");
        return monster;

    }

}
