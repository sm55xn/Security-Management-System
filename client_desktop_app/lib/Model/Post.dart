class Post {
  Post(
      {required this.idPage,
      required this.idPost,
      required this.NamePage,
      required this.Text,
      this.Profile,
      required this.date,
      required this.isComment,
      this.Attchment,
      required this.Comments,
      required this.likes});

  String idPage;
  String idPost;
  String NamePage;
  String? Profile;
  String? Attchment;
  bool isComment;
  String Text;
  String date;
  int Comments;
  int likes;

  Map<String, dynamic> toMap() {
    return {
      "idPage": idPage,
      "idPost": idPost,
      "NamePage":NamePage,
      "Profile": Profile,
      "Attchment":Attchment,
      "isComment":isComment,
      "Text": Text,
      "date": date,
      "Comments": Comments,
      "likes": likes,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      idPage: map['idPage'],
      idPost: map['idPost'],
      NamePage: map['namePage'],
      Profile: map['profile'] ?? "",
      Attchment: map['attchment']??" ",
      isComment:map['isComment'],
      Text:map['text'],
      date: map['date'],
      Comments: map['comments'],
      likes: map['likes'],
    );
  }
}
