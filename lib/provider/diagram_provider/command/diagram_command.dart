import 'package:fa_simulator/provider/diagram_provider/diagram_detail.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/diagram_type.dart';
import 'package:flutter/material.dart';

@immutable
class DiagramCommand {
  const DiagramCommand();
}

class AddItemCommand extends DiagramCommand {
  final DiagramType item;

  const AddItemCommand({
    required this.item,
  });
}

class UpdateItemCommand extends DiagramCommand {
  final ItemDetail detail;

  const UpdateItemCommand({
    required this.detail,
  });
}

class DeleteItemCommand extends DiagramCommand {
  final String id;

  const DeleteItemCommand({
    required this.id,
  });
}

class UpdateAlphabetCommand extends DiagramCommand {
  final Iterable<String> alphabet;

  const UpdateAlphabetCommand({
    required this.alphabet,
  });
}
