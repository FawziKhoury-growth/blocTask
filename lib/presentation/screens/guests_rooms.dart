import 'package:bloctask/data/enums/guest_room_enum.dart';
import 'package:bloctask/navigation/route_navigator.dart';
import 'package:bloctask/presentation/shared_widgets/custom_button_widget.dart';
import 'package:bloctask/presentation/shared_widgets/custom_drop_down_list_property_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_icon/svg_icon.dart';

import '../../business_logic/guest_room_bloc/guest_room_bloc.dart';

class GuestsRooms extends StatefulWidget {
  const GuestsRooms({super.key});

  @override
  State<GuestsRooms> createState() => _GuestsRoomsState();
}

class _GuestsRoomsState extends State<GuestsRooms> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<GuestRoomBloc, GuestRoomState>(
      listener: (context, state) {
        // if (state.guestRoomStatus == GuestRoomStatus.success ||
        //     state.guestRoomStatus == GuestRoomStatus.none) {
        // Navigator.pop(context);
        // }
      },
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<GuestRoomBloc, GuestRoomState>(
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height - 100,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Color(0xFFF9F9F9),
                    border: Border.all(color: Color(0xFF3C495540)),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Who's coming?",
                          style: TextStyle(
                              fontFamily: "MontserratMedium", fontSize: 18),
                        ),
                        TextButton(
                            onPressed: () =>
                                BlocProvider.of<GuestRoomBloc>(context)
                                    .add(OnClearEvent()),
                            child: Text(
                              "Clear",
                              style: TextStyle(
                                fontFamily: "MontserratMedium",
                                fontSize: 12,
                                color: Color(0xFF297BE6),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [Text("Adult"), Text("Ages 13+")],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  BlocProvider.of<GuestRoomBloc>(context)
                                      .add(OnDecreamentAdultEvent()),
                              icon: SvgIcon(
                                "assets/icon/minusIcon.svg",
                                height: 24,
                              ),
                            ),
                            Container(
                              width: 30,
                              child: Text(
                                "${state.adultCounter}",
                                style:
                                    TextStyle(fontFamily: 'MontserratRegular'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  BlocProvider.of<GuestRoomBloc>(context)
                                      .add(OnIncreamentAdultEvent()),
                              icon: SvgIcon(
                                "assets/icon/plusIcon.svg",
                                color: Color(0xFF297BE6),
                                height: 24,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Children"),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  BlocProvider.of<GuestRoomBloc>(context)
                                      .add(OnDecreamentChildEvent()),
                              icon: SvgIcon(
                                "assets/icon/minusIcon.svg",
                                height: 24,
                              ),
                            ),
                            Container(
                              width: 30,
                              child: Text(
                                "${state.childrenCounter}",
                                style:
                                    TextStyle(fontFamily: 'MontserratRegular'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  BlocProvider.of<GuestRoomBloc>(context)
                                      .add(OnIncreamentChildEvent()),
                              icon: SvgIcon(
                                "assets/icon/plusIcon.svg",
                                color: Color(0xFF297BE6),
                                height: 24,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (state.childrenCounter == 0)
                      SizedBox(
                        height: 250,
                      ),
                    if (state.childrenCounter > 0)
                      Container(
                        decoration: BoxDecoration(
                            border: Border.symmetric(
                                horizontal: BorderSide(color: Colors.black))),
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: 250,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: state.childrenCounter,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Child ${index + 1}:  ",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      DropdownButton2<int>(
                                        value: state.childrenAge[index] == 0
                                            ? null
                                            : state.childrenAge[index],
                                        hint: Text("Age",
                                            style: TextStyle(
                                                color: Colors.cyan,
                                                fontSize: 18)),
                                        onChanged: (newValue) {
                                          BlocProvider.of<GuestRoomBloc>(
                                                  context)
                                              .add(
                                            OnChangeChildAgeEvent(
                                              age: newValue!,
                                              index: index,
                                            ),
                                          );
                                        },
                                        items: List.generate(13, (index) {
                                          return DropdownMenuItem<int>(
                                            value: index + 1,
                                            child: Text((index + 1).toString(),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 216, 113, 113),
                                                    fontSize: 18)),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 400,
                      height: 48,
                      child: CustomButtonWidget(
                        title: "SEARCH",
                        color: Color(0xFFF8AE56),
                        TextColor: Color(0Xff323E48),
                        radius: 7,
                        onPressed:
                            state.guestRoomStatus == GuestRoomStatus.notChecked
                                ? null
                                : () {
                                    Navigator.pop(context);
                                  },
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
