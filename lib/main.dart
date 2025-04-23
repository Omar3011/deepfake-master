import 'package:deepfake/Controler/HomeBloc/home_cubit.dart';
import 'package:deepfake/model/sing_up_model.dart';
import 'package:deepfake/view/auth/sign_in_sccreen.dart';
import 'package:deepfake/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Service/hive helper.dart';
import 'model/DeepModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DeepModelAdapter());
  await HiveHelper.intil();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: SignInScreen(),
      ),
    );
  }
}
