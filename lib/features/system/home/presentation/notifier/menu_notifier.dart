import 'dart:async';

import 'package:erp_client_1/features/system/auth/data/model/auth_menu_model.dart';
import 'package:erp_client_1/features/system/auth/data/repository/auth_repository.dart';
import 'package:erp_client_1/features/system/auth/data/repository/iauth_repository.dart';
import 'package:erp_client_1/features/system/auth/presentation/notifier/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

final menuProvider = AsyncNotifierProvider.autoDispose<MenuNotifier, List<TreeNode<String>>>(
  MenuNotifier.new,
  retry: (_, _) => null,
);

final menuDataProvider = StateProvider<List<AuthMenuModel>>((ref) {
  return [];
});

class MenuNotifier extends AsyncNotifier<List<TreeNode<String>>> {
  IAuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  FutureOr<List<TreeNode<String>>> build() async {
    // TODO: implement build
    return await loadMenu();
  }

  Future<List<TreeNode<String>>> loadMenu() async {
    final roleId = ref.read(authNotifierProvider).value?.info?.roleId;
    if (roleId != null) {
      final data = await _repo.getMenu(roleId);
      final treeItems = buildTree(data);

      await Future.delayed(Duration(seconds: 1));

      ref.read(menuDataProvider.notifier).state = data;

      return treeItems;
    }
    return [];
  }
  void setValue(List<TreeNode<String>> value){
    state = AsyncData(value);
  }

  List<TreeNode<String>> buildTree(List<AuthMenuModel> menus) {
    List<TreeNode<String>> buildChildren(int? parentId) {
      final children = menus.where((x) => x.parentId == parentId).toList();
      children.sort((a, b) => (a.sortOrder).compareTo(b.sortOrder));
      return children.map((item) {
        return TreeItem<String>(data: item.name, children: buildChildren(item.id));
      }).toList();
    }

    return buildChildren(null);
  }
}
