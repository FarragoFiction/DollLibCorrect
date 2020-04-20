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
    static RegExp numberedFilePattern = new RegExp("([a-zA-Z_]+?)(\\d+?)\\.");

    static Future<Map<String,dynamic>> generateAllData() async {
        Map<String, dynamic> ret = new Map<String,dynamic>();
        for(int type in Doll.allDollTypes) {
            Doll doll = Doll.randomDollOfType(type);
            if(!(doll is NamedLayerDoll)) {
                ret[doll.name] = new Map<String,dynamic>();
                ret[doll.name] ["layers"] = doll.toDollDataLayers();
                ret[doll.name] ["urls"] = doll.toDollDataLayersURLs();
            }

        }
        for(String key in ret.keys) {
            print("key is $key, ret[key] is ${ret[key]}");
            await processLayersForDollData(ret[key]);
        }
        print("going to return $ret with keys ${ret.keys}");
        return ret;

    }

    static Future<void> processLayersForDollData(Map<String, dynamic> map)async {
        for(String key in map["urls"].keys) {
            //will be the same key for both urls and layers
            //get the max number
            print("key for url is $key");
            int maxNum = await getMaxNumber(map["urls"][key]);
            print("max num is $maxNum");
            map["layers"][key] = maxNum;
        }
    }

    static int getMaxNumber(String url) {
        return 85;//test
    }

    static Future<List<String>> getDirectoryListing(String url) async {
        List<String> files = <String>[];
        String content = await HttpRequest.getString(url);
        Iterable<Match> matches = filePattern.allMatches(content); // find all link targets
        for (Match m in matches) {
            String filename = m.group(1);
            if (!extensionPattern.hasMatch(filename)) { continue; } // extension rejection

            //print(filename);

            files.add(filename);
        }

        return files;
    }

    int getHighestSequentialFile(List<String> files, String filename) {
        List<int> numbers = <int>[];

        for (String file in files) {
            Match m = numberedFilePattern.firstMatch(file);
            if (m == null) { continue; }

            if (m.group(1) == filename) {
                numbers.add(int.parse(m.group(2)));
            }
        }

        numbers.sort();

        int current = 0;
        int expected = 1;

        for (int n in numbers) {
            if (n == expected) {
                expected++;
                current = n;
            } else {
                break;
            }
        }

        return current;
    }
}