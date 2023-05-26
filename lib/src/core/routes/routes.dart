import 'package:clean_arch_api_calling/src/core/routes/routing_constant.dart';
import 'package:clean_arch_api_calling/src/features/detailsPage/presentation/pages/details_page.dart';
import 'package:clean_arch_api_calling/src/features/homePage/data/models/post_model.dart';
import 'package:clean_arch_api_calling/src/features/homePage/presentation/pages/post_page.dart';
import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case myHomePageRoute:
      return MaterialPageRoute(builder: (context) => const PostPage());

    case detailsPageRoute:
      return MaterialPageRoute(
        builder: (context) => DetailsPage(
          postModel: settings.arguments as PostModel,
        ),
      );

    default:
      return null;
  }
}
