import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  final String currencyType;
  final DateTime date;
  final TimeOfDay time;
  final Function onRefresh;

  const TopContainer({
    Key key,
    this.currencyType,
    this.date,
    this.time,
    this.onRefresh,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currencyType,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  children: [
                    Text(
                      'Last Refresh : ',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      date.toIso8601String().substring(0, 10) + ' ' +
                          time.toString().substring(10, 15),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
            RaisedButton(
              child: Text('Refresh'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: onRefresh,
            ),
          ],
        ),
      ),
    );
  }
}
