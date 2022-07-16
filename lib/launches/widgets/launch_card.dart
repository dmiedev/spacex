import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class LaunchCard extends StatelessWidget {
  const LaunchCard({
    super.key,
    this.name,
    this.number,
    this.date,
    this.patchUrl,
    this.onTap,
  });

  final String? name;
  final int? number;
  final String? date;
  final String? patchUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Border.all(color: Colors.white, width: 0.5),
      color: Colors.black,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (number != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          '#$number',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    if (date != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: AutoSizeText(
                          '$date',
                          maxLines: name!.split(' ').length > 1 ? 1 : 2,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    if (name != null)
                      AutoSizeText(
                        '$name',
                        maxLines: name!.split(' ').length > 1 ? 2 : 1,
                        maxFontSize: 30,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
              if (patchUrl != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image(
                    height: 100,
                    image: NetworkImage(patchUrl!),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
