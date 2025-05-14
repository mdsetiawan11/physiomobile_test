import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:physiomobile_test/core/utils/constant.dart';
import 'package:physiomobile_test/models/post.dart';
import 'package:physiomobile_test/pages/splash_page.dart';
import 'package:provider/provider.dart';

import 'core/providers/counter_provider.dart';
import 'core/providers/form_provider.dart';
import 'core/providers/navigation_provider.dart';
import 'core/providers/post_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  await Hive.openBox<Post>('postsBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => PostProvider()),
        ChangeNotifierProvider(create: (context) => FormProvider()),
        ChangeNotifierProvider(create: (context) => CounterProvider()),
      ],
      child: MaterialApp(
        title: 'Physiomobile - Developer Testing',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: appColor),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
