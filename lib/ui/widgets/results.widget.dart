import 'package:flutter/material.dart';
import 'package:randomizer/models/randomizer.model.dart';

class ResultsWidget extends StatelessWidget {
  final RandomizerModel? data;

  const ResultsWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data != null
        ? ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              ListTile(
                leading: const Icon(Icons.looks_one),
                title: Text(data?.teams.first.join(', ') ?? ''),
              ),
              ListTile(
                leading: const Icon(Icons.looks_two),
                title: Text(data?.teams.second.join(', ') ?? ''),
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: Text('${data?.map}, ${data?.mode}'),
                subtitle: data?.weapon != null
                    ? Text(data?.weapon ?? '')
                    : const SizedBox(),
              ),
            ],
          )
        : const SizedBox();
  }
}
