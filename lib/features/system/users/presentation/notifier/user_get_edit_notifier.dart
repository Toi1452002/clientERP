import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/user_edit_model.dart';
import '../../data/repository/iuser_repository.dart';
import '../../data/repository/user_repository.dart';

final userGetEditProvider = AsyncNotifierProvider.autoDispose(UserGetEditNotifier.new,retry: (_,_)=>null);

class UserGetEditNotifier extends AsyncNotifier<UserEditModel?>{

  IUserRepository get _repo => ref.read(userRepositoryProvider);

  @override
  FutureOr<UserEditModel?> build() {
    // TODO: implement build
    return null;
  }


  Future<void> get({int? id}) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      if(id==null) return null;
      return await _repo.getEdit(id);
    });
  }


}