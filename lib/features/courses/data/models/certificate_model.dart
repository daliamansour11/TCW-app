class CertificateModel {

  CertificateModel({
    required this.id,
    required this.file,
    required this.createdAt,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      id: json['id'],
      file: json['file'],
      createdAt: json['created_at'],
    );
  }
  final String id;
  final String file;
  final String createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'file': file,
        'created_at': createdAt,
      };
}
