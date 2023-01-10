// ignore_for_file: file_names, non_constant_identifier_names

class Images {
  final int id;
  final String name;
  final String created_at;
  final String tujuan;

  const Images({
    required this.id,
    required this.name,
    required this.created_at,
    required this.tujuan,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      id: json['id'],
      name: json['name'],
      created_at: json['created_at'],
      tujuan: json['tujuan'],
    );
  }
}
