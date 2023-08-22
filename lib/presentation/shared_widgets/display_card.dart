import 'package:bloctask/business_logic/property_bloc/property_bloc.dart';
import 'package:bloctask/presentation/shared_widgets/custom_loading_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:svg_icon/svg_icon.dart';

import '../../data/models/property_model.dart';

class DisplayCard extends StatefulWidget {
  final AvailableSpace? availableSpace;

  DisplayCard({this.availableSpace});

  @override
  State<DisplayCard> createState() => _DisplayCardState();
}

class _DisplayCardState extends State<DisplayCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.availableSpace == null) {
      return Center(
        child: Text('No data available.'),
      );
    }

    print(widget.availableSpace!.propertyName);
    return Card(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(24, 10, 24, 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: widget.availableSpace!.spaceImages.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        widget.availableSpace!.spaceImages[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                              color: Color.fromARGB(255, 224, 224, 224),
                              child: Center(child: CustomLoadingWidget()));
                        },
                      ),
                    );
                  },
                  options: CarouselOptions(
                    initialPage: widget.availableSpace!.currentIndex,
                    aspectRatio: 14 / 9,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) => {
                      BlocProvider.of<PropertyBloc>(context).add(
                          OnSetIndexSpace(
                              availableSpace: widget.availableSpace!,
                              index: index))
                    },
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: DotsIndicator(
                    dotsCount: widget.availableSpace!.spaceImages.length,
                    position: widget.availableSpace!.currentIndex,
                    decorator: DotsDecorator(
                      color: Colors.grey, // Inactive dot color.
                      activeColor: Colors.white, // Active dot color.
                      size: const Size.square(10.0), // Dot size.

                      spacing:
                          const EdgeInsets.all(4.0), // Spacing between dots.
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.availableSpace!.propertyName,
                          style: TextStyle(
                              fontFamily: "MontserratRegular", fontSize: 16),
                        ),
                        Text(
                          widget.availableSpace!.spaceTitle,
                          style: TextStyle(
                              fontFamily: "MontserratMedium", fontSize: 14),
                        ),
                        Text(
                          widget.availableSpace!.spaceDescription,
                          style: TextStyle(
                              fontFamily: "MontserratRegular", fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgIcon(
                              'assets/icon/starIcon.svg',
                              color: Colors.orange,
                            ),
                            Text("${widget.availableSpace!.spaceRating}")
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Starting Price",
                                  style: TextStyle(
                                      fontFamily: 'MontserratRegular',
                                      fontSize: 8,
                                      color: Color(0xFFF9F9F9)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "\$${widget.availableSpace!.spacePrice}",
                                      style: TextStyle(
                                          fontFamily: 'MontserratSemiBold',
                                          fontSize: 12,
                                          color: Color(0xFFF9F9F9)),
                                    ),
                                    Text(
                                      "/night",
                                      style: TextStyle(
                                          fontFamily: 'MontserratMedium',
                                          fontSize: 12,
                                          color: Color(0xFFF9F9F9)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
