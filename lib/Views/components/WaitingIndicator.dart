import "package:flutter/material.dart";

class WaitingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
          )
        ],
      ),
    );
  }
}
