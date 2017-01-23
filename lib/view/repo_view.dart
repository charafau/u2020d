import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:u2020d/model/repo.dart';
import 'package:u2020d/presenter/repo_presenter.dart';

class RepoPage extends StatelessWidget {
  static const String routeName = '/';


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Top Repositories"),
      ),
      body: new RepoList(),
    );
  }
}

class RepoList extends StatefulWidget {

  RepoList({Key key}) : super(key: key);

  @override
  State createState() => new _RepoListState();
}

class _RepoListState extends State<RepoList> implements RepoListViewContract {

  RepoPresenter _presenter;

  List<Repo> _repos;

  bool _IsSearching;


  _RepoListState() {
    _presenter = new RepoPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = true;
    _presenter.loadRepos();
  }

  @override
  Widget build(BuildContext context) {
    var widget;

    if (_IsSearching) {
      widget = new Center(
          child: new Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: new CircularProgressIndicator(),
          )
      );
    } else {
      widget = new MaterialList(
        type: MaterialListType.twoLine,
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _buildContactList(),
      );
    }

    return widget;
  }

  List<_RepoListItem> _buildContactList() {
    return _repos.map((repo) =>
    new _RepoListItem(repo: repo,
        onTap: () {})
    ).toList();
  }


  @override
  void onLoadRepoComplete(List<Repo> items) {
    setState(() {
      _repos = items;
      _IsSearching = false;
    });
  }

  @override
  void onLoadRepoError() {
    // do nothing :)
  }

}

class _RepoListItem extends Card {

  _RepoListItem({@required Repo repo, @required GestureTapCallback onTap}) :
        super(
          child: new Center(
              child: new Text(repo.fullName)
          )
      );
}