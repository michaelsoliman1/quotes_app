import 'package:app_ui/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart' as p;

class PagedListView<T> extends StatelessWidget {
  const PagedListView({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    this.noItemsMessage,
    this.shrinkWrap = true,
    this.physics,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.scrollController,
    this.primary,
  });

  final p.PagingController<int, T> pagingController;
  final Widget Function(BuildContext, T, int) itemBuilder;

  final String? noItemsMessage;
  final bool shrinkWrap;

  final Axis scrollDirection;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final bool? primary;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(pagingController.refresh),
      child: p.PagedListView.separated(
        primary: primary,
        physics: physics,
        scrollController: scrollController,
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
        pagingController: pagingController,
        padding: padding ?? const EdgeInsets.all(20),
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        builderDelegate: p.PagedChildBuilderDelegate<T>(
          itemBuilder: itemBuilder,
          firstPageProgressIndicatorBuilder: (context) => const LoadingIndicator(),
          firstPageErrorIndicatorBuilder: (_) => const ErrorIndicator(),
          noItemsFoundIndicatorBuilder: (_) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40,
                ),
                const SizedBox(height: 10),
                if (noItemsMessage != null) Text(noItemsMessage!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}