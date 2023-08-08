import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final List<Widget> fields;
  const FormContainer({
    super.key,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 60,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: <Widget>[
            ...fields,
          ],
        ),
      ),
    );
  }
}
