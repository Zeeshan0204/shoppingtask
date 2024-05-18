import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertask/BaseScreen.dart';
import 'package:fluttertask/SplashScreen.dart';
import 'package:fluttertask/core/config/routes.dart';
import 'package:fluttertask/core/utils/shared_pref.dart';
import 'package:fluttertask/core/utils/shared_pref_const.dart';
import 'package:fluttertask/presentation/bloc_logic/category_bloc/category_bloc.dart';
import 'package:fluttertask/presentation/bloc_logic/login_bloc/login_bloc.dart';
import 'package:fluttertask/presentation/bloc_logic/product_bloc/product_bloc.dart';
import 'package:fluttertask/presentation/screens/home_screen.dart';
import 'package:fluttertask/presentation/screens/login.dart';
import 'package:fluttertask/src/data/database/database_helper.dart';

import 'package:provider/provider.dart';

import 'core/config/themes/theme.dart';

bool splashVisible = false;
class CounterModel extends ChangeNotifier{
  int _counter=0;
  int get counter => _counter;

  void increment(){
    _counter++;
    notifyListeners();
  }
}


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();



  bool? loginStatus = await CommonSharedPreference.getBoolValues(SharedPreferenceConstants.loginStatus);

  runApp(ChangeNotifierProvider(
      create: (context)=>CounterModel(),
    child:  MyApp(
         screen: loginStatus==true? const HomeScreen():const Login(),
    ),
  )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key,this.screen});
  final Widget? screen;


  @override
  State<MyApp> createState()=> _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  void initState() {
    //splashHandler();
    super.initState();

  }

  splashHandler() async {
    splashVisible = true;
    await Future.delayed(const Duration(seconds: 3), () {});
    splashVisible = false;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: null,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
     return MultiBlocProvider(
       providers: [
         //BlocProvider(create: (context) => LoginBloc()),
         BlocProvider(create: (context) => ProductBloc()),
         BlocProvider(create: (context) => CategoryBloc()),
         BlocProvider(create: (context) => LoginBloc()),

       ],
       child: GestureDetector(
         onTap: () {
           FocusScope.of(context).unfocus();
         },
         child: MaterialApp(
           title: 'Shopping App',
           theme: AppTheme.of(context),
           home: splashVisible == true ? const Splashscreen() : widget.screen,
           // home: const SplashScreen(),
           onGenerateRoute: Routers.generateRoute,
         ),
       ),
     );

  }

}





