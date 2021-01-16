import 'package:json_annotation/json_annotation.dart';
part 'title.g.dart';

@JsonSerializable()
class Title {
  String id;
  String name;

  Title(this.id, this.name);

  factory Title.fromJson(Map<String, dynamic> data) => _$TitleFromJson(data);

  Map<String, dynamic> toJson() => _$TitleToJson(this);

  @override
  String toString() {
    return 'Title{id: $id, name: $name}';
  }
}
