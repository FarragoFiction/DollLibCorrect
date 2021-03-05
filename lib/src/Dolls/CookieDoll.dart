import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


//saving and loading isn't working .why?


class CookieDoll extends Doll{

  @override
  String originalCreator = "Popo Merrygamz";

  @override
  int renderingType =47;

  @override
  int width = 600;
  @override
  int height = 600;

  @override
  String name = "Cookie";
  @override
  bool facesRight = false;
  @override
  String relativefolder = "images/Cookie";

  late SpriteLayer body;
  late SpriteLayer eyes;
  late SpriteLayer mouth;
  late SpriteLayer hairBack;
  late SpriteLayer hairFront;

  List<String> jrs_skin_collection = <String>["#CFCFCF","#FFDBAC", "#F1C27D" ,"#E0AC69" ,"#C68642", "#8D5524"];
  List<String> human_hair_colors = <String>["#FFD4DB", "#8CBCCA", "#BF6C80", "#F7DA7C", "#735A77","#2C222B", "#FFF5E1", "#B89778", "#A56B46", "#B55239", "#8D4A43", "#3B3024", "#504444","#68410a", "#fffffe", "#000000", "#000000", "#000000", "#f3f28d", "#cf6338", "#feffd7", "#fff3bd", "#724107", "#382207", "#ff5a00", "#3f1904", "#ffd46d", "#473200", "#91683c"];

  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack,body, eyes, mouth,hairFront];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[hairBack,body, eyes, mouth,hairFront];

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


  CookieDoll() {
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
    hp.eye_white_right = new Colour(255,255,255);
    hp.eye_white_left = new Colour(255,255,255);

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

    hairBack = layer("Cookie.HairBack", "HairBack/", 1);//new SpriteLayer("Torso","$folder/Torso/", 1, maxTorso);
    body = layer("Cookie.Body", "Body/", 1);//new SpriteLayer("Torso","$folder/Torso/", 1, maxTorso);
    eyes = layer("Cookie.Eyes", "Eyes/", 1);//new SpriteLayer("Torso","$folder/Torso/", 1, maxTorso);
    mouth = layer("Cookie.Mouth", "Mouth/", 1);//new SpriteLayer("Head","$folder/Head/", 1, maxHead);
    hairFront = layer("Cookie.HairFront", "HairFront/", 1)..slaveTo(hairBack);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLegs);
  }



}

class CookiePalette extends HomestuckPalette {
  static String _ACCENT = "accent";
  static String _ACCENT2 = "accent2";
  static String _ASPECT_LIGHT = "aspect1";
  static String _SKINDARK = "skinDark";
  static String _ASPECT_DARK = "aspect2";
  static String _SHOE_LIGHT = "shoe1";
  static String _SHOE_DARK = "shoe2";
  static String _CLOAK_LIGHT = "cloak1";
  static String _CLOAK_MID = "cloak2";
  static String _CLOAK_DARK = "cloak3";
  static String _SHIRT_LIGHT = "shirt1";
  static String _SHIRT_DARK = "shirt2";
  static String _PANTS_LIGHT = "pants1";
  static String _PANTS_DARK = "pants2";
  static String _HAIR_MAIN = "hairMain";
  static String _HAIR_ACCENT = "hairAccent";
  static String _HAIR_ACCENT2 = "hairAccent2";
  static String _MOUTH = "mouth";
  static String _HAIR_DARK = "hairDark";
  static String _EYE_WHITES = "eyeWhites";
  static String _SKIN = "skin";

  static Colour _handleInput(Object input) {
    if (input is Colour) {
      return input;
    }
    if (input is int) {
      return new Colour.fromHex(input, input
          .toRadixString(16)
          .padLeft(6, "0")
          .length > 6);
    }
    if (input is String) {
      if (input.startsWith("#")) {
        return new Colour.fromStyleString(input);
      } else {
        return new Colour.fromHexString(input);
      }
    }
    throw "Invalid AspectPalette input: colour must be a Colour object, a valid colour int, or valid hex string (with or without leading #)";
  }

  Colour get skinDark => this[_SKINDARK];

  void set skinDark(dynamic c) => this.add(_SKINDARK, _handleInput(c), true);

  Colour get hairDark => this[_HAIR_DARK];

  void set hairDark(dynamic c) => this.add(_HAIR_DARK, _handleInput(c), true);

  Colour get hairAccent2 => this[_HAIR_ACCENT2];

  void set hairAccent2(dynamic c) => this.add(_HAIR_ACCENT2, _handleInput(c), true);

  Colour get accent2 => this[_ACCENT2];

  void set accent2(dynamic c) => this.add(_HAIR_DARK, _handleInput(c), true);

  Colour get mouth => this[_MOUTH];

  void set mouth(dynamic c) => this.add(_MOUTH, _handleInput(c), true);
}
