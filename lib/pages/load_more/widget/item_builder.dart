import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:td_flutter_unit/pages/load_more/repository/tuchong_source.dart';
import 'package:td_flutter_unit/utils/screen_util.dart';

Widget itemBuilder(BuildContext context, TuChongItem item, int index) {
  return Container(
    height: ScreenUtil.instance!.setWidth(kIsWeb ? 400.0 : 200.0),
    child: Stack(
      children: <Widget>[
        Positioned(
          child: kIsWeb
              ? ListView.builder(
                  itemBuilder: (BuildContext c, int index) {
                    return ExtendedImage.network(
                      item.images![index].imageUrl,
                      fit: BoxFit.cover,
                      width: ScreenUtil.instance!
                          .setWidth(kIsWeb ? 400.0 : double.infinity),
                      height:
                          ScreenUtil.instance!.setWidth(kIsWeb ? 400.0 : 200.0),
                      clearMemoryCacheWhenDispose: false,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: item.images!.length,
                )
              : ExtendedImage.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  //height: 200.0,
                  height: double.infinity,
                  clearMemoryCacheWhenDispose: false,
                ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            height: 40.0,
            color: Colors.grey.withOpacity(0.5),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.comment,
                      color: Colors.amberAccent,
                    ),
                    Text(
                      item.comments.toString(),
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
                /*
                LikeButton(
                  size: 20.0,
                  isLiked: item.isFavorite,
                  likeCount: item.favorites,
                  countBuilder: (int? count, bool isLiked, String text) {
                    final ColorSwatch<int> color =
                        isLiked ? Colors.pinkAccent : Colors.grey;
                    Widget result;
                    if (count == 0) {
                      result = Text(
                        'love',
                        style: TextStyle(color: color),
                      );
                    } else {
                      result = Text(
                        count! >= 1000
                            ? (count / 1000.0).toStringAsFixed(1) + 'k'
                            : text,
                        style: TextStyle(color: color),
                      );
                    }
                    return result;
                  },
                  likeCountAnimationType: item.favorites! < 1000
                      ? LikeCountAnimationType.part
                      : LikeCountAnimationType.none,
                  onTap: (bool isLiked) {
                    return onLikeButtonTap(isLiked, item);
                  },
                ),
              */
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildWaterfallFlowItem(BuildContext c, TuChongItem item, int index,
    {bool konwSized = true}) {
  const double fontSize = 12.0;

  Widget image = Stack(
    children: <Widget>[
      ExtendedImage.network(
        item.imageUrl,
        shape: BoxShape.rectangle,
        clearMemoryCacheWhenDispose: false,
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1.0),
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        loadStateChanged: (ExtendedImageState value) {
          if (value.extendedImageLoadState == LoadState.loading) {
            Widget loadingWidget = Container(
              alignment: Alignment.center,
              color: Colors.grey.withOpacity(0.8),
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor:
                    AlwaysStoppedAnimation<Color>(Theme.of(c).primaryColor),
              ),
            );
            if (!konwSized) {
              loadingWidget = AspectRatio(
                aspectRatio: 1.0,
                child: loadingWidget,
              );
            }
            return loadingWidget;
          } else if (value.extendedImageLoadState == LoadState.completed) {
            item.imageRawSize = Size(
                value.extendedImageInfo!.image.width.toDouble(),
                value.extendedImageInfo!.image.height.toDouble());
          }
          return null;
        },
      ),
      Positioned(
        top: 5.0,
        right: 5.0,
        child: Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.6),
            border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1.0),
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Text(
            '${index + 1}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: fontSize, color: Colors.white),
          ),
        ),
      )
    ],
  );
  if (konwSized) {
    image = AspectRatio(
      aspectRatio: item.imageSize.width / item.imageSize.height,
      child: image,
    );
  } else if (item.imageRawSize != null) {
    image = AspectRatio(
      aspectRatio: item.imageRawSize!.width / item.imageRawSize!.height,
      child: image,
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      image,
      const SizedBox(
        height: 5.0,
      ),
      buildTagsWidget(item),
      const SizedBox(
        height: 5.0,
      ),
      buildBottomWidget(item),
    ],
  );
}

Widget buildTagsWidget(
  TuChongItem item, {
  int maxNum = 6,
}) {
  const double fontSize = 12.0;
  return Wrap(
      runSpacing: 5.0,
      spacing: 5.0,
      children: item.tags!.take(maxNum).map<Widget>((String? tag) {
        final Color color = item.tagColors![item.tags!.indexOf(tag)];
        return Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1.0),
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Text(
            tag!,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: fontSize,
                color: color.computeLuminance() < 0.5
                    ? Colors.white
                    : Colors.black),
          ),
        );
      }).toList());
}

Widget buildBottomWidget(TuChongItem item, {bool showAvatar = true}) {
  const double fontSize = 12.0;
  return Row(
    children: <Widget>[
      if (showAvatar)
        ExtendedImage.network(
          item.avatarUrl!,
          width: 25.0,
          height: 25.0,
          shape: BoxShape.circle,
          //enableLoadState: false,
          border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1.0),
          loadStateChanged: (ExtendedImageState state) {
            if (state.extendedImageLoadState == LoadState.completed) {
              return null;
            }
            return Image.asset(
              'assets/dog.png',
            );
          },
        ),
      Expanded(
        child: Container(),
      ),
      Row(
        children: <Widget>[
          const Icon(
            Icons.comment,
            color: Colors.amberAccent,
            size: 18.0,
          ),
          const SizedBox(
            width: 3.0,
          ),
          Text(
            item.comments.toString(),
            style: const TextStyle(color: Colors.black, fontSize: fontSize),
          )
        ],
      ),
      const SizedBox(
        width: 3.0,
      ),
      /*
      LikeButton(
        size: 18.0,
        isLiked: item.isFavorite,
        likeCount: item.favorites,
        countBuilder: (int? count, bool isLiked, String text) {
          final ColorSwatch<int> color =
              isLiked ? Colors.pinkAccent : Colors.grey;
          Widget result;
          if (count == 0) {
            result = Text(
              'love',
              style: TextStyle(color: color, fontSize: fontSize),
            );
          } else {
            result = Text(
              count! >= 1000 ? (count / 1000.0).toStringAsFixed(1) + 'k' : text,
              style: TextStyle(color: color, fontSize: fontSize),
            );
          }
          return result;
        },
        likeCountAnimationType: item.favorites! < 1000
            ? LikeCountAnimationType.part
            : LikeCountAnimationType.none,
        onTap: (bool isLiked) {
          return onLikeButtonTap(isLiked, item);
        },
      ),
    */
    ],
  );
}
