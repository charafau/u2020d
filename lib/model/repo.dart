import 'dart:async';
import 'user.dart';

class Repo {

  final int id;
  final String name;
  final String fullName;
  final String htmlUrl;

  //add this
  final User owner;
  final int stargazersCount;
  final int watchersCount;
  final int forks;
  final String language;

  const Repo(
      {this.id, this.name, this.fullName, this.htmlUrl, this.stargazersCount,
      this.watchersCount, this.forks, this.language, this.owner});

  Repo.fromMap(Map<String, dynamic> map) :
      id = map['id'],
      name = map['name'],
      fullName = map['full_name'],
      htmlUrl = map['html_url'],
      stargazersCount = map['stargazers_count'],
      watchersCount = map['watchers_count'],
      forks = map['forks'],
      language = map['language'],
      owner = new User.fromMap(map['owner']);

}

abstract class RepoRepository {
  Future<List<Repo>> fetch();
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  @override
  String toString() {
    return 'Exception: $_message';
  }

}