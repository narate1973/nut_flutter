import 'package:flutter/material.dart';

class HomeBottomNavItem {
  static const BottomNavigationBarItem home = BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'หน้าหลัก',
  );

  static const BottomNavigationBarItem patrol = BottomNavigationBarItem(
    icon: Icon(Icons.account_balance_rounded),
    label: 'ตรวจจุด',
  );

  static const BottomNavigationBarItem notification = BottomNavigationBarItem(
    icon: Icon(Icons.notification_add_outlined),
    label: 'แจ้งเตือน',
  );
}
