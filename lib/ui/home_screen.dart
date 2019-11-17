import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ws_flutter_fetchapi/core/model/movie_resp.dart';
import 'package:ws_flutter_fetchapi/core/model/movie_response.dart';
import 'package:ws_flutter_fetchapi/core/service/service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Service _service;
  var imageUrl = "http://image.tmdb.org/t/p/w500/";

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
                          if (snapshot.data.results.length == null) {
                            return Text("Tidak ada data");
                          } else {
                            return Padding(
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
                                          errorWidget: (context, url, error) =>
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
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                data.overview,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 5,
                                              ),
                                            ],
                                          ),
                                        )),
                                  )
                                ],
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
                        return Text(snapshot.data.results[index].title);
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
