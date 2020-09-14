import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {
  List<String> claimReason = [
    'adult',
    'harm',
    'bully',
    'spam',
    'copyright',
    'hate'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: claimReason.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Material(
                child: InkWell(
                  splashColor: AppColors.dodgerBlue,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    child: Center(
                      child: Text(claimReason[index].toUpperCase()),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
