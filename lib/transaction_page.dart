import 'package:flutter/material.dart';
import 'package:hello_world/widget/transaction_card.dart';
import 'module/moma_user.dart';

// ignore: must_be_immutable
class TransactionPage extends StatefulWidget {
  final MomaUser appUser;

  const TransactionPage({Key key, this.appUser}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

List<String> monthList = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];
DateTime now = DateTime.now();

class _TransactionPageState extends State<TransactionPage> {
  String monthChoosen = monthList[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 64,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: DropdownButton(
                alignment: AlignmentDirectional.center,
                iconSize: 35,
                underline: const SizedBox(),
                elevation: 3,
                icon: const Icon(
                  Icons.expand_more,
                  color: Color(0xFF7F3DFF),
                ),
                value: monthChoosen,
                onChanged: (value) {
                  setState(() {
                    monthChoosen = value;
                  });
                },
                items: monthList.map((month) {
                  return DropdownMenuItem(
                    alignment: Alignment.center,
                    value: month,
                    child: Text(
                      month,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
              ),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                color: Colors.black,
                icon: const Icon(
                  Icons.filter_list,
                  size: 35,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).backgroundColor,
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                        const Size.fromHeight(48),
                      ),
                      elevation: MaterialStateProperty.all<double>(0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'See your financial report',
                          style: TextStyle(
                            color: Color(0xFF7F3DFF),
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Color(0xFF7F3DFF)),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    'Today',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // ignore: sdk_version_ui_as_code
                ...widget.appUser.getTransactionList().map(
                  (transaction) {
                    return TransactionCard(transaction: transaction);
                  },
                ).toList()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
