import 'package:flutter/material.dart';
import 'package:trulysocial/services/cloud/cloud_social_work.dart';

typedef SocialWorkCallback = void Function(SocialWork);

class SocialWorkListView extends StatelessWidget {
  final Iterable<SocialWork> works;
  final SocialWorkCallback onTap;
  const SocialWorkListView({
    Key? key,
    required this.works,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: works.length,
      itemBuilder: (context, index) {
        final currentSocialWork = works.elementAt(index);
        return ListTile(
          title: Text(
            currentSocialWork.title ?? 'Untitles',
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
          subtitle: Text(currentSocialWork.description ?? 'No Description'),
          onTap: () => onTap(currentSocialWork),
        );
      },
    );
  }
}
