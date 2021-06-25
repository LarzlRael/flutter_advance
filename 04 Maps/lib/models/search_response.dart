// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

SearchResponse searchResponseFromJson(String str) =>
    SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  SearchResponse({
    required this.type,
    required this.query,
    required this.features,
    required this.attribution,
  });

  String type;
  List<String> query;
  List<Feature> features;
  String attribution;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.relevance,
    required this.properties,
    required this.textEs,
    required this.languageEs,
    required this.placeNameEs,
    required this.text,
    required this.language,
    required this.placeName,
    required this.center,
    required this.geometry,
    required this.context,
  });

  String id;
  String type;
  List<String> placeType;
  double relevance;
  Properties properties;
  String textEs;
  Language? languageEs;
  String placeNameEs;
  String text;
  Language? language;
  String placeName;
  List<double> center;
  Geometry geometry;
  List<Context> context;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"].toDouble(),
        properties: Properties.fromJson(json["properties"]),
        textEs: json["text_es"],
        languageEs: json["language_es"] == null
            ? null
            : languageValues.map[json["language_es"]],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        language: json["language"] == null
            ? null
            : languageValues.map[json["language"]],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context:
            List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toJson(),
        "text_es": textEs,
        "language_es":
            languageEs == null ? null : languageValues.reverse[languageEs],
        "place_name_es": placeNameEs,
        "text": text,
        "language": language == null ? null : languageValues.reverse[language],
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": List<dynamic>.from(context.map((x) => x.toJson())),
      };
}

class Context {
  Context({
    required this.id,
    required this.wikidata,
    required this.textEs,
    required this.languageEs,
    required this.text,
    required this.language,
    required this.shortCode,
  });

  String id;
  String? wikidata;
  String? textEs;
  Language? languageEs;
  String? text;
  Language? language;
  String? shortCode;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        wikidata: json["wikidata"] == null ? null : json["wikidata"],
        textEs: json["text_es"],
        languageEs: json["language_es"] == null
            ? null
            : languageValues.map[json["language_es"]],
        text: json["text"],
        language: json["language"] == null
            ? null
            : languageValues.map[json["language"]],
        shortCode: json["short_code"] == null ? null : json["short_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wikidata": wikidata == null ? null : wikidata,
        "text_es": textEs,
        "language_es":
            languageEs == null ? null : languageValues.reverse[languageEs],
        "text": text,
        "language": language == null ? null : languageValues.reverse[language],
        "short_code": shortCode == null ? null : shortCode,
      };
}

enum Language { ES }

final languageValues = EnumValues({"es": Language.ES});

class Geometry {
  Geometry({
    required this.coordinates,
    required this.type,
  });

  List<double> coordinates;
  String type;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}

class Properties {
  Properties({
    required this.foursquare,
    required this.landmark,
    required this.wikidata,
    required this.address,
    required this.category,
    required this.maki,
    required this.accuracy,
  });

  String? foursquare;
  bool? landmark;
  String? wikidata;
  String? address;
  String? category;
  String? maki;
  String? accuracy;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        foursquare: json["foursquare"] == null ? null : json["foursquare"],
        landmark: json["landmark"] == null ? null : json["landmark"],
        wikidata: json["wikidata"] == null ? null : json["wikidata"],
        address: json["address"] == null ? null : json["address"],
        category: json["category"] == null ? null : json["category"],
        maki: json["maki"] == null ? null : json["maki"],
        accuracy: json["accuracy"] == null ? null : json["accuracy"],
      );

  Map<String, dynamic> toJson() => {
        "foursquare": foursquare == null ? null : foursquare,
        "landmark": landmark == null ? null : landmark,
        "wikidata": wikidata == null ? null : wikidata,
        "address": address == null ? null : address,
        "category": category == null ? null : category,
        "maki": maki == null ? null : maki,
        "accuracy": accuracy == null ? null : accuracy,
      };
}

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
