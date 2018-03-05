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
      widget = new ListView (
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        itemExtent: _RepoListItem.height,
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

  static final double height = 100.0;

  _RepoListItem({@required Repo repo, @required GestureTapCallback onTap}) :
        super(
          child: new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Align(
                            alignment: FractionalOffset.centerLeft,
                            child: new SizedBox(
                                width: 48.0,
                                child: new ClipRRect(
                                    borderRadius: new BorderRadius.circular(
                                        50.0),
                                    child: new Image.network(
                                      repo.owner.avatarUrl,
                                      alignment: FractionalOffset.centerLeft,
                                      fit: BoxFit.cover,
                                    )
                                )
                            ),
                          ),

                        ]
                    ),
                    new Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Align(
                                alignment: FractionalOffset.topLeft,
                                child: new Text(repo.name)
                            ),
                            new Align(
                                alignment: FractionalOffset.topLeft,
                                child: new Text(repo.fullName)
                            )
                          ],
                        )
                    )

//                    new Center(
//                        child: new Text(repo.fullName)
//                    )
                  ]
              )
          )
      );
}