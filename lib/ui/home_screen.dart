import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ws_flutter_fetchapi/core/model/movie_item.dart';
import 'package:ws_flutter_fetchapi/core/model/movie_resp.dart';
import 'package:ws_flutter_fetchapi/core/model/movie_response.dart';
import 'package:ws_flutter_fetchapi/core/service/service.dart';
import 'package:ws_flutter_fetchapi/ui/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Service _service;
  var imageUrl = "http://image.tmdb.org/t/p/w500/";
  var errorImage =
      "https://cdn2.iconfinder.com/data/icons/image-1/64/Image-12-512.png";

  //tambahkan bari di bawah ini
  List<Tab> _tabList = List();
  TabController _tabController;

  @override
  void initState() {
    print('init homescreen');
    _service = Service();
    super.initState();

    _tabList.add(new Tab(text: 'Now Playing'));
    _tabList.add(new Tab(text: 'Up Coming'));

    _tabController = TabController(length: _tabList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text("Aplikasi Fetch Data"),
          bottom: TabBar(
            tabs: _tabList,
            controller: _tabController,
            indicatorColor: Colors.orange,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Center(
              child: FutureBuilder<MovieResponse>(
                  future: _service.getNowPlaying(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.results.length,
                        itemBuilder: (context, index) {
                          var gambar = imageUrl +
                              snapshot.data.results[index].posterPath;
                          var data = snapshot.data.results[index];

                          MovieItem movieItem = MovieItem.fromJson(
                              snapshot.data.results[index].toJson());

                          if (snapshot.data.results.length == null) {
                            return Text("Tidak ada data");
                          } else {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => DetailScreen(
                                              movieItem: movieItem,
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        height: 150,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: gambar,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.blue,
                                                    blurRadius: 3)
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  data.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  data.overview,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 5,
                                                ),
                                              ],
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
            Center(
              child: FutureBuilder<MovieResp>(
                future: _service.getUpcoming(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.results.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data.results[index];

                        if (index == 0) data.posterPath = null;

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => DetailScreen(
                                          movieItem: data,
                                        )));
                          },
                          child: Stack(
                            children: <Widget>[
                              //!  kotak judul
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, left: 50.0),
                                          child: Column(children: <Widget>[
                                            ListTile(
                                              title: Text(data.title),
                                              subtitle: Text(data.releaseDate),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //! foto movie
                              Positioned(
                                top: 20,
                                left: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          data.posterPath != null
                                              ? imageUrl + data.posterPath
                                              : errorImage),
                                      radius: 40.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            )
          ],
        ));
  }
}
