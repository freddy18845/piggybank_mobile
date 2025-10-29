import 'dart:async';

import 'package:piggy_bank/widgets/inputFeild.dart';
import 'package:flutter/material.dart';
import 'package:piggy_bank/widgets/loader.dart';

import '../constant.dart';
import '../utils/fonts_style.dart';
import '../utils/screen_size.dart';
import '../widgets/empty_table.dart';
import '../widgets/header.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  int index = 0;
  bool isLoading = true;
  List<String> sortOptions = ["Alphabet", "Account ID"];
  String sortype = 'Alphabet';
  Map<String, dynamic> filteredCustomers = {};
  final ScrollController _scrollController = ScrollController();
  static const int _pageSize = 15;
  int _currentMax = _pageSize;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isLoading = true;
        filteredCustomers = customersStorage;
        isLoading =false;
      });
    });
  }






  getTable({required Widget rowData, required Color bodyColor}) {
    return Container(
        width: double.infinity,
        height: ScreenSize().getScreenHeight(3.5),
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSize().getScreenWidth(2),
            vertical: ScreenSize().getScreenHeight(0.6)),
        decoration: BoxDecoration(
          color: bodyColor,
          // borderRadius:isHeader? BorderRadius.only(
          //   topRight: Radius.circular(15),
          //       topLeft: Radius.circular(15)
          // ):BorderRadius.only(
          //     bottomLeft: Radius.circular(15),
          //     bottomRight: Radius.circular(15)
          // )

        ),
        child: Center(
          child: rowData,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/${IMAGES[2]}',
                ),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            const Header(
              showHome: false,
              showPrevious: true,
              showLogo: false,
              selectedBtn: 'Customer List',
              show2Nav: true,
            ),
            SizedBox(
              height: ScreenSize().getScreenHeight(3),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize().getScreenWidth(4)),
              child: InputFeild(
                isOptional: false,
                isNum: true,
                icon: Icons.search,
                inputLimit: 12,
                placeholder: 'g. ASA1234556',
                inputFeild: () {},
                inputLabel: 'By Account ID or Last Name',
              ),
            ),



            Expanded(child: Column(

              children: [
                isLoading == false
                    ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize().getScreenWidth(4)),
                  child: Column(

                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       bottom: ScreenSize().getScreenHeight(2)),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       Text(
                      //         'Sort By :',
                      //         style: FontsStyle().sortText(),
                      //       ),
                      //       SizedBox(
                      //         width: ScreenSize().getScreenWidth(2),
                      //       ),
                      //       Wrap(
                      //         children: sortOptions
                      //             .asMap()
                      //             .entries
                      //             .map<Widget>(
                      //                 (listItem) => getBtn(listItem.value))
                      //             .toList(),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                        Container(
                          height: ScreenSize().getScreenHeight(75),
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.only(
                              top:filteredCustomers.isEmpty?ScreenSize().getScreenHeight(35): ScreenSize().getScreenHeight(25)),
                        child:filteredCustomers.isEmpty
                            ? const Center(
                            child: EmptyTable()
                        )
                            : Column(
                          children: [
                            getTable(
                              bodyColor: SECONDARY_COLOR,
                              rowData: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Full Name',
                                        style: FontsStyle().tabletitle(),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Account No.',
                                        style: FontsStyle().tabletitle(),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Status',
                                        style: FontsStyle().tabletitle(),
                                      ),
                                    ),
                                  ]),
                            ),
                          ListView.builder(
                            controller: _scrollController,
                            itemCount: _currentMax.clamp(0, filteredCustomers.length),
                            itemBuilder: (context, index) {
                              final key = filteredCustomers.keys.elementAt(index);
                              final data = filteredCustomers[key];
                              if (data == null) return const SizedBox();
                              return getTable(
                                bodyColor: Colors.transparent,
                                rowData: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'Fred Oppong',
                                          style: FontsStyle().tabledata(),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'ADS24A00028Y',
                                          style: FontsStyle().tabledata(),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Active',
                                          style: FontsStyle().tabledata(),
                                        ),
                                      ),
                                    ]),
                              );
                            },
                          )
                        ],),
                      ),

                    ],
                  ),
                )
                    : Expanded(
                    child: Loader()
                ),
                if (_currentMax < filteredCustomers.length)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SECONDARY_COLOR,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _currentMax = (_currentMax + _pageSize)
                              .clamp(0, filteredCustomers.length);
                        });
                      },
                      child: const Text(
                        'Load More',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ))
          ],
        ),
      )),
    );
  }
}
