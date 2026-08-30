import 'package:flutter/material.dart';
import '../../features/auth/data/models/zone_model.dart';

class CustomTextFormFieldZone extends StatelessWidget {
  final ZoneModel? value;
  final String hintText;
  final IconData prefixIcon;
  final List<ZoneModel> items;
  final ValueChanged<ZoneModel?> onChanged;

  final bool enabled;

  const CustomTextFormFieldZone({
    super.key,
    required this.value,
    required this.hintText,
    required this.prefixIcon,
    required this.items,
    required this.onChanged,
    this.enabled = true,
  });

  void showItems(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.6,
          expand: false,
          builder: (context, scrollController) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      hintText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff29209a),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                              controller: scrollController,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        item.name,
                                        textAlign: TextAlign.right,
                                      ),
                                      trailing: value?.id == item.id
                                          ? const Icon(
                                              Icons.check,
                                              color: Color(0xff29209a),
                                              size: 20,
                                            )
                                          : null,
                                      onTap: () {
                                        onChanged(item);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    if (index != items.length - 1)
                                      const Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                  ],
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = enabled ? const Color(0xff29209a) : Colors.grey;
    return GestureDetector(
      onTap: enabled ? () => showItems(context) : null,

      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: InputDecorator(
          decoration: InputDecoration(
            hintText: hintText,

            prefixIcon: Icon(prefixIcon, color: color, size: 22),

            suffixIcon: Icon(Icons.keyboard_arrow_down, size: 22, color: color),
          ),

          child: Text(
            value?.name ?? hintText,
            style: TextStyle(color: enabled ? Colors.black : Colors.grey),
          ),
        ),
      ),
    );
  }
}
