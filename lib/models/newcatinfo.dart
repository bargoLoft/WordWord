/// channel : {"total":1,"title":"표준 국어 대사전 개발 지원(Open API) - 사전  검색","description":"표준 국어 대사전 개발 지원(Open API) – 사전 검색 결과","item":{"target_code":"230643","word_info":{"word_unit":"구","word":"엘리제를 위하여","original_language_info":[{"original_language":"Eliese","language_type":"안 밝힘"},{"original_language":"를","language_type":"고유어"},{"original_language":"爲","language_type":"한자"},{"original_language":"하여","language_type":"고유어"}],"word_type":"혼종어","pos_info":[{"pos_code":"230643001","comm_pattern_info":[{"comm_pattern_code":"230643001001","sense_info":[{"definition":"독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다.","cat_info":[{"cat":"음악"}],"type":"일반어","definition_original":"독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다.","sense_code":392634}]}],"pos":"품사 없음"}]}},"link":"https://stdict.korean.go.kr","lastbuilddate":"20220316040314"}

class Newcatinfo {
  Newcatinfo({
    Channel? channel,
  }) {
    _channel = channel;
  }

  Newcatinfo.fromJson(dynamic json) {
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

/// total : 1
/// title : "표준 국어 대사전 개발 지원(Open API) - 사전  검색"
/// description : "표준 국어 대사전 개발 지원(Open API) – 사전 검색 결과"
/// item : {"target_code":"230643","word_info":{"word_unit":"구","word":"엘리제를 위하여","original_language_info":[{"original_language":"Eliese","language_type":"안 밝힘"},{"original_language":"를","language_type":"고유어"},{"original_language":"爲","language_type":"한자"},{"original_language":"하여","language_type":"고유어"}],"word_type":"혼종어","pos_info":[{"pos_code":"230643001","comm_pattern_info":[{"comm_pattern_code":"230643001001","sense_info":[{"definition":"독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다.","cat_info":[{"cat":"음악"}],"type":"일반어","definition_original":"독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다.","sense_code":392634}]}],"pos":"품사 없음"}]}}
/// link : "https://stdict.korean.go.kr"
/// lastbuilddate : "20220316040314"

class Channel {
  Channel({
    int? total,
    String? title,
    String? description,
    Item? item,
    String? link,
    String? lastbuilddate,
  }) {
    _total = total;
    _title = title;
    _description = description;
    _item = item;
    _link = link;
    _lastbuilddate = lastbuilddate;
  }

  Channel.fromJson(dynamic json) {
    _total = json['total'];
    _title = json['title'];
    _description = json['description'];
    _item = json['item'] != null ? Item.fromJson(json['item']) : null;
    _link = json['link'];
    _lastbuilddate = json['lastbuilddate'];
  }
  int? _total;
  String? _title;
  String? _description;
  Item? _item;
  String? _link;
  String? _lastbuilddate;

  int? get total => _total;
  String? get title => _title;
  String? get description => _description;
  Item? get item => _item;
  String? get link => _link;
  String? get lastbuilddate => _lastbuilddate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['title'] = _title;
    map['description'] = _description;
    if (_item != null) {
      map['item'] = _item?.toJson();
    }
    map['link'] = _link;
    map['lastbuilddate'] = _lastbuilddate;
    return map;
  }
}

/// target_code : "230643"
/// word_info : {"word_unit":"구","word":"엘리제를 위하여","original_language_info":[{"original_language":"Eliese","language_type":"안 밝힘"},{"original_language":"를","language_type":"고유어"},{"original_language":"爲","language_type":"한자"},{"original_language":"하여","language_type":"고유어"}],"word_type":"혼종어","pos_info":[{"pos_code":"230643001","comm_pattern_info":[{"comm_pattern_code":"230643001001","sense_info":[{"definition":"독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다.","cat_info":[{"cat":"음악"}],"type":"일반어","definition_original":"독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다.","sense_code":392634}]}],"pos":"품사 없음"}]}

class Item {
  Item({
    String? targetCode,
    WordInfo? wordInfo,
  }) {
    _targetCode = targetCode;
    _wordInfo = wordInfo;
  }

  Item.fromJson(dynamic json) {
    _targetCode = json['target_code'];
    _wordInfo =
        json['word_info'] != null ? WordInfo.fromJson(json['wordInfo']) : null;
  }
  String? _targetCode;
  WordInfo? _wordInfo;

  String? get targetCode => _targetCode;
  WordInfo? get wordInfo => _wordInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['target_code'] = _targetCode;
    if (_wordInfo != null) {
      map['word_info'] = _wordInfo?.toJson();
    }
    return map;
  }
}

/// word_unit : "구"
/// word : "엘리제를 위하여"
/// original_language_info : [{"original_language":"Eliese","language_type":"안 밝힘"},{"original_language":"를","language_type":"고유어"},{"original_language":"爲","language_type":"한자"},{"original_language":"하여","language_type":"고유어"}]
/// word_type : "혼종어"
/// pos_info : [{"pos_code":"230643001","comm_pattern_info":[{"comm_pattern_code":"230643001001","sense_info":[{"definition":"독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다.","cat_info":[{"cat":"음악"}],"type":"일반어","definition_original":"독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다.","sense_code":392634}]}],"pos":"품사 없음"}]

class WordInfo {
  WordInfo({
    String? wordUnit,
    String? word,
    List<OriginalLanguageInfo>? originalLanguageInfo,
    String? wordType,
    List<PosInfo>? posInfo,
  }) {
    _wordUnit = wordUnit;
    _word = word;
    _originalLanguageInfo = originalLanguageInfo;
    _wordType = wordType;
    _posInfo = posInfo;
  }

  WordInfo.fromJson(dynamic json) {
    _wordUnit = json['word_unit'];
    _word = json['word'];
    if (json['original_language_info'] != null) {
      _originalLanguageInfo = [];
      json['original_language_info'].forEach((v) {
        _originalLanguageInfo?.add(OriginalLanguageInfo.fromJson(v));
      });
    }
    _wordType = json['word_type'];
    if (json['pos_info'] != null) {
      _posInfo = [];
      json['pos_info'].forEach((v) {
        _posInfo?.add(PosInfo.fromJson(v));
      });
    }
  }
  String? _wordUnit;
  String? _word;
  List<OriginalLanguageInfo>? _originalLanguageInfo;
  String? _wordType;
  List<PosInfo>? _posInfo;

  String? get wordUnit => _wordUnit;
  String? get word => _word;
  List<OriginalLanguageInfo>? get originalLanguageInfo => _originalLanguageInfo;
  String? get wordType => _wordType;
  List<PosInfo>? get posInfo => _posInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['word_unit'] = _wordUnit;
    map['word'] = _word;
    if (_originalLanguageInfo != null) {
      map['original_language_info'] =
          _originalLanguageInfo?.map((v) => v.toJson()).toList();
    }
    map['word_type'] = _wordType;
    if (_posInfo != null) {
      map['pos_info'] = _posInfo?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// pos_code : "230643001"
/// comm_pattern_info : [{"comm_pattern_code":"230643001001","sense_info":[{"definition":"독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다.","cat_info":[{"cat":"음악"}],"type":"일반어","definition_original":"독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다.","sense_code":392634}]}]
/// pos : "품사 없음"

class PosInfo {
  PosInfo({
    String? posCode,
    List<CommPatternInfo>? commPatternInfo,
    String? pos,
  }) {
    _posCode = posCode;
    _commPatternInfo = commPatternInfo;
    _pos = pos;
  }

  PosInfo.fromJson(dynamic json) {
    _posCode = json['pos_code'];
    if (json['comm_pattern_info'] != null) {
      _commPatternInfo = [];
      json['comm_pattern_info'].forEach((v) {
        _commPatternInfo?.add(CommPatternInfo.fromJson(v));
      });
    }
    _pos = json['pos'];
  }
  String? _posCode;
  List<CommPatternInfo>? _commPatternInfo;
  String? _pos;

  String? get posCode => _posCode;
  List<CommPatternInfo>? get commPatternInfo => _commPatternInfo;
  String? get pos => _pos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pos_code'] = _posCode;
    if (_commPatternInfo != null) {
      map['comm_pattern_info'] =
          _commPatternInfo?.map((v) => v.toJson()).toList();
    }
    map['pos'] = _pos;
    return map;
  }
}

/// comm_pattern_code : "230643001001"
/// sense_info : [{"definition":"독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다.","cat_info":[{"cat":"음악"}],"type":"일반어","definition_original":"독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다.","sense_code":392634}]

class CommPatternInfo {
  CommPatternInfo({
    String? commPatternCode,
    List<SenseInfo>? senseInfo,
  }) {
    _commPatternCode = commPatternCode;
    _senseInfo = senseInfo;
  }

  CommPatternInfo.fromJson(dynamic json) {
    _commPatternCode = json['comm_pattern_code'];
    if (json['sense_info'] != null) {
      _senseInfo = [];
      json['sense_info'].forEach((v) {
        _senseInfo?.add(SenseInfo.fromJson(v));
      });
    }
  }
  String? _commPatternCode;
  List<SenseInfo>? _senseInfo;

  String? get commPatternCode => _commPatternCode;
  List<SenseInfo>? get senseInfo => _senseInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['comm_pattern_code'] = _commPatternCode;
    if (_senseInfo != null) {
      map['sense_info'] = _senseInfo?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// definition : "독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다."
/// cat_info : [{"cat":"음악"}]
/// type : "일반어"
/// definition_original : "독일의 작곡가 베토벤이 1810년 무렵에 작곡한 피아노 독주곡 가단조. 작품 번호 173번으로 피아노를 배우는 사람이 즐겨 연주하는 쉬운 곡이다."
/// sense_code : 392634

class SenseInfo {
  SenseInfo({
    String? definition,
    List<CatInfo>? catInfo,
    String? type,
    String? definitionOriginal,
    int? senseCode,
  }) {
    _definition = definition;
    _catInfo = catInfo;
    _type = type;
    _definitionOriginal = definitionOriginal;
    _senseCode = senseCode;
  }

  SenseInfo.fromJson(dynamic json) {
    _definition = json['definition'];
    if (json['cat_info'] != null) {
      _catInfo = [];
      json['cat_info'].forEach((v) {
        _catInfo?.add(CatInfo.fromJson(v));
      });
    }
    _type = json['type'];
    _definitionOriginal = json['definition_original'];
    _senseCode = json['sense_code'];
  }
  String? _definition;
  List<CatInfo>? _catInfo;
  String? _type;
  String? _definitionOriginal;
  int? _senseCode;

  String? get definition => _definition;
  List<CatInfo>? get catInfo => _catInfo;
  String? get type => _type;
  String? get definitionOriginal => _definitionOriginal;
  int? get senseCode => _senseCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['definition'] = _definition;
    if (_catInfo != null) {
      map['cat_info'] = _catInfo?.map((v) => v.toJson()).toList();
    }
    map['type'] = _type;
    map['definition_original'] = _definitionOriginal;
    map['sense_code'] = _senseCode;
    return map;
  }
}

/// cat : "음악"

class CatInfo {
  CatInfo({
    String? cat,
  }) {
    _cat = cat;
  }

  CatInfo.fromJson(dynamic json) {
    _cat = json['cat'];
  }
  String? _cat;

  String? get cat => _cat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cat'] = _cat;
    return map;
  }
}

/// original_language : "Eliese"
/// language_type : "안 밝힘"

class OriginalLanguageInfo {
  OriginalLanguageInfo({
    String? originalLanguage,
    String? languageType,
  }) {
    _originalLanguage = originalLanguage;
    _languageType = languageType;
  }

  OriginalLanguageInfo.fromJson(dynamic json) {
    _originalLanguage = json['original_language'];
    _languageType = json['language_type'];
  }
  String? _originalLanguage;
  String? _languageType;

  String? get originalLanguage => _originalLanguage;
  String? get languageType => _languageType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['original_language'] = _originalLanguage;
    map['language_type'] = _languageType;
    return map;
  }
}
