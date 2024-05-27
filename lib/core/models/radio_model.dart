import 'package:hive/hive.dart';
part 'radio_model.g.dart';

@HiveType(typeId: 0)
class RadioStation {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String streamUrl;

  RadioStation({required this.name, required this.streamUrl});

  factory RadioStation.fromJson(Map<String, dynamic> json) {
    return RadioStation(
      name: json['name'],
      streamUrl: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': streamUrl,
    };
  }
}
