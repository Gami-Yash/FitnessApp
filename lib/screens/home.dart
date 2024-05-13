// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, sized_box_for_whitespace, unnecessary_import, unused_local_variable, sort_child_properties_last
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fadable_app_bar/fadable_app_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: MyAppBar(scrollController: _controller),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(),
            SizedBox(height: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HorizontalSwiper(),
                  SizedBox(height: 16),
                  Text(
                    "Quick Action",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  buildQuickActionButtons(),
                  SizedBox(height: 0),
                  buildOverviewAndDropDown(),
                  SizedBox(height: 0),
                  buildDataBoxes(),
                  Text("View All"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Add your navigation logic here
        },
      ),
    );
  }
}

Widget buildBottomNavigationBar(
    {required int selectedIndex, required Function(int) onItemTapped}) {
  return BottomNavigationBar(
    currentIndex: selectedIndex,
    onTap: onItemTapped,
    selectedItemColor: Colors.black, // Set selected item color
    unselectedItemColor: Colors.black, // Set unselected item color
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: 'Members',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.insights),
        label: 'Insights',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.manage_accounts),
        label: 'Manage',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
  );
}


// Other widget functions...




class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ScrollController scrollController;

  const MyAppBar({Key? key, required this.scrollController}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prime Fitness',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              children: [
                Text(
                  'Branch: Barakar',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(width: 4),
                DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Icon(Icons.arrow_drop_down),
                      onTap: () {
                        // Handle tap on dropdown
                      },
                    ),
                  ],
                  onChanged: (_) {},
                  icon: SizedBox.shrink(),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            ),
            icon: Icon(Icons.visibility),
            label: Text('View Listing'),
          ),
        ),
      ],
      automaticallyImplyLeading: false,
    );
  }
}
class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 12.0),
            hintText: 'Search for customers, bookings',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}



class HorizontalSwiper extends StatefulWidget {
  const HorizontalSwiper({Key? key}) : super(key: key);

  @override
  _HorizontalSwiperState createState() => _HorizontalSwiperState();
}

class _HorizontalSwiperState extends State<HorizontalSwiper> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          VxSwiper.builder(
            itemCount: 4,
            height: 100,
            viewportFraction: 1.0,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 400,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 30,),
                          Icon(Icons.warning,
                              size: 50,
                              color: index == currentIndex ? Colors.blue : Colors.grey),
                          SizedBox(width: 16),
                          Text(
                            '2 Memberships expiring today',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16),
                          Text(
                            '${index + 1}/4',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Remind them now >>>'),
                        ...List.generate(4, (dotIndex) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: dotIndex == index ? Colors.blue : Colors.grey,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}


class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const QuickActionButton({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Container(

          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 30, color: Colors.black),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}


// Function to build the quick action buttons
Widget buildQuickActionButtons() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        QuickActionButton(
          icon: Icons.person,
          label: "Add Member",
        ),
        QuickActionButton(
          icon: Icons.fitness_center,
          label: "Add PT",
        ),
        QuickActionButton(
          icon: Icons.shopping_cart,
          label: "Add Sale",
        ),
        QuickActionButton(
          icon: Icons.money,
          label: "Add Expense",
        ),
      ],
    ),
  );
}

Widget buildOverviewAndDropDown() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Overview",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        DropdownButton<String>(
          value: "This Week", // Initial value
          onChanged: (String? newValue) {
            // Handle dropdown value change
          },
          items: <String>['This Week', 'Last Week', 'Custom Range'] // Dropdown items
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}


Widget buildDataBoxes() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildDataBox("Total Members", "300↑", Icons.arrow_forward_ios, Colors.green, isMenu: true),
            buildDataBox("Total Sales", "25000↑", Icons.arrow_forward_ios, Colors.green, isMenu: true),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildDataBox("Active PT", "17↑", Icons.arrow_forward_ios, Colors.green,isMenu: true),
            buildDataBox("Gym Views", "189↓", Icons.arrow_downward, Colors.red, isMenu: true),
          ],
        ),
      ],
    ),
  );
}
Widget buildDataBox(String title, String value, IconData icon, Color color, {bool isMenu = false}) {
  return Container(
    width: 150,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(
              isMenu ? Icons.arrow_drop_down : icon,
              color: Colors.black,
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.arrow_upward,
              color: color,
            ),
          ],
        ),
      ],
    ),
  );
}
