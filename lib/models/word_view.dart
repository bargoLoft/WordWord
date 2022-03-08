class WordView {
  Channel? channel;

  WordView({this.channel});

  WordView.fromJson(Map<String, dynamic> json) {
    channel =
        json['channel'] != null ? new Channel.fromJson(json['channel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.channel != null) {
      data['channel'] = this.channel!.toJson();
    }
    return data;
  }
}

class Channel {
  int? total;
  String? title;
  String? description;
  Item? item;
  String? link;
  String? lastbuilddate;

  Channel(
      {this.total,
      this.title,
      this.description,
      this.item,
      this.link,
      this.lastbuilddate});

  Channel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    title = json['title'];
    description = json['description'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    link = json['link'];
    lastbuilddate = json['lastbuilddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    data['link'] = this.link;
    data['lastbuilddate'] = this.lastbuilddate;
    return data;
  }
}

class Item {
  String? targetCode;
  WordInfo? wordInfo;

  Item({this.targetCode, this.wordInfo});

  Item.fromJson(Map<String, dynamic> json) {
    targetCode = json['target_code'];
    wordInfo = json['word_info'] != null
        ? new WordInfo.fromJson(json['word_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['target_code'] = this.targetCode;
    if (this.wordInfo != null) {
      data['word_info'] = this.wordInfo!.toJson();
    }
    return data;
  }
}

class WordInfo {
  List<ConjuInfo>? conjuInfo;
  List<PronunciationInfo>? pronunciationInfo;
  String? wordUnit;
  String? word;
  List<OriginalLanguageInfo>? originalLanguageInfo;
  String? wordType;
  List<PosInfo>? posInfo;

  WordInfo(
      {this.conjuInfo,
      this.pronunciationInfo,
      this.wordUnit,
      this.word,
      this.originalLanguageInfo,
      this.wordType,
      this.posInfo});

  WordInfo.fromJson(Map<String, dynamic> json) {
    if (json['conju_info'] != null) {
      conjuInfo = <ConjuInfo>[];
      json['conju_info'].forEach((v) {
        conjuInfo!.add(new ConjuInfo.fromJson(v));
      });
    }
    if (json['pronunciation_info'] != null) {
      pronunciationInfo = <PronunciationInfo>[];
      json['pronunciation_info'].forEach((v) {
        pronunciationInfo!.add(new PronunciationInfo.fromJson(v));
      });
    }
    wordUnit = json['word_unit'];
    word = json['word'];
    if (json['original_language_info'] != null) {
      originalLanguageInfo = <OriginalLanguageInfo>[];
      json['original_language_info'].forEach((v) {
        originalLanguageInfo!.add(new OriginalLanguageInfo.fromJson(v));
      });
    }
    wordType = json['word_type'];
    if (json['pos_info'] != null) {
      posInfo = <PosInfo>[];
      json['pos_info'].forEach((v) {
        posInfo!.add(new PosInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.conjuInfo != null) {
      data['conju_info'] = this.conjuInfo!.map((v) => v.toJson()).toList();
    }
    if (this.pronunciationInfo != null) {
      data['pronunciation_info'] =
          this.pronunciationInfo!.map((v) => v.toJson()).toList();
    }
    data['word_unit'] = this.wordUnit;
    data['word'] = this.word;
    if (this.originalLanguageInfo != null) {
      data['original_language_info'] =
          this.originalLanguageInfo!.map((v) => v.toJson()).toList();
    }
    data['word_type'] = this.wordType;
    if (this.posInfo != null) {
      data['pos_info'] = this.posInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConjuInfo {
  ConjugationInfo? conjugationInfo;

  ConjuInfo({this.conjugationInfo});

  ConjuInfo.fromJson(Map<String, dynamic> json) {
    conjugationInfo = json['conjugation_info'] != null
        ? new ConjugationInfo.fromJson(json['conjugation_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.conjugationInfo != null) {
      data['conjugation_info'] = this.conjugationInfo!.toJson();
    }
    return data;
  }
}

class ConjugationInfo {
  List<PronunciationInfo>? pronunciationInfo;
  String? conjugation;

  ConjugationInfo({this.pronunciationInfo, this.conjugation});

  ConjugationInfo.fromJson(Map<String, dynamic> json) {
    if (json['pronunciation_info'] != null) {
      pronunciationInfo = <PronunciationInfo>[];
      json['pronunciation_info'].forEach((v) {
        pronunciationInfo!.add(new PronunciationInfo.fromJson(v));
      });
    }
    conjugation = json['conjugation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pronunciationInfo != null) {
      data['pronunciation_info'] =
          this.pronunciationInfo!.map((v) => v.toJson()).toList();
    }
    data['conjugation'] = this.conjugation;
    return data;
  }
}

class PronunciationInfo {
  String? pronunciation;

  PronunciationInfo({this.pronunciation});

  PronunciationInfo.fromJson(Map<String, dynamic> json) {
    pronunciation = json['pronunciation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pronunciation'] = this.pronunciation;
    return data;
  }
}

class OriginalLanguageInfo {
  String? originalLanguage;
  String? languageType;

  OriginalLanguageInfo({this.originalLanguage, this.languageType});

  OriginalLanguageInfo.fromJson(Map<String, dynamic> json) {
    originalLanguage = json['original_language'];
    languageType = json['language_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original_language'] = this.originalLanguage;
    data['language_type'] = this.languageType;
    return data;
  }
}

class PosInfo {
  String? posCode;
  List<CommPatternInfo>? commPatternInfo;
  String? pos;

  PosInfo({this.posCode, this.commPatternInfo, this.pos});

  PosInfo.fromJson(Map<String, dynamic> json) {
    posCode = json['pos_code'];
    if (json['comm_pattern_info'] != null) {
      commPatternInfo = <CommPatternInfo>[];
      json['comm_pattern_info'].forEach((v) {
        commPatternInfo!.add(new CommPatternInfo.fromJson(v));
      });
    }
    pos = json['pos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pos_code'] = this.posCode;
    if (this.commPatternInfo != null) {
      data['comm_pattern_info'] =
          this.commPatternInfo!.map((v) => v.toJson()).toList();
    }
    data['pos'] = this.pos;
    return data;
  }
}

class CommPatternInfo {
  String? commPatternCode;
  List<SenseInfo>? senseInfo;

  CommPatternInfo({this.commPatternCode, this.senseInfo});

  CommPatternInfo.fromJson(Map<String, dynamic> json) {
    commPatternCode = json['comm_pattern_code'];
    if (json['sense_info'] != null) {
      senseInfo = <SenseInfo>[];
      json['sense_info'].forEach((v) {
        senseInfo!.add(new SenseInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comm_pattern_code'] = this.commPatternCode;
    if (this.senseInfo != null) {
      data['sense_info'] = this.senseInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SenseInfo {
  String? definition;
  String? type;
  List<ExampleInfo>? exampleInfo;
  String? definitionOriginal;
  int? senseCode;

  SenseInfo(
      {this.definition,
      this.type,
      this.exampleInfo,
      this.definitionOriginal,
      this.senseCode});

  SenseInfo.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
    type = json['type'];
    if (json['example_info'] != null) {
      exampleInfo = <ExampleInfo>[];
      json['example_info'].forEach((v) {
        exampleInfo!.add(new ExampleInfo.fromJson(v));
      });
    }
    definitionOriginal = json['definition_original'];
    senseCode = json['sense_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['definition'] = this.definition;
    data['type'] = this.type;
    if (this.exampleInfo != null) {
      data['example_info'] = this.exampleInfo!.map((v) => v.toJson()).toList();
    }
    data['definition_original'] = this.definitionOriginal;
    data['sense_code'] = this.senseCode;
    return data;
  }
}

class ExampleInfo {
  String? example;

  ExampleInfo({this.example});

  ExampleInfo.fromJson(Map<String, dynamic> json) {
    example = json['example'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['example'] = this.example;
    return data;
  }
}
