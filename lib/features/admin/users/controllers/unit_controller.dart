import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:command_care/features/admin/users/controllers/unit_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../auth/data/User.dart';


final unitRepositoryProvider = Provider<UnitRepository>(
      (ref) => UnitRepository(FirebaseFirestore.instance),
);

final unitsProvider = FutureProvider<List<UserData>>((ref) async {
  final repository = ref.watch(unitRepositoryProvider);
  return await repository.fetchUnits();
});

