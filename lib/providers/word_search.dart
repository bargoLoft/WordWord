import 'package:http/http.dart';

const String apiKey = 'B0DB7FCD59EDC9A6BC5C941FC93232ED';
const String certKey = '3422';
const String apiUrl = 'https://stdict.korean.go.kr/api/search.do';

class WordSearch {
  Future<dynamic> getWords(String query) async {
    var wordData =
        await getData('$apiUrl?key=$apiKey&num=50&req_type=json&q=$query');
    print('api 완료');
    return wordData;
  }

  Future getData(String url) async {
    print('Calling url: $url');
    Response response = await get(Uri.parse(url));
    print('get 완료');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('에러코드 : ${response.statusCode}');
    }
  }
}
