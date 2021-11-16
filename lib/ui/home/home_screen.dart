import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectbnk/blocs/login/login_bloc.dart';
import 'package:projectbnk/network/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:  [
          BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(LoginInitState(), Api()))
          // BlocProvider<HomeBloc>(
          //     create: (context) =>
          //         HomeBloc(ShipRegisterInitState(), Api())),
          // BlocProvider<ShipListOrderBloc>(
          //     create: (_) => ShipListOrderBloc()..add(ShipListOrderEventStated())),
        ],
        child: Container(
          color: Colors.white,
          child: SafeArea(
            top: true,
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
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.blueGrey.withOpacity(0.3),
                      //     spreadRadius: 1.5,
                      //     blurRadius: 1.5,
                      //     offset: Offset(0, 3), // changes position of shadow
                      //   ),
                      // ],
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
            ),
          ),
        ));
  }
}


class BuildHomeScreen extends StatefulWidget {
  const BuildHomeScreen({Key? key}) : super(key: key);

  @override
  _BuildHomeScreenState createState() => _BuildHomeScreenState();
}

class _BuildHomeScreenState extends State<BuildHomeScreen>  with SingleTickerProviderStateMixin {
  String _token='';

  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController =  TabController(length: 4, vsync: this);
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor: Colors.black54,
              labelColor: Colors.red,
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
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(_token+ 'home')
    );
  }
  Widget _profile(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Text(_token+'profile')
    );
  }
  Widget _notify(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Text('notify')
    );
  }
  Widget _rank(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Text('rank')
    );
  }



  void getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = (prefs.getString('token') ?? "");
    });
  }
}