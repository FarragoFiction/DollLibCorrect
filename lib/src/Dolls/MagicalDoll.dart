import 'package:DollLibCorrect/src/Dolls/MonsterGirlDoll.dart';

import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


//saving and loading isn't working .why?


class MagicalDoll extends HatchableDoll{

  @override
  String originalCreator = "Popo Merrygamz";

  @override
  int renderingType =45;

  @override
  int width = 600;
  @override
  int height = 600;

  @override
  String name = "MagicalDoll";

  @override
  String relativefolder = "images/MagicalDoll";
  @override
  bool facesRight = false;
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

  //definitely doesn't sound creepy
  //wait i can make worse
  List<String> jrs_skin_collection = <String>["#CFCFCF","#FFDBAC", "#F1C27D" ,"#E0AC69" ,"#C68642", "#8D5524"];
  List<String> human_hair_colors = <String>["#FFD4DB", "#8CBCCA", "#BF6C80", "#F7DA7C", "#735A77","#2C222B", "#FFF5E1", "#B89778", "#A56B46", "#B55239", "#8D4A43", "#3B3024", "#504444","#68410a", "#fffffe", "#000000", "#000000", "#000000", "#f3f28d", "#cf6338", "#feffd7", "#fff3bd", "#724107", "#382207", "#ff5a00", "#3f1904", "#ffd46d", "#473200", "#91683c"];

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

  Palette pinkGirl = new HomestuckPalette()
    ..aspect_light = '#fffdde'
    ..aspect_dark = '#eee495'
    ..shoe_light = '#ff2a5b'
    ..shoe_dark = '#c5002d'
    ..cloak_light = '#d11575'
    ..cloak_mid = '#f169b6'
    ..cloak_dark = '#aa004d'
    ..shirt_light = '#f587d6'
    ..shirt_dark = '#eb6ab4'
    ..pants_light = '#eb1f85'
    ..pants_dark = '#d21f5a';

  Palette blueGirl = new HomestuckPalette()
    ..shirt_light = '#73dafe'
    ..shirt_dark = '#52b0dc'
    ..pants_light = '#3965e4'
    ..pants_dark = '#1933cc'
    ..aspect_light = '#c4fcf3'
    ..aspect_dark = '#78f1e4'
    ..cloak_light = '#3babef'
    ..cloak_mid = '#0060cb'
    ..cloak_dark = '#0060cb'
    ..shoe_light = '#2538bd'
    ..shoe_dark = '#000785'
  ;

  Palette orangeGirl = new HomestuckPalette()
    ..shirt_light = '#f9ed8c'
    ..shirt_dark = '#e1bc54'
    ..pants_light = '#f08c00'
    ..pants_dark = '#d36a00'
    ..aspect_light = '#fac100'
    ..aspect_dark = '#dc8300'
    ..cloak_light = '#fdcb00'
    ..cloak_mid = '#fae74e'
    ..cloak_dark = '#d88000'
    ..shoe_light = '#ff6200'
    ..shoe_dark = '#b93700'
  ;

  Palette greenGirl = new HomestuckPalette()
    ..shirt_light = '#00a25b'
    ..shirt_dark = '#008a4d'
    ..pants_light = '#00533b'
    ..pants_dark = '#002422'
    ..aspect_light = '#97f1c7'
    ..aspect_dark = '#3ec78f'
    ..cloak_light = '#45dcab'
    ..cloak_mid = '#8cf8ab'
    ..cloak_dark = '#16b683'
    ..shoe_light = '#00b889'
    ..shoe_dark = '#008465';

  Palette purpleGirl = new HomestuckPalette()
    ..shirt_light = '#2a1932'
    ..shirt_dark = '#13041a'
    ..pants_light = '#13041a'
    ..pants_dark = '#522665'
    ..aspect_light = '#f7effe'
    ..aspect_dark = '#cfa5f0'
    ..cloak_light = '#7820ae'
    ..cloak_mid = '#9c00cb'
    ..cloak_dark = '#570093'
    ..shoe_light = '#480080'
    ..shoe_dark = '#2a004c';


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
    //TODO add the magical palettes
    List<Palette> betterOptions = <Palette>[];
    betterOptions.add(pinkGirl);
    betterOptions.add(blueGirl);
    betterOptions.add(greenGirl);
    betterOptions.add(orangeGirl);
    betterOptions.add(purpleGirl);

    Palette newPallete = rand.pickFrom(paletteOptions);
    if(rand.nextDouble()>0.6) {
      newPallete = rand.pickFrom(betterOptions);
    }
    if(newPallete == ReferenceColours.INK) {
      super.randomizeColors();
    }else {
      copyPalette(newPallete);
    }
    HomestuckPalette hp = palette as HomestuckPalette;
    hp.skin = new Colour.fromStyleString(rand.pickFrom(jrs_skin_collection));
    hp.eye_white_right = new Colour(255,255,255);
    hp.eye_white_left = new Colour(255,255,255);

    if(newPallete != ReferenceColours.SKETCH) hp.add("hairMain",new Colour.fromStyleString(rand.pickFrom(human_hair_colors)),true);

  }

  @override
  void randomizeNotColors() {
    for(SpriteLayer l in renderingOrderLayers) {
      l.imgNumber = rand.nextInt(l.maxImageNumber)+1;
    }
  }

  @override
  void initLayers() {

    {
      hairBack = layer("$name.HairBack", "HairBack/", 1);
      bowBack = layer("$name.BowBack", "BowBack/", 1);
      body = layer("$name.Body", "Body/", 1);
      socks = layer("$name.Socks", "Socks/", 1);
      shoes = layer("$name.Shoes", "Shoes/", 1);
      skirt = layer("$name.Skirt", "Skirt/", 1);
      //HEY FUTURE JR, JUST BECAUSE THEY BOTH ARE NAMED 'BOW' DOESN'T MEAN THEY SHOULD BE SLAVED TO EACH OTHER
      frontBow = layer("$name.BowFront", "BowFront/", 1);
      eyes = layer("$name.Eyes", "Eyes/", 1);
      eyebrows = layer("$name.Eyebrows", "Eyebrows/", 1);;
      mouth = layer("$name.Mouth", "Mouth/", 1);
      hairFront = layer("$name.HairFront", "HairFront/", 1)..slaveTo(hairBack);
      glasses = layer("$name.Glasses", "Glasses/", 1);


    }
  }

  @override
  Doll hatch() {

    MonsterGirlDoll monster = new MonsterGirlDoll();
    monster.copyPalette(palette);
    //same color, same layers (but don't go over max)

    if(monster.headDecorations.maxImageNumber == 0) {
      monster.headDecorations.imgNumber = 0;
    }else {
      monster.headDecorations.imgNumber = bowBack.imgNumber % monster.headDecorations.maxImageNumber;
    }

    if(monster.notHairBack.maxImageNumber == 0) {
      monster.notHairBack.imgNumber = 0;
    }else {
      monster.notHairBack.imgNumber = hairBack.imgNumber % monster.notHairBack.maxImageNumber;
    }

    if(monster.head.maxImageNumber == 0) {
      monster.head.imgNumber = 0;
    }else {
      monster.head.imgNumber = body.imgNumber % monster.head.maxImageNumber;
    }

    if(monster.clothing.maxImageNumber == 0) {
      monster.clothing.imgNumber = 0;
    }else {
      monster.clothing.imgNumber = socks.imgNumber % monster.clothing.maxImageNumber;
    }



    if(monster.arms.maxImageNumber == 0) {
      monster.arms.imgNumber = 0;
    }else {
      monster.arms.imgNumber = shoes.imgNumber % monster.arms.maxImageNumber;
    }

    if(monster.skirt.maxImageNumber == 0) {
      monster.skirt.imgNumber = 0;
    }else {
      monster.skirt.imgNumber = skirt.imgNumber % monster.skirt.maxImageNumber;
    }



    if(monster.legs.maxImageNumber == 0) {
      monster.legs.imgNumber = 0;
    }else {
      monster.legs.imgNumber = frontBow.imgNumber % monster.legs.maxImageNumber;
    }

    if(monster.torso.maxImageNumber == 0) {
      monster.torso.imgNumber = 0;
    }else {
      monster.torso.imgNumber = eyes.imgNumber % monster.torso.maxImageNumber;
    }

    if(monster.wings.maxImageNumber == 0) {
      monster.wings.imgNumber = 0;
    }else {
      monster.wings.imgNumber = eyebrows.imgNumber % monster.wings.maxImageNumber;
    }

    if(monster.tail.maxImageNumber == 0) {
      monster.tail.imgNumber = 0;
    }else {
      monster.tail.imgNumber = mouth.imgNumber % monster.tail.maxImageNumber;
    }

    if(monster.notHairFront.maxImageNumber == 0) {
      monster.notHairFront.imgNumber = 0;
    }else {
      monster.notHairFront.imgNumber = hairFront.imgNumber % monster.notHairFront.maxImageNumber;
    }

    if(monster.fx.maxImageNumber == 0) {
      monster.fx.imgNumber = 0;
    }else {
      monster.fx.imgNumber = glasses.imgNumber % monster.fx.maxImageNumber;
    }

    //print("bird head is ${bird.head.imgNumber} and egg top was ${top.imgNumber}");
    return monster;

  }

}

