class Page {
  Page(
      {required this.Id,
      required this.Name,
      required this.Description,
      this.Profile,
      required this.dateJoin,
      required this.FollowerCount,
      required this.PostsCount});

  String Id;
  String Name;
  String Description;
  String? Profile;
  String dateJoin;
  int FollowerCount;
  int PostsCount;

 Map<String, dynamic> toMap() {
    return {
      "id": Id,
      "name": Name,
      "profile": Profile,
      "description": Description,
      "dateJoin": dateJoin,
      "followerCount": FollowerCount,
      "postsCount": PostsCount,

    };
  }

  factory Page.fromMap(Map<String, dynamic> map) {
    return Page(
        Id: map['id'],
        Name: map['name'],
        Profile: map['profile'],
        Description: map['description'],
        dateJoin: map['dateJoin'],
        FollowerCount: map['followerCount'] ,
        PostsCount: map['postsCount'],
        );
  }
    
}
