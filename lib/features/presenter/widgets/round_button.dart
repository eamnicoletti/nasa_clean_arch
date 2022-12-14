import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String label;
  final Function onTap;

  const RoundButton({required this.label, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as Function(),
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Theme.of(context).primaryColorLight,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
