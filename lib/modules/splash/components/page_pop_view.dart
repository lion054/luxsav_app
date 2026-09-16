import 'package:flutter/material.dart';
import 'package:luxsav_companion/constants/luxsav_brand.dart';
import 'package:luxsav_companion/constants/text_styles.dart';

class PagePopup extends StatelessWidget {
  final PageViewData imageData;

  const PagePopup({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 8,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 120,
              // Photos get the card radius; the kit's illustrations had none.
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(LuxRadius.card),
                  child: Image.asset(imageData.assetsImage, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            imageData.titleText,
            textAlign: TextAlign.center,
            style: TextStyles(context).heading(fontSize: 32),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            imageData.subText,
            textAlign: TextAlign.center,
            style: TextStyles(context).description(),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}

class PageViewData {
  final String titleText;
  final String subText;
  final String assetsImage;

  PageViewData({
    required this.titleText,
    required this.subText,
    required this.assetsImage,
  });
}
