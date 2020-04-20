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
            }

        }
        for(String key in ret.keys) {
            print("key is $key");
            await processLayersForDollData(ret[key]);
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
            String filename = m.group(1);
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
                final int number = int.parse(parts[0],onError: (e) => null);
                if(number != null) numbers.add(number);
            }
        }

        numbers.sort();
       // print("JRTEST: for ${files.length} files, numbers are $numbers");
        return numbers.last;
    }
}