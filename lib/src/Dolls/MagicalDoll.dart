import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


//saving and loading isn't working .why?


class MagicalDoll extends Doll{

  @override
  String originalCreator = "Popo Merrygamz";

  @override
  int renderingType =45;

  @override
  int width = 600;
  @override
  int height = 600;

  @override
  String name = "MagicalDolls";

  @override
  String relativefolder = "images/MagicalDolls";

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
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack, bowBack, body, socks, shoes, skirt,frontBow, eyes, eyebrows, mouth,hairFront, glasses];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[hairBack, bowBack, body, socks, shoes, skirt,frontBow, eyes, eyebrows, mouth,hairFront, glasses];

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
    ..eye_white_left = '#000000'
    ..eye_white_right = '#000000'
    ..pants_dark = '#ADADAD'
    ..hair_main = '#000000'
    ..hair_accent = '#ADADAD'
    ..skin = '#fdca0d';


  MagicalDoll() {
    initLayers();
    randomize();
  }

  //HELL YES i found the source of the save bug.
  //i'm not supposed to use premade palettes like this, instead,
  //how does the drop downs work?
  @override
  void randomizeColors() {
            if(rand == null) rand = new Random();;
    List<Palette> paletteOptions = new List<Palette>.from(ReferenceColours.paletteList.values);
    Palette newPallete = rand.pickFrom(paletteOptions);
    if(newPallete == ReferenceColours.INK) {
      super.randomizeColors();
    }else {
      copyPalette(newPallete);
    }
  }

  @override
  void randomizeNotColors() {
    for(SpriteLayer l in renderingOrderLayers) {
      l.imgNumber = rand.nextInt(l.maxImageNumber+1);
    }
  }

  @override
  void initLayers() {

    {
      /*
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
  SpriteLayer hair;
  SpriteLayer glasses;
       */
      hairBack = layer("$name.HairBack", "HairBack/", 1);//new SpriteLayer("Torso","$folder/Torso/", 1, maxTorso);
      bowBack = layer("$name.BowBack", "BowBack/", 1);//new SpriteLayer("Head","$folder/Head/", 1, maxHead);
      body = layer("$name.Body", "Body/", 1);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLegs);
      socks = layer("$name.Socks", "Socks/", 1);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLegs);
      shoes = layer("$name.Shoes", "Shoes/", 1);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLegs);
      skirt = layer("$name.Skirt", "Skirt/", 1);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLegs);
      frontBow = layer("$name.BowFront", "BowFront/", 1);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLegs);
      eyes = layer("$name.Eyes", "Eyes/", 1);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLegs);
      eyebrows = layer("$name.Eyebrows", "Eyebrows/", 1);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLegs);
      mouth = layer("$name.Mouth", "Mouth/", 1);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLegs);
      hairFront = layer("$name.HairFront", "HairFront/", 1);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLegs);
      glasses = layer("$name.Glasses", "Glasses/", 1);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLegs);


    }
  }

}

