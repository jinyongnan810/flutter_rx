import 'package:flutter/material.dart';

typedef AsyncSnapshotBuilderCallback<T> = Widget Function(
    BuildContext context, T? data);

class AsyncSnapshotBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final AsyncSnapshotBuilderCallback<T>? onNone;
  final AsyncSnapshotBuilderCallback<T>? onWaiting;
  final AsyncSnapshotBuilderCallback<T>? onActive;
  final AsyncSnapshotBuilderCallback<T>? onDone;
  const AsyncSnapshotBuilder(
      {Key? key,
      required this.stream,
      this.onNone,
      this.onWaiting,
      this.onActive,
      this.onDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
        stream: stream,
        builder: (ctx, snapShot) {
          switch (snapShot.connectionState) {
            case ConnectionState.none:
              final callback = onNone ?? (_, __) => const SizedBox.shrink();
              return callback(ctx, snapShot.data);
            case ConnectionState.waiting:
              final callback =
                  onWaiting ?? (_, __) => const CircularProgressIndicator();
              return callback(ctx, snapShot.data);
            case ConnectionState.active:
              final callback = onActive ?? (_, __) => const SizedBox.shrink();
              return callback(ctx, snapShot.data);
            case ConnectionState.done:
              final callback = onDone ?? (_, __) => const SizedBox.shrink();
              return callback(ctx, snapShot.data);
          }
        });
  }
}
