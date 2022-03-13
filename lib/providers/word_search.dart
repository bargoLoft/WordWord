import 'package:http/http.dart';

const String apiKey = 'B0DB7FCD59EDC9A6BC5C941FC93232ED';
const String certKey = '3422';
const String apiSearchUrl = 'https://stdict.korean.go.kr/api/search.do';
const String apiViewUrl = 'https://stdict.korean.go.kr/api/view.do';

class WordRandomViewSearch {
  Future<dynamic> getWords(String num) async {
    var wordData = await getData(
        '$apiViewUrl?key=$apiKey&type_search=view&req_type=json&method=TARGET_CODE&q=$num');
    print('apiView 완료');
    return wordData;
  }

  //https://stdict.korean.go.kr/api/view.do?certkey_no=3422&key=B0DB7FCD59EDC9A6BC5C941FC93232ED&type_search=view&req_type=json&method=WORD_INFO&q=나무1
  Future getData(String url) async {
    print('Calling url: $url');
    Response response = await get(Uri.parse(url));
    print('View get 완료');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('에러코드 : ${response.statusCode}');
    }
  }
}

class WordViewSearch {
  Future<dynamic> getWords(String query, String num) async {
    var wordData = await getData(
        '$apiViewUrl?key=$apiKey&type_search=view&req_type=json&method=WORD_INFO&q=$query$num');
    print('apiView 완료');
    return wordData;
  }

  //https://stdict.korean.go.kr/api/view.do?certkey_no=3422&key=B0DB7FCD59EDC9A6BC5C941FC93232ED&type_search=view&req_type=json&method=WORD_INFO&q=나무1
  Future getData(String url) async {
    print('Calling url: $url');
    Response response = await get(Uri.parse(url));
    print('View get 완료');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('에러코드 : ${response.statusCode}');
    }
  }
}

class WordSearch {
  Future<dynamic> getWords(String query) async {
    var wordData = await getData(
        '$apiSearchUrl?key=$apiKey&num=50&req_type=json&q=$query');
    print('apiSearch 완료');
    return wordData;
  }

  Future getData(String url) async {
    print('Calling url: $url');
    Response response = await get(Uri.parse(url));
    print('Search get 완료');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('에러코드 : ${response.statusCode}');
    }
  }
}
