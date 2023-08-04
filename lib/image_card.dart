import 'package:animated_travel_app/parallax_flow_delegate.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'location.dart';

class ImageCard extends StatelessWidget {
  ImageCard({
    super.key,
    required this.size,
    required this.location,
    required this.isSelected,
  });

  final Size size;
  final Location location;
  final bool isSelected;
  final GlobalKey _pictureKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: isSelected ? size.height * .5 : size.height * .47,
        margin: isSelected
            ? const EdgeInsets.all(0)
            : EdgeInsets.only(top: size.height * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 7),
              color: Colors.black.withOpacity(.3),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Flow(
              delegate: ParallaxFlowDelegate(
                scrollable: Scrollable.of(context),
                listItemContext: context,
                backgroundImageKey: _pictureKey,
              ),
              children: [
                Image.asset(
                  location.image,
                  fit: BoxFit.cover,
                  key: _pictureKey,
                ),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              bottom: isSelected ? 0 : -(size.height * .15),
              curve: Curves.easeIn,
              left: 0,
              right: 0,
              child: Container(
                height: size.height * .15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        location.country,
                        style: const TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        location.town,
                        style: const TextStyle(
                          color: kLightGreyColor,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
