class Comment {
  Comment(
      {
      required this.Name,
      required this.Text,
      this.Profile,
      required this.date,
     });


  String Name;
  String? Profile;
  String? Attchment;
 
  String Text;
  String date;
 

  Map<String, dynamic> toMap() {
    return {
     
      "name":Name,
      "profile": Profile,
   
      "comment": Text,
      "date": date,
      
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(   
      Name: map['name'],
      Profile: map['profile'] ?? "",
      Text:map['comment'],
      date: map['date'],
    );
  }
}
