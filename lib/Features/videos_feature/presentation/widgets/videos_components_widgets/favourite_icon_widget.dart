import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shorts_app/Features/favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';
import 'package:new_shorts_app/Features/favourites_feature/presentation/cubit/toggle_favourites_cubit/toggle_favourites_cubit_cubit.dart';
import 'package:new_shorts_app/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:new_shorts_app/core/functions/toast_function.dart';
import 'package:new_shorts_app/core/notification_service/notification_helper.dart';
import 'package:new_shorts_app/core/service_locator/service_locator.dart';
import 'package:new_shorts_app/core/user_info/cubit/user_info_cubit.dart';
import 'package:new_shorts_app/core/widgets/custom_icon_widget.dart';

class FavouriteIconWidget extends StatefulWidget {
  const FavouriteIconWidget({super.key, required this.videoEntity});
  final VideoEntity videoEntity;

  @override
  State<FavouriteIconWidget> createState() => _FavouriteIconWidgetState();
}

class _FavouriteIconWidgetState extends State<FavouriteIconWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FavouritesCubit.get(context).getFavouritesCount(
      videoId: widget.videoEntity.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final favouritesCubit = FavouritesCubit.get(context);

    return BlocConsumer<ToggleFavouritesCubit, ToggleFavouritesState>(
      listener: _toggleFavouriteListener,
      builder: (context, state) {
        final notificationHelper = getIt.get<NotificationHelper>();
        final isFavorite =
            favouritesCubit.favorites[widget.videoEntity.id] ?? false;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _toggleFavourite(context, notificationHelper),
              icon: CustomIconWidget(
                icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.white,
              ),
            ),
            // Replaced StreamBuilder with BlocBuilder
            BlocBuilder<FavouritesCubit, FavouritesState>(
              builder: (context, state) {
                final count =
                    favouritesCubit.favouritesCount[widget.videoEntity.id] ?? 0;
                return Text(
                  count.toString(),
                  style: const TextStyle(color: Colors.white),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleFavouriteListener(
      BuildContext context, ToggleFavouritesState state) {
    if (state is ToggleFavouriteSuccessState) {
      FavouritesCubit.get(context).getFavourites(
        user: UserInfoCubit.get(context).userEntity!,
      );
    }

    if (state is ToggleFavoriteErrorState) {
      ToastHelper.showToast(message: state.message);
      final favouritesCubit = FavouritesCubit.get(context);

      var isFavorite =
          favouritesCubit.favorites[widget.videoEntity.id] ?? false;
      final previousCount =
          favouritesCubit.favouritesCount[widget.videoEntity.id] ?? 0;

      favouritesCubit.favorites[widget.videoEntity.id] = !isFavorite;
      final newCount = isFavorite ? previousCount - 1 : previousCount + 1;
      favouritesCubit.favouritesCount[widget.videoEntity.id] = newCount;
    }
  }

  void _toggleFavourite(
    BuildContext context,
    NotificationHelper notificationHelper,
  ) {
    final favouritesCubit = FavouritesCubit.get(context);
    final userEntity = UserInfoCubit.get(context).userEntity!;
    final isFavorite =
        favouritesCubit.favorites[widget.videoEntity.id] ?? false;
    final previousCount =
        favouritesCubit.favouritesCount[widget.videoEntity.id] ?? 0;

    favouritesCubit.favorites[widget.videoEntity.id] = !isFavorite;

    final newCount = isFavorite
        ? (previousCount - 1).clamp(0, double.infinity).toInt()
        : previousCount + 1;

    favouritesCubit.favouritesCount[widget.videoEntity.id] = newCount;

    ToggleFavouritesCubit.get(context).toggleFavourite(
      video: widget.videoEntity,
      userModel: userEntity,
    );
    notificationHelper.sendNotificationToSpecificUser(
      fcmToken: widget.videoEntity.user.fcmToken,
      userId: widget.videoEntity.user.id!,
      title: isFavorite ? 'Unfavourited' : 'Favourited',
      body: isFavorite
          ? 'Your video has been unfavourited'
          : 'Your video has been favourited',
      context: context,
    );
  }
}
