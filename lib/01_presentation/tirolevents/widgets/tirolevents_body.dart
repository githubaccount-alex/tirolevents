import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tirolevents/01_presentation/tirolevents/widgets/tirolevent_item.dart';

import '../../../02_application/tiroleventsbloc/tirolevents_bloc.dart';
import '../../../02_application/tiroleventsbloc/tirolevents_event.dart';
import '../../../02_application/tiroleventsbloc/tirolevents_state.dart';
import '../../../03_domain/entities/tirolevents_entity.dart';

class TirolEventsBody extends StatelessWidget {
  final List<TirolEventsEntity> tirolEvents;

  const TirolEventsBody({Key? key, required this.tirolEvents})
      : super(key: key);

  static const double _spacing = 20;

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return BlocBuilder<TirolEventsBloc, TirolEventsState>(
      builder: (context, state) {
        if (state is TirolEventsStateLoaded) {
          _scrollController.addListener(() {
            if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent) {
              BlocProvider.of<TirolEventsBloc>(context)
                  .add(TirolEventsLoadMoreEvent());
            }
          });
          return SafeArea(
            child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                      padding: const EdgeInsets.all(_spacing),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final tirolEvent = state.tirolEventsList[index];
                            return TirolEventItem(tirolEventItem: tirolEvent);
                          },
                          childCount: state.tirolEventsList.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 150,
                                crossAxisSpacing: _spacing,
                                childAspectRatio: 4 / 5,
                                mainAxisSpacing: _spacing),
                      ))
                ]),
          );
        } else {
          return const Placeholder();
        }
      },
    );
  }
}
