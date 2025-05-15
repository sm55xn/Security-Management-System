class Handle {
  int isHandle;
  String name;
  Handle({
    required this.isHandle,
    required this.name,
  });
  Map<String, dynamic> toMap() => {
        "isHandle": isHandle,
        "nameEmp": name,
      };
  factory Handle.fromMap(Map<String, dynamic> map) {
    return Handle(
      isHandle: map["isHandle"],
      name: map["nameEmp"],
    );
  }
}
