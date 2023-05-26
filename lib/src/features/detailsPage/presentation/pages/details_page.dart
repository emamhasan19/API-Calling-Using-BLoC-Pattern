import 'package:clean_arch_api_calling/src/core/colors.dart';
import 'package:clean_arch_api_calling/src/features/detailsPage/presentation/bloc/details_page_bloc.dart';
import 'package:clean_arch_api_calling/src/features/homePage/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  final PostModel postModel;
  const DetailsPage({super.key, required this.postModel});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    context.read<DetailsPageBloc>().add(ShowDetailsEvent());
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
      body: BlocConsumer<DetailsPageBloc, DetailsPageState>(
        listener: (context, state) {
          if (state is DetailsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        builder: (context, state) {
          // final postModel = widget.postModel;
          if (state is DetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailsLoaded) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Card(
                    elevation: 4,
                    color: Palette.secondary_color,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              widget.postModel.title,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Palette.primary_color,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    color: Palette.primary_color,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        widget.postModel.body,
                        style: const TextStyle(
                            fontSize: 20, color: Palette.white_color),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text("Something went wrong");
          }
        },
      ),
    );
  }
}
