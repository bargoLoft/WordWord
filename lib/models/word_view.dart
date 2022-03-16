class WordView {
  Channel? channel;

  WordView({this.channel});

  WordView.fromJson(Map<String, dynamic> json) {
    channel =
        json['channel'] != null ? Channel.fromJson(json['channel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (channel != null) {
      data['channel'] = channel!.toJson();
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
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
    link = json['link'];
    lastbuilddate = json['lastbuilddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['title'] = title;
    data['description'] = description;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    data['link'] = link;
    data['lastbuilddate'] = lastbuilddate;
    return data;
  }
}

class Item {
  String? targetCode;
  WordInfo? wordInfo;

  Item({this.targetCode, this.wordInfo});

  Item.fromJson(Map<String, dynamic> json) {
    targetCode = json['target_code'];
    wordInfo =
        json['word_info'] != null ? WordInfo.fromJson(json['word_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['target_code'] = targetCode;
    if (wordInfo != null) {
      data['word_info'] = wordInfo!.toJson();
    }
    return data;
  }
}

class WordInfo {
  List<ConjuInfo>? conjuInfo;
  List<PronunciationInfo>? pronunciationInfo;
  String? wordUnit;
  String? word;
  String? origin;
  List<RelationInfo>? relationInfo;
  List<OriginalLanguageInfo>? originalLanguageInfo;
  String? wordType;
  List<PosInfo>? posInfo;

  WordInfo(
      {this.conjuInfo,
      this.pronunciationInfo,
      this.wordUnit,
      this.word,
      this.origin,
      this.relationInfo,
      this.originalLanguageInfo,
      this.wordType,
      this.posInfo});

  WordInfo.fromJson(Map<String, dynamic> json) {
    if (json['conju_info'] != null) {
      conjuInfo = <ConjuInfo>[];
      json['conju_info'].forEach((v) {
        conjuInfo!.add(ConjuInfo.fromJson(v));
      });
    }
    if (json['pronunciation_info'] != null) {
      pronunciationInfo = <PronunciationInfo>[];
      json['pronunciation_info'].forEach((v) {
        pronunciationInfo!.add(PronunciationInfo.fromJson(v));
      });
    }
    wordUnit = json['word_unit'];
    word = json['word'];
    origin = json['origin'];
    if (json['relation_info'] != null) {
      relationInfo = <RelationInfo>[];
      json['relation_info'].forEach((v) {
        relationInfo!.add(RelationInfo.fromJson(v));
      });
    }
    if (json['original_language_info'] != null) {
      originalLanguageInfo = <OriginalLanguageInfo>[];
      json['original_language_info'].forEach((v) {
        originalLanguageInfo!.add(OriginalLanguageInfo.fromJson(v));
      });
    }
    wordType = json['word_type'];
    if (json['pos_info'] != null) {
      posInfo = <PosInfo>[];
      json['pos_info'].forEach((v) {
        posInfo!.add(PosInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (conjuInfo != null) {
      data['conju_info'] = conjuInfo!.map((v) => v.toJson()).toList();
    }
    if (pronunciationInfo != null) {
      data['pronunciation_info'] =
          pronunciationInfo!.map((v) => v.toJson()).toList();
    }
    data['word_unit'] = wordUnit;
    data['word'] = word;
    data['origin'] = origin;
    if (originalLanguageInfo != null) {
      data['original_language_info'] =
          originalLanguageInfo!.map((v) => v.toJson()).toList();
    }
    data['word_type'] = wordType;
    if (posInfo != null) {
      data['pos_info'] = posInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConjuInfo {
  ConjugationInfo? conjugationInfo;

  ConjuInfo({this.conjugationInfo});

  ConjuInfo.fromJson(Map<String, dynamic> json) {
    conjugationInfo = json['conjugation_info'] != null
        ? ConjugationInfo.fromJson(json['conjugation_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (conjugationInfo != null) {
      data['conjugation_info'] = conjugationInfo!.toJson();
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
        pronunciationInfo!.add(PronunciationInfo.fromJson(v));
      });
    }
    conjugation = json['conjugation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pronunciationInfo != null) {
      data['pronunciation_info'] =
          pronunciationInfo!.map((v) => v.toJson()).toList();
    }
    data['conjugation'] = conjugation;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pronunciation'] = pronunciation;
    return data;
  }
}

class RelationInfo {
  String? relationWord;
  String? wordType;

  RelationInfo({this.relationWord, this.wordType});

  RelationInfo.fromJson(Map<String, dynamic> json) {
    relationWord = json['word'];
    wordType = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = relationWord;
    data['type'] = wordType;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['original_language'] = originalLanguage;
    data['language_type'] = languageType;
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
        commPatternInfo!.add(CommPatternInfo.fromJson(v));
      });
    }
    pos = json['pos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pos_code'] = posCode;
    if (commPatternInfo != null) {
      data['comm_pattern_info'] =
          commPatternInfo!.map((v) => v.toJson()).toList();
    }
    data['pos'] = pos;
    return data;
  }
}

class CommPatternInfo {
  List<PatternInfo>? patternInfo;
  String? commPatternCode;
  List<SenseInfo>? senseInfo;

  CommPatternInfo({this.commPatternCode, this.senseInfo, this.patternInfo});

  CommPatternInfo.fromJson(Map<String, dynamic> json) {
    if (json['pattern_info'] != null) {
      patternInfo = <PatternInfo>[];
      json['pattern_info'].forEach((v) {
        patternInfo!.add(PatternInfo.fromJson(v));
      });
    }

    commPatternCode = json['comm_pattern_code'];
    if (json['sense_info'] != null) {
      senseInfo = <SenseInfo>[];
      json['sense_info'].forEach((v) {
        senseInfo!.add(SenseInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (patternInfo != null) {
      data['pattern_info'] = patternInfo!.map((v) => v.toJson()).toList();
    }
    data['comm_pattern_code'] = commPatternCode;
    if (senseInfo != null) {
      data['sense_info'] = senseInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatternInfo {
  String? pattern;

  PatternInfo({this.pattern});

  PatternInfo.fromJson(Map<String, dynamic> json) {
    pattern = json['pattern'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pattern'] = pattern;
    return data;
  }
}

class SenseInfo {
  String? definition;
  List<CatInfo>? catInfo;
  String? type;
  List<ExampleInfo>? exampleInfo;
  String? definitionOriginal;
  int? senseCode;

  SenseInfo(
      {this.definition,
      this.type,
      this.exampleInfo,
      this.catInfo,
      this.definitionOriginal,
      this.senseCode});

  SenseInfo.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
    type = json['type'];
    if (json['cat_info'] != null) {
      catInfo = <CatInfo>[];
      json['cat_info'].forEach((v) {
        catInfo!.add(CatInfo.fromJson(v));
      });
    }
    if (json['example_info'] != null) {
      exampleInfo = <ExampleInfo>[];
      json['example_info'].forEach((v) {
        exampleInfo!.add(ExampleInfo.fromJson(v));
      });
    }
    definitionOriginal = json['definition_original'];
    senseCode = json['sense_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['definition'] = definition;
    data['type'] = type;
    if (exampleInfo != null) {
      data['example_info'] = exampleInfo!.map((v) => v.toJson()).toList();
    }
    data['definition_original'] = definitionOriginal;
    data['sense_code'] = senseCode;
    return data;
  }
}

class CatInfo {
  String? cat;

  CatInfo({this.cat});

  CatInfo.fromJson(Map<String, dynamic> json) {
    cat = json['cat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat'] = cat;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['example'] = example;
    return data;
  }
}
