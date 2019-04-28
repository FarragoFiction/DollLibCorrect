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
            eyebrows = layer("$name.Capes", "9Capes/", 1);;
            mouth = layer("$name.Wings", "10Wings/", 1);
            hairFront = layer("$name.Tail", "11Tail/", 1);
            glasses = layer("$name.FX", "12FX/", 1);


        }
    }


}