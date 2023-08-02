import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/property_entity.dart';

class DescriptionDropDowBox extends StatefulWidget {
  final String? description;
  final bool isDescription;
  final List<PropertyEntity>? properties;
  const DescriptionDropDowBox({
    super.key,
    required this.isDescription,
    this.description,
    this.properties,
  });

  @override
  State<DescriptionDropDowBox> createState() => _DescriptionDropDowBoxState();
}

class _DescriptionDropDowBoxState extends State<DescriptionDropDowBox> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
      sliver: SliverToBoxAdapter(
        child: InkWell(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: ConstantsColors.grey,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.isDescription ? 'درباره محصول' : 'مشخصات فنی',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        color: ConstantsColors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      isOpen
                          ? Icons.arrow_drop_up_rounded
                          : Icons.arrow_drop_down_rounded,
                      color: ConstantsColors.blue,
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ),
              ),
              isOpen
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: ConstantsColors.grey,
                        ),
                      ),
                      child: widget.isDescription
                          ? Text(
                              widget.description!,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                              ),
                            )
                          : Column(
                              children: <Widget>[
                                for (var property in widget.properties!) ...[
                                  Column(
                                    children: [
                                      Text(property.title),
                                      Text(property.value),
                                    ],
                                  )
                                ]
                              ],
                            ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
