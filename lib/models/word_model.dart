/// channel : {"total":8,"num":10,"title":"표준 국어 대사전 개발 지원(Open API) - 사전  검색","start":1,"description":"표준 국어 대사전 개발 지원(Open API) – 사전 검색 결과","item":[{"sup_no":"1","word":"사과","target_code":"169066","sense":{"definition":"살이 연하고 달며 물이 많은 참외.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=169066&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"2","word":"사과","target_code":"169067","sense":{"definition":"조선 시대에, 오위(五衛)에 둔 정육품의 군직(軍職). 현직에 종사하고 있지 않은 문관, 무관 및 음관(蔭官)이 맡았다.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=169067&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"3","word":"사과","target_code":"441489","sense":{"definition":"소승 불교에서 이르는 깨달음의 네 단계. 수다원과, 사다함과, 아나함과, 아라한과의 단계가 있다.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=441489&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"4","word":"사과","target_code":"169068","sense":{"definition":"유학의 네 가지 학과. 덕행, 언어, 정사(政事), 문학을 이른다.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=169068&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"5","word":"사과","target_code":"441490","sense":{"definition":"사과나무의 열매.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=441490&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"6","word":"사과","target_code":"169069","sense":{"definition":"잘못을 용서함.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=169069&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"7","word":"사과","target_code":"169071","sense":{"definition":"박과의 한해살이 덩굴풀. 줄기는 덩굴손으로 다른 물건을 감고 올라간다. 잎은 손바닥 모양으로 5~7갈래 갈라지고 잎자루가 길다. 여름에 노란 꽃이 총상(總狀) 화서로 피고 열매는 원통 모양의 긴 장과(漿果)로 녹색이다. 열매 속의 섬유로는 수세미를 만들고 줄기의 액으로는 화장수를 만든다. 열대 아시아가 원산지이다.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=169071&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"8","word":"사과","target_code":"438135","sense":{"definition":"자기의 잘못을 인정하고 용서를 빎.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=438135&searchKeywordTo=3","type":"일반어"},"pos":"명사"}],"link":"https://stdict.korean.go.kr","lastbuilddate":"20220204185517"}

class WordModel {
  WordModel({
    Channel? channel,
  }) {
    _channel = channel;
  }

  WordModel.fromJson(dynamic json) {
    _channel =
        json['channel'] != null ? Channel.fromJson(json['channel']) : null;
  }
  Channel? _channel;

  Channel? get channel => _channel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_channel != null) {
      map['channel'] = _channel?.toJson();
    }
    return map;
  }
}

/// total : 8
/// num : 10
/// title : "표준 국어 대사전 개발 지원(Open API) - 사전  검색"
/// start : 1
/// description : "표준 국어 대사전 개발 지원(Open API) – 사전 검색 결과"
/// item : [{"sup_no":"1","word":"사과","target_code":"169066","sense":{"definition":"살이 연하고 달며 물이 많은 참외.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=169066&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"2","word":"사과","target_code":"169067","sense":{"definition":"조선 시대에, 오위(五衛)에 둔 정육품의 군직(軍職). 현직에 종사하고 있지 않은 문관, 무관 및 음관(蔭官)이 맡았다.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=169067&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"3","word":"사과","target_code":"441489","sense":{"definition":"소승 불교에서 이르는 깨달음의 네 단계. 수다원과, 사다함과, 아나함과, 아라한과의 단계가 있다.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=441489&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"4","word":"사과","target_code":"169068","sense":{"definition":"유학의 네 가지 학과. 덕행, 언어, 정사(政事), 문학을 이른다.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=169068&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"5","word":"사과","target_code":"441490","sense":{"definition":"사과나무의 열매.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=441490&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"6","word":"사과","target_code":"169069","sense":{"definition":"잘못을 용서함.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=169069&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"7","word":"사과","target_code":"169071","sense":{"definition":"박과의 한해살이 덩굴풀. 줄기는 덩굴손으로 다른 물건을 감고 올라간다. 잎은 손바닥 모양으로 5~7갈래 갈라지고 잎자루가 길다. 여름에 노란 꽃이 총상(總狀) 화서로 피고 열매는 원통 모양의 긴 장과(漿果)로 녹색이다. 열매 속의 섬유로는 수세미를 만들고 줄기의 액으로는 화장수를 만든다. 열대 아시아가 원산지이다.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=169071&searchKeywordTo=3","type":"일반어"},"pos":"명사"},{"sup_no":"8","word":"사과","target_code":"438135","sense":{"definition":"자기의 잘못을 인정하고 용서를 빎.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=438135&searchKeywordTo=3","type":"일반어"},"pos":"명사"}]
/// link : "https://stdict.korean.go.kr"
/// lastbuilddate : "20220204185517"

class Channel {
  Channel({
    int? total,
    int? num,
    String? title,
    int? start,
    String? description,
    List<Item>? item,
    String? link,
    String? lastbuilddate,
  }) {
    _total = total;
    _num = num;
    _title = title;
    _start = start;
    _description = description;
    _item = item;
    _link = link;
    _lastbuilddate = lastbuilddate;
  }

  Channel.fromJson(dynamic json) {
    _total = json['total'];
    _num = json['num'];
    _title = json['title'];
    _start = json['start'];
    _description = json['description'];
    if (json['item'] != null) {
      _item = [];
      json['item'].forEach((v) {
        _item?.add(Item.fromJson(v));
      });
    }
    _link = json['link'];
    _lastbuilddate = json['lastbuilddate'];
  }
  int? _total;
  int? _num;
  String? _title;
  int? _start;
  String? _description;
  List<Item>? _item;
  String? _link;
  String? _lastbuilddate;

  int? get total => _total;
  int? get num => _num;
  String? get title => _title;
  int? get start => _start;
  String? get description => _description;
  List<Item>? get item => _item;
  String? get link => _link;
  String? get lastbuilddate => _lastbuilddate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['num'] = _num;
    map['title'] = _title;
    map['start'] = _start;
    map['description'] = _description;
    if (_item != null) {
      map['item'] = _item?.map((v) => v.toJson()).toList();
    }
    map['link'] = _link;
    map['lastbuilddate'] = _lastbuilddate;
    return map;
  }
}

/// sup_no : "1"
/// word : "사과"
/// target_code : "169066"
/// sense : {"definition":"살이 연하고 달며 물이 많은 참외.","link":"https://stdict.korean.go.kr/search/searchView.do?word_no=169066&searchKeywordTo=3","type":"일반어"}
/// pos : "명사"

class Item {
  Item({
    String? supNo,
    String? word,
    String? targetCode,
    Sense? sense,
    String? pos,
  }) {
    _supNo = supNo;
    _word = word;
    _targetCode = targetCode;
    _sense = sense;
    _pos = pos;
  }

  Item.fromJson(dynamic json) {
    _supNo = json['sup_no'];
    _word = json['word'];
    _targetCode = json['target_code'];
    _sense = json['sense'] != null ? Sense.fromJson(json['sense']) : null;
    _pos = json['pos'];
  }
  String? _supNo;
  String? _word;
  String? _targetCode;
  Sense? _sense;
  String? _pos;

  String? get supNo => _supNo;
  String? get word => _word;
  String? get targetCode => _targetCode;
  Sense? get sense => _sense;
  String? get pos => _pos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sup_no'] = _supNo;
    map['word'] = _word;
    map['target_code'] = _targetCode;
    if (_sense != null) {
      map['sense'] = _sense?.toJson();
    }
    map['pos'] = _pos;
    return map;
  }
}

/// definition : "살이 연하고 달며 물이 많은 참외."
/// link : "https://stdict.korean.go.kr/search/searchView.do?word_no=169066&searchKeywordTo=3"
/// type : "일반어"

class Sense {
  Sense({
    String? definition,
    String? link,
    String? type,
  }) {
    _definition = definition;
    _link = link;
    _type = type;
  }

  Sense.fromJson(dynamic json) {
    _definition = json['definition'];
    _link = json['link'];
    _type = json['type'];
  }
  String? _definition;
  String? _link;
  String? _type;

  String? get definition => _definition;
  String? get link => _link;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['definition'] = _definition;
    map['link'] = _link;
    map['type'] = _type;
    return map;
  }
}
