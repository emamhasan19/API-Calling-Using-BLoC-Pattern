import 'package:clean_arch_api_calling/src/core/colors.dart';
import 'package:clean_arch_api_calling/src/core/routes/routing_constant.dart';
import 'package:clean_arch_api_calling/src/features/homePage/presentation/bloc/post_page_bloc.dart';
import 'package:clean_arch_api_calling/src/features/homePage/presentation/bloc/post_page_event.dart';
import 'package:clean_arch_api_calling/src/features/homePage/presentation/bloc/post_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//using blocConsumer

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    context.read<PostBloc>().add(FetchPostsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final postBloc = BlocProvider.of<PostBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AIM API',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Palette.primary_color,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            final posts = state.posts;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                // return ListTile(
                //   title: Text(post.title),
                //   subtitle: Text(post.body),
                // );
                return GestureDetector(
                  onTap: () {
                    // context.read<DetailsPageBloc>().add(ShowDetailsEvent());
                    Navigator.pushNamed(context, detailsPageRoute,
                        arguments: post);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2.0),
                    child: Card(
                      color: index % 2 == 0
                          ? Palette.secondary_color
                          : Palette.primary_color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            color: index % 2 == 0
                                ? Palette.primary_color
                                : Palette.secondary_color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 40,
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: index % 2 == 0
                                    ? Palette.secondary_color
                                    : Palette.primary_color,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          (post.title).substring(0, 12),
                          style: TextStyle(
                            fontSize: 20,
                            color: index % 2 == 0
                                ? Palette.primary_color
                                : Palette.secondary_color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${(post.body).substring(0, 10)}...',
                          style: TextStyle(
                            fontSize: 16,
                            color: index % 2 == 0
                                ? Palette.primary_color
                                : Palette.secondary_color,
                          ),
                        ),
                        trailing: Icon(
                          index % 2 == 0 ? Icons.api : Icons.exit_to_app,
                          size: 30,
                          color: index % 2 == 0
                              ? Palette.primary_color
                              : Palette.secondary_color,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Palette.white_color,
      //   onPressed: () {
      //     // postBloc.add(FetchPostsEvent());
      //     context.read<PostBloc>().add(FetchPostsEvent());
      //   },
      //   child: const Icon(
      //     Icons.refresh,
      //     color: Palette.primary_color,
      //   ),
      // ),
    );
  }
}

//using blocBuilder

//
// class PostPage extends StatelessWidget {
//   const PostPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final postBloc = BlocProvider.of<PostBloc>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Posts'),
//       ),
//       body: BlocBuilder<PostBloc, PostState>(
//         builder: (context, state) {
//           if (state is PostLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is PostLoaded) {
//             final posts = state.posts;
//             return ListView.builder(
//               itemCount: posts.length,
//               itemBuilder: (context, index) {
//                 final post = posts[index];
//                 return ListTile(
//                   title: Text(post.title),
//                   subtitle: Text(post.body),
//                 );
//               },
//             );
//           } else if (state is PostError) {
//             return Center(child: Text(state.errorMessage));
//           } else {
//             return Container();
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           postBloc.add(FetchPostsEvent());
//         },
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
// }
