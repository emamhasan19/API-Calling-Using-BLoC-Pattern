import 'dart:async';
import 'dart:convert';

import 'package:clean_arch_api_calling/src/features/homePage/data/models/post_model.dart';
import 'package:clean_arch_api_calling/src/features/homePage/presentation/bloc/post_page_event.dart';
import 'package:clean_arch_api_calling/src/features/homePage/presentation/bloc/post_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<FetchPostsEvent>((event, emit) async {
      try {
        // Show loading state
        emit(PostLoading());

        // Make the API call to fetch posts
        final posts = await fetchPosts();

        // Update the state with the fetched posts
        emit(PostLoaded(posts));
      } catch (error) {
        // Handle error state
        emit(PostError('Failed to fetch posts: $error'));
      }
    });
  }

  Future<List<PostModel>> fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonPosts = jsonDecode(response.body);
      return jsonPosts.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to fetch posts. Status code: ${response.statusCode}');
    }
  }
}
