import 'package:bloctask/business_logic/property_bloc/property_bloc.dart';
import 'package:bloctask/data/enums/guest_room_enum.dart';
import 'package:bloctask/data/enums/property_enum.dart';
import 'package:bloctask/navigation/route_navigator.dart';
import 'package:bloctask/presentation/screens/guests_rooms.dart';
import 'package:bloctask/presentation/shared_widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_icon/svg_icon.dart';

import '../../business_logic/guest_room_bloc/guest_room_bloc.dart';
import '../../data/models/property_model.dart';
import '../shared_widgets/custom_drop_down_list_property_button.dart';
import '../shared_widgets/display_card.dart';
import '../shared_widgets/side_drawer.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    initiate();
  }

  void initiate() {
    BlocProvider.of<PropertyBloc>(context).add(OnFetchProperty());
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    TextStyle HintTextStyle =
        TextStyle(fontFamily: "MontserratRegular", fontSize: 12);
    return BlocBuilder<PropertyBloc, PropertyState>(
      buildWhen: (previous, current) =>
          previous.selectedProperty != current.selectedProperty,
      builder: (context, state) {
        return Scaffold(
            key: _scaffoldKey,
            drawer: SideDrawer(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10))),
              toolbarHeight: 160,
              backgroundColor: Color(0xFF3C4955),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () =>
                            {_scaffoldKey.currentState?.openDrawer()},
                        icon: SvgIcon(
                          'assets/icon/menu_icon.svg',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      if (state.propertyStatus == PropertyStatus.available)
                        CustomDropDownButton(
                          text: "Select Property",
                          icon: 'assets/icon/PropertyIcon.svg',
                          hintTextStyle: HintTextStyle,
                          listProperty: state.listProperty,
                          selectedProperty: state.selectedProperty,
                          onChanged: (PropertyModel value) {
                            BlocProvider.of<PropertyBloc>(context)
                                .add(OnSetSelectedProperty(value));
                          },
                        ),
                      if (state.propertyStatus != PropertyStatus.available)
                        CustomDropDownButton(
                          text: "loading....",
                          icon: 'assets/icon/PropertyIcon.svg',
                          hintTextStyle: HintTextStyle,
                        )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomDropDownButton(
                          text: "Select Dates",
                          icon: 'assets/icon/calenderIcon.svg',
                          hintTextStyle: HintTextStyle,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: BlocBuilder<GuestRoomBloc, GuestRoomState>(
                        builder: (context, state) {
                          return CustomButtonWidget(
                            color: Colors.white,
                            title: state.guestRoomStatus !=
                                    GuestRoomStatus.success
                                ? "Guests & Rooms"
                                : "${state.adultCounter} Adults ${state.childrenCounter} child",
                            radius: 5,
                            icon: SvgIcon('assets/icon/PropertyIcon.svg'),
                            onPressed: () {
                              RouteNavigator.goTo("guestRoom");
                            },
                            TextColor: Colors.black,
                          );
                        },
                      )),
                      SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: Container(
                decoration: BoxDecoration(color: Color(0xFFF9F9F9)),
                child: ListView(children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 0, 5),
                      child: Text(
                        'Available spaces',
                        style: TextStyle(
                            color: Color(0xFF323E48),
                            fontFamily: 'MontserratMedium',
                            fontSize: 16),
                      )),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.selectedProperty.availableSpaces.length,
                      itemBuilder: (context, index) {
                        return DisplayCard(
                            availableSpace:
                                state.selectedProperty.availableSpaces[index]);
                      }),
                ])));
      },
    );
  }
}
