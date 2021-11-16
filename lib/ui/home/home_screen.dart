import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectbnk/blocs/get_post/get_post_bloc.dart';
import 'package:projectbnk/blocs/login/login_bloc.dart';
import 'package:projectbnk/models/home_get_post_res.dart';
import 'package:projectbnk/network/apis.dart';
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
    getToken();
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
                _profile(context),
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
    return Container(
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

          return Container(
            alignment: Alignment.center,
            child: ListView.builder(
              itemBuilder: (BuildContext buildContext, int index) {
                String? img = listPostResponse![index].avatar;
                bool isAvatar = listPostResponse![index].avatar!.isNotEmpty;
                print(isAvatar.toString() + '22222222222222');
                return Card(
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          leading: isAvatar ? CircleAvatar(backgroundImage: NetworkImage(img!)) : const CircleAvatar(backgroundImage: AssetImage('assets/images/meo.jpg')),
                          title: Text(
                            listPostResponse![index].name.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w700, ),
                          ),
                        subtitle: Text(
                          listPostResponse![index].rankname.toString()+ ' | ' + listPostResponse![index].job.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400,color: Colors.red),
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
                              'Tên sản phẩm: '+listPostResponse![index].title.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 17,fontWeight: FontWeight.w400, color: Colors.blue),
                            ),
                            Text(
                              'Giá: '+listPostResponse![index].price.toString(),
                              style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500, ),
                            ),
                            Text(
                              'Mô tả : '+listPostResponse![index].text.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16, ),
                            ),
                            SizedBox(height: size.height*0.05,
                            ),
                            Wrap(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.red,
                                ),
                                Text(
                                  listPostResponse![index].location!.address.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle( fontStyle: FontStyle.italic,
                                    fontSize: 15, ),
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
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _profile(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Text(_token + 'profile'));
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

  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = (prefs.getString('token') ?? "");
    });
  }
}
