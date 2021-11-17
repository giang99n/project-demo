import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:projectbnk/blocs/get_post/get_post_bloc.dart';
import 'package:projectbnk/models/home_get_post_res.dart';
import 'package:projectbnk/network/apis.dart';
import 'package:projectbnk/ui/home/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MultiBlocProvider(
        providers: [
          BlocProvider<GetPostBloc>(
              create: (_) => GetPostBloc()..add(GetPostEventStated())),
        ],
        child: Scaffold(
          //extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Container(
              child: Text(
                'HuntSub',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(6.5),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(
                    width: 1,
                    color: Colors.blue.withOpacity(0.5),
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.search_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: BuildHomeScreen(),
        ));
  }
}

class BuildHomeScreen extends StatefulWidget {
  const BuildHomeScreen({Key? key}) : super(key: key);

  @override
  _BuildHomeScreenState createState() => _BuildHomeScreenState();
}

class _BuildHomeScreenState extends State<BuildHomeScreen>
    with SingleTickerProviderStateMixin {
  String _token = '';

  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: [
          TabBar(
            unselectedLabelColor: Colors.black54,
            labelColor: Colors.blue,
            tabs: const [
              Tab(
                child: Icon(
                  Icons.home,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.person,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                ),
              ),
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              children: [
                _home(context),
                ProFileScreen(),
                _notify(context),
                _rank(context)
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _home(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HomeGetPostResponse homeGetPostResponse;
    return
      Container(
      margin: const EdgeInsets.only(top: 10),
      child: BlocBuilder<GetPostBloc, GetPostState>(builder: (context, state) {
        if (state is GetPostLoadingState) {
          return Container(
              alignment: Alignment.topCenter,
              height: size.height * 0.18,
              child: const CircularProgressIndicator());
        } else if (state is GetPostLoadedState) {
          homeGetPostResponse = state.listPost;
          List<Datum>? listPostResponse = homeGetPostResponse.data;

          return SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  height: size.height * 0.7,
                  child: ListView.builder(
                    itemBuilder: (BuildContext buildContext, int index) {
                      String? img = listPostResponse![index].avatar;
                      bool isAvatar =
                          listPostResponse![index].avatar!.isNotEmpty;
                      return index==0? Column(
                        children: [
                          Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7.5)),
                              side: BorderSide(color: Color(0xffdbddde), width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                      backgroundImage:
                                      AssetImage('assets/images/meo.jpg')),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 5, right: 5),
                                      height: 45,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(30)),
                                            side: BorderSide(
                                                color: Color(0xffCED0D2), width: 0.6),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          "Enter your text her",
                                          style:
                                          TextStyle(fontSize: 16, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(6,6,6,6),
                            width: size.width * 0.8,
                            child: Row(
                              children: const <Widget>[
                                Expanded(
                                  child: Divider(
                                    color: Color(0xFFD9D9D9),
                                    height: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "New feed",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Color(0xFFD9D9D9),
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                              side:
                              BorderSide(color: Color(0xffdbddde), width: 0.4),
                            ),
                            child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: isAvatar
                                          ? CircleAvatar(
                                          backgroundImage: NetworkImage(img!))
                                          : const CircleAvatar(
                                          backgroundImage:
                                          AssetImage('assets/images/meo.jpg')),
                                      title: Text(
                                        listPostResponse![index].name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      subtitle: Text(
                                        listPostResponse![index].rankname.toString() +
                                            ' | ' +
                                            listPostResponse![index].job.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.red),
                                      ),
                                      isThreeLine: true,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listPostResponse![index].title.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.blue),
                                          ),
                                          Text(
                                            'Giá: ' +
                                                listPostResponse![index]
                                                    .price
                                                    .toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            'Mô tả : ' +
                                                listPostResponse![index]
                                                    .text
                                                    .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.05,
                                          ),
                                          Wrap(
                                            children: [
                                              const Icon(
                                                Icons.location_pin,
                                                color: Colors.red,
                                              ),
                                              Text(
                                                listPostResponse![index]
                                                    .location!
                                                    .address
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                            child: Divider(
                                              color: Colors.black,
                                              height: 2,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                    },
                                                    radius: 15,
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/icons/unlike.svg",
                                                          height: 21,
                                                          width: 21,
                                                          color: Colors.red,
                                                        ),
                                                        const SizedBox(
                                                          width: 1,
                                                        ),
                                                        Text(
                                                          listPostResponse![index]
                                                              .like
                                                              .toString(),
                                                          style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  InkWell(
                                                    onTap: () {},
                                                    radius: 15,
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .messenger_outline_rounded,
                                                        ),
                                                        const SizedBox(
                                                          width: 1,
                                                        ),
                                                        Text(
                                                          listPostResponse![index]
                                                              .comment
                                                              .toString(),
                                                          style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                readTimestamp(listPostResponse![index]
                                                    .mtime!
                                                    .toInt()),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          )
                        ],
                      ) :
                        Card(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                          side:
                              BorderSide(color: Color(0xffdbddde), width: 0.4),
                        ),
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: isAvatar
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(img!))
                                  : const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/meo.jpg')),
                              title: Text(
                                listPostResponse![index].name.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                listPostResponse![index].rankname.toString() +
                                    ' | ' +
                                    listPostResponse![index].job.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red),
                              ),
                              isThreeLine: true,
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listPostResponse![index].title.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blue),
                                  ),
                                  Text(
                                    'Giá: ' +
                                        listPostResponse![index]
                                            .price
                                            .toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Mô tả : ' +
                                        listPostResponse![index]
                                            .text
                                            .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.05,
                                  ),
                                  Wrap(
                                    children: [
                                      const Icon(
                                        Icons.location_pin,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        listPostResponse![index]
                                            .location!
                                            .address
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 2,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            radius: 15,
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/icons/unlike.svg",
                                                  height: 21,
                                                  width: 21,
                                                  color: Colors.red,
                                                ),
                                                const SizedBox(
                                                  width: 1,
                                                ),
                                                Text(
                                                  listPostResponse![index]
                                                      .like
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            radius: 15,
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons
                                                      .messenger_outline_rounded,
                                                ),
                                                const SizedBox(
                                                  width: 1,
                                                ),
                                                Text(
                                                  listPostResponse![index]
                                                      .comment
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        readTimestamp(listPostResponse![index]
                                            .mtime!
                                            .toInt()),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                      );
                    },
                    itemCount: listPostResponse!.length,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }


  Widget _notify(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(top: 10), child: Text('notify'));
  }

  Widget _rank(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(top: 10), child: Text('rank'));
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';
    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' day ago';
      } else {
        time = diff.inDays.toString() + ' days ago';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' week ago';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' wekks ago';
      }
    }

    return time;
  }
}
