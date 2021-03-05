import 'dart:html';

import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:DollLibCorrect/src/Dolls/Doll.dart';

abstract class DollDataGenerator {

    static List<String> extensions = <String>[
        "png",
        "gif",
        "jpg",
        "jpeg",
    ];
    static RegExp filePattern = new RegExp('<a href="([^?]*?)">');
    static RegExp extensionPattern = new RegExp("\\\.(${extensions.join("|")})\$");

    static Future<Map<String,dynamic>> generateAllData() async {
        Map<String, dynamic> ret = new Map<String,dynamic>();
        for(int type in Doll.allDollTypes) {
            Doll doll = Doll.randomDollOfType(type);
            if(!(doll is NamedLayerDoll)) {
                ret[doll.name] = new Map<String,dynamic>();
                ret[doll.name] ["layers"] = doll.toDollDataLayers();
                ret[doll.name] ["urls"] = doll.toDollDataLayersURLs();
                if(doll.name == "Troll") {
                    ret[doll.name]["defaultBody"]= 48;
                    ret[doll.name]["mutantEyes"]= [2,11,31,44,46,47,85];
                    ret[doll.name]["bannedBodies"]= [238,252,256,259,235,226,227,230,96,219,221,223,5,11,14,43,50,59,65,66,67,70,72,75,74,98,100,101,102,106,107,109,63,17];
                }else if(doll.name == "Lamia") {
                    ret[doll.name]["seaDwellerBodies"]= [7,8,9,12,13,27,28,29,34,35,39,40,46,50,51,52,60,61,78];
                }else if(doll.name == "Grub") {
                    ret[doll.name]["landDwellerBodies"]= [0,1,2,3,4,5,6,7,8];
                    ret[doll.name]["seaDwellerBodies1"]= [9,10,11,12,13,14,15,16,17];
                    ret[doll.name]["seaDwellerBodies2"]= [18,19,20,21,22,23,24,26,26];
                    ret[doll.name]["upsideDownBodies"]= [7,8,26,25,16,17];
                }
            }else {
                if(doll.name == "Queen") {
                    ret[doll.name] = new Map<String,dynamic>();
                    ret[doll.name]["parts"]= [
                        "Bird",
                        "Bug",
                        "Buggy_As_Fuck_Retro_Game",
                        "Butler",
                        "Cat",
                        "Chihuahua",
                        "Chinchilla",
                        "Clippy",
                        "Cow",
                        "Cowboy",
                        "Doctor",
                        "Dutton",
                        "Fly",
                        "Game_Bro",
                        "Game_Grl",
                        "Gerbil",
                        "Github",
                        "Golfer",
                        "Google",
                        "Horse",
                        "Husky",
                        "Internet_Troll",
                        "Kid_Rock",
                        "Librarian",
                        "Llama",
                        "Mosquito",
                        "Nic_Cage",
                        "Penguin",
                        "Pitbull",
                        "Pomeranian",
                        "Pony",
                        "Praying_Mantis",
                        "Rabbit",
                        "Robot",
                        "Sleuth",
                        "Sloth",
                        "Tissue",
                        "Web_Comic_Creator",
                        "Pigeon",
                        "Octopus",
                        "Worm",
                        "Kitten",
                        "Fish"
                        ];
                }
            }
        }
        for(String key in ret.keys) {
            print("key is $key");
            if(key != "Queen") {
                await processLayersForDollData(ret[key]);
            }
        }
        print("going to return $ret with keys ${ret.keys}");
        return ret;

    }

    static Future<void> processLayersForDollData(Map<String, dynamic> map)async {
        for(String key in map["urls"].keys) {
            //will be the same key for both urls and layers
            //get the max number
            int maxNum = await getMaxNumber(map["urls"][key]);
            print("Max num for $key is $maxNum");
            map["layers"][key] = maxNum;
        }
        map.remove("urls");
    }

    static Future<int> getMaxNumber(String url)async {
        List<String> files = await getDirectoryListing(url);
        //print("url was $url and files is $files");
        return getHighestSequentialFile(files);
   }

    static Future<List<String>> getDirectoryListing(String url) async {
        List<String> files = <String>[];
        String content = await HttpRequest.getString("http://www.farragofiction.com/DollSource/$url");
        Iterable<Match> matches = filePattern.allMatches(content); // find all link targets
        for (Match m in matches) {
            String filename = m.group(1)!;
            if (!extensionPattern.hasMatch(filename)) { continue; } // extension rejection

            //print(filename);

            files.add(filename);
        }

        return files;
    }

    static int getHighestSequentialFile(List<String> files) {
        List<int> numbers = <int>[];
        for (String file in files) {
            List<String> parts = file.split(".png");
            if(parts.length > 0) {
                int? number;
                try {
                    number = int.tryParse(parts[0]);
                } catch(e) {
                    // no-op
                }
                if(number != null) numbers.add(number);
            }
        }

        numbers.sort();
       // print("JRTEST: for ${files.length} files, numbers are $numbers");
        return numbers.last;
    }
}