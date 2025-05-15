class Post{
  final String profileImageUrl;
  final String username;
  final String time;
  final String content;
  final String likes;
  final String comments;
  final String shares;

  Post({
    required this.profileImageUrl,
    required this.username,
    required this.time,
    required this.content,
    required this.likes,
    required this.comments,
    required this.shares
  });
}

List<Post> posts = [
  new Post(profileImageUrl: 'assets/Sam Wilson.jpg', username: 'إدارة الأمن', time: '5h', content: 'هذا النص مثال بسيط لما سيتم للمعاينة والإختبار النص الحقيقي سوف يظهر بعد اكتمال هذا الجزء وارتباطة بالسيرفر ', likes: '63', comments: '11', shares: '2'),
  new Post(profileImageUrl: 'assets/jeremy.jpg', username: 'مكتب الصحة', time: '13h', content: 'هذا النص مثال بسيط لما سيتم للمعاينة والإختبار النص الحقيقي سوف يظهر بعد اكتمال هذا الجزء وارتباطة بالسيرفر ', likes: '52', comments: '1', shares: '6'),
  new Post(profileImageUrl: 'assets/mathew.jpg', username: 'قسم شرطة الحصب', time: '2d',content: 'هذا النص مثال بسيط لما سيتم للمعاينة والإختبار النص الحقيقي سوف يظهر بعد اكتمال هذا الجزء وارتباطة بالسيرفر ', likes: '61', comments: '3', shares: '2'),
  new Post(profileImageUrl: 'assets/eddison.jpg', username: 'الإعلام الأمني', time: '1w', content: 'هذا النص مثال بسيط لما سيتم للمعاينة والإختبار النص الحقيقي سوف يظهر بعد اكتمال هذا الجزء وارتباطة بالسيرفر ', likes: '233', comments: '6', shares: '4'),
  new Post(profileImageUrl: 'assets/olivia.jpg', username: 'الدفاع المدني', time: '3w', content: 'هذا النص مثال بسيط لما سيتم للمعاينة والإختبار النص الحقيقي سوف يظهر بعد اكتمال هذا الجزء وارتباطة بالسيرفر ', likes: '77', comments: '7', shares: '2'),
];