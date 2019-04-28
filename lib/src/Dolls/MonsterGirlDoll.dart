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
            hairBack = layer("$name.1HeadDecorations", "1HeadDecorations/", 1);
            bowBack = layer("$name.2Whatever", "2Whatever/", 1);
            body = layer("$name.3Head", "3Head/", 1);
            socks = layer("$name.4Arms", "4Arms/", 1);
            shoes = layer("$name.5Skirts", "5Skirts/", 1);
            skirt = layer("$name.6Clothing", "6Clothing/", 1);
            frontBow = layer("$name.7Legs", "7Legs/", 1);
            eyes = layer("$name.8Torso", "8Torso/", 1);
            eyebrows = layer("$name.9Capes", "9Capes/", 1);;
            mouth = layer("$name.10Wings", "10Wings/", 1);
            hairFront = layer("$name.11Tail", "11Tail/", 1);
            glasses = layer("$name.12FX", "12FX/", 1);


        }
    }


}