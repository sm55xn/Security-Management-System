
class User {
  final String name;
  final String? imageUrl;
  final String phone;
  final String DateOfBirth;
  final String gander;
  final int credibility;
  final bool isIdentity;
  final int reportsCount;
  final int replysCount;
  final int reportsFakeCount;

  const User(
      {required this.name,
      required this.phone,
      this.imageUrl,
      required this.DateOfBirth,
      required this.gander,
      required this.credibility,
      required this.isIdentity,
      required this.replysCount,
      required this.reportsCount,
      required this.reportsFakeCount});
  Map<String, dynamic> toMap() {
    return {
      "DateOfBirth": DateOfBirth,
      "imageUrl": imageUrl,
      "credibility": credibility,
      "phone": phone,
      "name": name,
      "gender":gander,
      "isIdentity": isIdentity,
      "replysCount": replysCount,
      "reportsCount": reportsCount,
      "isAttachmentAvailable": reportsFakeCount,
    };
  }
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        DateOfBirth: map['DateOfBirth'].toString(),
        imageUrl: map['imageUrl'].toString(),
        gander:map['gender'],
        credibility: map['credibility'],
        phone: map['phone'],
        isIdentity: map['isIdentity'] ?? false,
        name: map['name'],
        replysCount: map['replysCount'],
        reportsCount: map['reportsCount'],
        reportsFakeCount: map['reportsFakeCount'],
        );
  }
}
