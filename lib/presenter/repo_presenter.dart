import 'package:u2020d/model/repo.dart';
import 'package:u2020d/dao/repo_dao.dart';


abstract class RepoListViewContract {
  void onLoadRepoComplete(List<Repo> items);

  void onLoadRepoError();
}

class RepoPresenter {
  RepoListViewContract _view;
  RepoRepository _repository;

  RepoPresenter(this._view) {
    //should inject here
    _repository = new GithubRepository();
  }

  void loadRepos() {
    assert(_view != null);

    _repository.fetch()
        .then((repos) => _view.onLoadRepoComplete(repos))
        .catchError((onError) {
      print(onError);
      _view.onLoadRepoError();
    });
  }


}