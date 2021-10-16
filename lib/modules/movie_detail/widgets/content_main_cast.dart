import 'package:app_movies/models/movie_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'movie_cast.dart';

class ContentMainCast extends StatelessWidget {
  ContentMainCast({Key? key, required this.movie}) : super(key: key);
  final MovieDetailsModel? movie;
  final showPanel = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Obx(
          () => ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (panelIndex, isExpanded) {
              showPanel.toggle();
            },
            elevation: 0,
            children: [
              ExpansionPanel(
                isExpanded: showPanel.value,
                canTapOnHeader: false,
                headerBuilder: (context, isExpanded) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Elenco',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
                body: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        movie?.cast.map((m) => MovieCast(cast: m)).toList() ??
                            [],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
