import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:DollLibCorrect/src/Dolls/Doll.dart';

abstract class DollDataGenerator {

    static Future<Map<String,dynamic>> generateAllData() async {
        Map<String, dynamic> ret = new Map<String,dynamic>();
        for(int type in Doll.allDollTypes) {
            Doll doll = Doll.randomDollOfType(type);
            if(!(doll is NamedLayerDoll)) {
                ret[doll.name] = doll.toDollDataLayers();
            }

        }
        //TODO get the network data for max values
        print("going to return $ret with keys ${ret.keys}");
        return ret;

    }
}