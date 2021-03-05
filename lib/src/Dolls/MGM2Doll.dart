import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


//saving and loading isn't working .why?


class Magical2Doll extends Doll{

  @override
  String originalCreator = "Popo Merrygamz";

  @override
  int renderingType =48;

  @override
  int width = 390;
  @override
  int height = 390;

  @override
  String name = "Magical2";

  @override
  String relativefolder = "images/MGM2";

  late SpriteLayer body;
  late SpriteLayer eyes;
  late SpriteLayer mouth;
  late SpriteLayer glasses;
  late SpriteLayer hairBack;
  late SpriteLayer hairFront;

  List<String> jrs_skin_collection = <String>["#CFCFCF","#FFDBAC", "#F1C27D" ,"#E0AC69" ,"#C68642", "#8D5524"];
  List<String> human_hair_colors = <String>["#FFD4DB", "#8CBCCA", "#BF6C80", "#F7DA7C", "#735A77","#2C222B", "#FFF5E1", "#B89778", "#A56B46", "#B55239", "#8D4A43", "#3B3024", "#504444","#68410a", "#fffffe", "#000000", "#000000", "#000000", "#f3f28d", "#cf6338", "#feffd7", "#fff3bd", "#724107", "#382207", "#ff5a00", "#3f1904", "#ffd46d", "#473200", "#91683c"];

  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack,body, eyes, mouth,hairFront,glasses];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[hairBack,body, eyes, mouth,hairFront,glasses];

  @override
  Palette palette = new CookiePalette()
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

  @override
  Palette paletteSource = ReferenceColours.COOKIE_PALETTE;


  Magical2Doll() {
    initLayers();
    randomize();
  }

  void randomizeColors() {
    if(rand == null) rand = new Random();;
    List<Palette> paletteOptions = new List<Palette>.from(ReferenceColours.paletteList.values);

    Palette newPallete = rand.pickFrom(paletteOptions)!;
    if(newPallete == ReferenceColours.INK) {
      super.randomizeColors();
    }else {
      copyPalette(newPallete);
    }
    CookiePalette hp = palette as CookiePalette;
    hp.skin = new Colour.fromStyleString(rand.pickFrom(jrs_skin_collection));
    makeOtherColorsDarker(hp, "skin", <String>["skinDark"]);
    //hp.eye_white_right = new Colour(255,255,255);
   // hp.eye_white_left = new Colour(255,255,255);

    if(newPallete != ReferenceColours.SKETCH) hp.add("hairMain",new Colour.fromStyleString(rand.pickFrom(human_hair_colors)),true);
    makeOtherColorsDarker(hp, "hairMain",<String>["hairDark"]);
  }

  @override
  void randomizeNotColors() {
    for(SpriteLayer l in renderingOrderLayers) {
      l.imgNumber = rand.nextInt(l.maxImageNumber+1);
    }
  }

  @override
  void setQuirk() {
    Random rand  = new Random(seed);
    quirkButDontUse = Quirk.randomHumanQuirk(rand);

  }

  void makeOtherColorsDarker(Palette p, String sourceKey, List<String> otherColorKeys) {
    String referenceKey = sourceKey;
    //print("$name, is going to make other colors darker than $sourceKey, which is ${p[referenceKey]}, other colors are $otherColorKeys");
    for(String key in otherColorKeys) {
      //print("$name is going to make $key darker than $sourceKey");
      p.add(key, new Colour(p[referenceKey].red, p[referenceKey].green, p[referenceKey].blue)..setHSV(p[referenceKey].hue, p[referenceKey].saturation, 2*p[referenceKey].value / 3), true);
      //print("$name made  $key darker than $referenceKey, its ${p[key]}");

      referenceKey = key; //each one is progressively darker
    }
  }

  @override
  void initLayers() {
    //List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack,body, eyes, mouth,hairFront];

    hairBack = layer("Magical2.HairBack", "HairBack/", 1);//new SpriteLayer("Torso","$folder/Torso/", 1, maxTorso);
    body = layer("Magical2.Body", "Body/", 1);
    glasses = layer("Magical2.Glasses", "Glasses/", 1);
    eyes = layer("Magical2.Eyes", "Eyes/", 1);//new SpriteLayer("Torso","$folder/Torso/", 1, maxTorso);
    mouth = layer("Magical2.Mouth", "Mouth/", 1);//new SpriteLayer("Head","$folder/Head/", 1, maxHead);
    hairFront = layer("Magical2.HairFront", "HairFront/", 1)..slaveTo(hairBack);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLegs);
  }



}
