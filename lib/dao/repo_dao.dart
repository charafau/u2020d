import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:u2020d/model/repo.dart';

class GithubRepository implements RepoRepository {

  final String _url = "https://api.github.com/search/repositories?q=created&sort=stars&order=desc";
  final JsonDecoder _decoder = new JsonDecoder();

  @override
  Future<List<Repo>> fetch() {
    return http.get(_url)
        .then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode != 200) {
        throw new FetchDataException("Error while getting repos: $statusCode");
      }

      final reposContainer = _decoder.convert(jsonBody);

      final List repoItems = reposContainer['items'];

      return repoItems.map((repoRaw) => new Repo.fromMap(repoRaw))
          .toList();
    });
  }
}