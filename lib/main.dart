import 'package:clean_arch_api_calling/src/core/routes/routes.dart';
import 'package:clean_arch_api_calling/src/features/homePage/presentation/bloc/post_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/detailsPage/presentation/bloc/details_page_bloc.dart';
import 'src/features/homePage/presentation/pages/post_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostBloc(),
        ),
        BlocProvider(
          create: (context) => DetailsPageBloc(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PostPage(),
      ),
    );
  }
}
