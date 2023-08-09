import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../03_domain/entities/tirolevents_entity.dart';
import '../../routes/router.gr.dart';

class TirolEventItem extends StatelessWidget {
  final TirolEventsEntity tirolEventItem;

  const TirolEventItem({Key? key, required this.tirolEventItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        AutoRouter.of(context)
            .push(TirolEventDetailsRoute(tirolEvent: tirolEventItem));
      },
      child: Material(
        elevation: 16,
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(253, 242, 242, 1.0),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tirolEventItem.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    tirolEventItem.date,
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        tirolEventItem.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
