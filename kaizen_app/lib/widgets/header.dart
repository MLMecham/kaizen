import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLogout;

  const Header({
    Key? key,
    required this.title,
    this.showLogout = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use your app's primary color or choose a slightly darker shade
    final Color topBarColor = Colors.blueGrey.shade900; // darker than default blue

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 4,
          color: topBarColor,
        ),
        AppBar(
          title: Text(title),
          centerTitle: true,
          leading: showLogout
              ? IconButton(
                  icon: Icon(Icons.logout),
                  tooltip: 'Logout',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                )
              : null,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 4);
}