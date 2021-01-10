import 'package:flutter/material.dart';
import 'package:timecapturesystem/models/lms/not_available_users.dart';
import 'package:timecapturesystem/view/lms/admin_leave/absent_user_detail_screen.dart';
import 'package:timecapturesystem/view/lms/admin_leave/admin_leave_card.dart';

import 'absent_day_card.dart';

class AbsentUserListViewBuilder extends StatelessWidget {
  final List<NotAvailableUsers> list;

  const AbsentUserListViewBuilder({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: AbsentDayCard(item: list[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AbsentUserDetailScreen(item: list[index]),
              ),
            );
          },
        );
      },
    );
  }
}
