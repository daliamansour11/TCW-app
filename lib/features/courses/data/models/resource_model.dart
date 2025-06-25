
class ResourceModel {

  ResourceModel({
    required this.type,
    required this.url,
  });

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
      type: json['type'],
      url: json['url'],
    );
  }
  final String type;
  final String url;

  Map<String, dynamic> toJson() => {
        'type': type,
        'url': url,
      };
}
