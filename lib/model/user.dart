class User {
  final int id;
  final String login;
  final String avatarUrl;
  final String url;
  final String htmlUrl;

  const User({this.id, this.login, this.avatarUrl, this.url, this.htmlUrl});

  User.fromMap(Map<String, dynamic> map) :
        id = map['id'],
        login = map['login'],
        avatarUrl = map['avatar_url'],
        url = map['url'],
        htmlUrl = map['html_url'];


}