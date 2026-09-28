import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/system/users/data/model/user_view_model.dart';
import 'package:trina_grid/trina_grid.dart';

class UserTableManager extends AppTableState<UserViewModel> {
  final TrinaGridStateManager _stateManager;

  UserTableManager(this._stateManager);

  @override
  void loadView(List<UserViewModel> users) {
    _stateManager.removeAllRows();
    _stateManager.appendRows(
      users
          .map(
            (e) => TrinaRow(
              cells: {
                'stt': TrinaCell(value: ''),
                'delete': TrinaCell(value: e.id),
                'Username': TrinaCell(value: e.username),
                'HoTen': TrinaCell(value: e.fullName ?? ''),
                'Email': TrinaCell(value: e.email ?? ''),
                'DienThoai': TrinaCell(value: e.phone ?? ''),
              },
            ),
          )
          .toList(),
    );
  }

  void showLoading() => _stateManager.setShowLoading(true);

  void closeLoading() => _stateManager.setShowLoading(false);
}
