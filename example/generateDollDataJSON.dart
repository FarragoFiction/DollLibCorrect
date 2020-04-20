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
            }

        }
        //TODO get the network data for max values
        for(String key in ret.keys) {

        }
        print("going to return $ret with keys ${ret.keys}");
        return ret;

    }

    static processLayersForDollData(Map<String, dynamic> map) {

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