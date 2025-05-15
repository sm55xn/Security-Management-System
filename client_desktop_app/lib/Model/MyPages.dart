class MyPages {
  MyPages({
    required this.Id,
    required this.Name,
    this.Profile
  });

  String Id;
  String Name;
  String? Profile;

  Map<String, dynamic> toMap() {
    return {
      "id": Id,
      "name": Name,
      "profile":Profile,
    };
  }

  factory MyPages.fromMap(Map<String, dynamic> map) {
    return MyPages(
      Id: map['id'],
      Name: map['name'],
      Profile: map['profile']
    );
  }
}
