import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/word_view.dart';

const String apiKey = 'B0DB7FCD59EDC9A6BC5C941FC93232ED';
const String certKey = '3422';
const String apiSearchUrl = 'https://stdict.korean.go.kr/api/search.do';
const String apiViewUrl = 'https://stdict.korean.go.kr/api/view.do';

//상세검색
const String num = '50'; // 검색 개수
const String advanced = 'y'; // yes
String method = 'exact'; // 검색값

void getPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('method') ?? true) {
    method = 'exact';
  } else {
    method = 'include';
  }
}

class WordRandomViewSearch {
  Future<dynamic> getWords(String num) async {
    var wordData = await getData(
        '$apiViewUrl?key=$apiKey&type_search=view&req_type=json&method=TARGET_CODE&q=$num');
    //print('apiView 완료');
    return wordData;
  }

  //https://stdict.korean.go.kr/api/view.do?certkey_no=3422&key=B0DB7FCD59EDC9A6BC5C941FC93232ED&type_search=view&req_type=json&method=WORD_INFO&q=나무1
  Future getData(String url) async {
    //print('Calling url: $url');
    Response response = await get(Uri.parse(url));
    //print('View get 완료');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //print('에러코드 : ${response.statusCode}');
    }
  }
}

class WordViewSearch {
  Future<dynamic> getWords(String query, String num) async {
    var wordData = await getData(
        '$apiViewUrl?key=$apiKey&type_search=view&req_type=json&method=WORD_INFO&q=$query$num');
    // if (wordData != null) {
    //   //print('apiView 완료');
    //   //print('$wordData 완료');
    // } else {
    //   //print('null error');
    // }
    return wordData;
  }

  Future<dynamic> getWordsTargetCode(String targetCode) async {
    var wordData = await getData(
        '$apiViewUrl?key=$apiKey&type_search=view&req_type=json&method=TARGET_CODE&q=$targetCode');
    //print('apiView 완료');
    return wordData;
  }

  //https://stdict.korean.go.kr/api/view.do?certkey_no=3422&key=B0DB7FCD59EDC9A6BC5C941FC93232ED&type_search=view&req_type=json&method=WORD_INFO&q=나무1
  Future getData(String url) async {
    //print('Calling url: $url');
    Response response = await get(Uri.parse(url));
    //print('View get 완료');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //print('에러코드 : ${response.statusCode}');
    }
  }
}

class WordSearch {
  Future<dynamic> getWords(String query) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //String method = prefs.getString('method') ?? 'exact';
    var wordData = await getData('$apiSearchUrl?key=$apiKey&num=$num&req_type=json&q=$query');
    //var wordData = await getData('$apiSearchUrl?key=$apiKey&num=$num&req_type=json&advanced=$advanced&method=$method&q=$query');
    //print('apiSearch 완료');
    return wordData;
  }

  Future getData(String url) async {
    //print('Calling url: $url');
    Response response = await get(Uri.parse(url));
    //print('Search get 완료');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //print('에러코드 : ${response.statusCode}');
    }
  }
}

Future<WordView> getWordViewData({String? query, String? num, String? targetCode}) async {
  String wordJsonView;
  if (num != null) {
    wordJsonView = await WordViewSearch().getWords(query!, num);
    //print('view num');
  } else {
    wordJsonView = await WordViewSearch().getWordsTargetCode(targetCode!);
    //print('view targetcode');
  }
  //print('view받아오고');
  WordView wordViewData = WordView.fromJson(jsonDecode(wordJsonView));
  //isLoading = false;
  //print('view변경');
  return wordViewData;
}
