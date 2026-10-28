import 'package:collection/collection.dart';
import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/widget.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/model/taikhoan_lookup_model.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/ui/state/taikhoan_lookup_state.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/ui/widget/taikhoan_kho_combobox.dart';
import 'package:erp_client_1/features/kho/presentation/notifier/nhapxuatton_notifier.dart';
import 'package:erp_client_1/features/kho/presentation/ui/state/nhapxuatton_table_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../core/utils/num_helper.dart';

class NhapXuatTonScreen extends ConsumerStatefulWidget {
  const NhapXuatTonScreen({super.key});

  @override
  ConsumerState createState() => _NhapXuatTonScreenState();
}

class _NhapXuatTonScreenState extends ConsumerState<NhapXuatTonScreen> {
  late NhapXuatTonTableManager _manager;

  DateTime tNgay = DateTime.now().copyWith(day: 1);
  DateTime dNgay = DateTime.now();
  String? maTK;
  final txtTenTK = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nhapXuatTonProvider);
    return Scaffold(
      backgroundColor: AppColor.background,
      footers: [
        AppFooter()
      ],
      headers: [
        // AppHeader(title: "Nhập xuất tồn kho"),
        AppContainerBorder(child: Column(children: [


          AppBar(
            leading: [
              Text("Tài khoản").medium,
              SizedBox(width: 100,child: TaiKhoanKhoCombobox(selected: maTK,onChanged: (val){
                ref.read(nhapXuatTonProvider.notifier).get(tNgay, dNgay, val);

                setState(() {
                  maTK = val;
                });
                if(val!=null){
                  final x = ref.read(taiKhoanLookupProvider(LoaiTaiKhoan.khoND)).value;
                  final t = x?.firstWhereOrNull((e)=>e.maTK == val);
                  if(t!=null) txtTenTK.text = t.tenTK;
                }else{
                  txtTenTK.clear();
                }
              },),),
              SizedBox(width: 250,child: AppTextField(readOnly: true,controller: txtTenTK,),)
            ],
          ),
          AppBar(
            leading: [
              AppTngayDngay(
                onSubmit: (t,d){
                  if(maTK!=null){
                    ref.read(nhapXuatTonProvider.notifier).get(t, d, maTK!);
                  }
                  tNgay = t;
                  dNgay = d;
                },
              ),
            ],
            trailing: [
              AppPrintButton(),
            ],
          ),
        ],))
      ],
      child: state.when(
        data: (val) {
          return Scaffold(
            child: AppTable(
              onLoaded: (e){
                _manager = NhapXuatTonTableManager(e.stateManager);
                _manager.loadView(val);
              },
              columnGroups: [
                TrinaColumnGroup(
                  title: 'TỒN ĐẦU KỲ',
                  fields: ['SoTon', 'TienDauKy'],
                  backgroundColor: Colors.green.shade200,
                ),
                TrinaColumnGroup(title: 'NHẬP TRONG KỲ', fields: ['SN', 'TN'], backgroundColor: Colors.orange.shade200),
                TrinaColumnGroup(title: 'XUẤT TRONG KỲ', fields: ['SX', 'GX', 'TX'], backgroundColor: Colors.blue.shade200),
                TrinaColumnGroup(title: 'TỒN CUỐI KỲ', fields: ['SC', 'TC'], backgroundColor: Colors.orange.shade200),
              ],
              columns: [
                AppTableColumn(
                  title: ['#', 'stt'],
                  width: 35,
                  readOnly: true,
                  showFilter: false,
                  renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                ),
                AppTableColumn(
                  title: ['Tên hàng', 'TenHH'],
                  width: 250,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['ĐVT', 'DVT'],
                  width: 50,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                ),
                _buildColumn(['SL', 'SD'], 70, Colors.green.shade200),
                _buildColumn(['T.Tiền', 'TD'], 100, Colors.green.shade200),
                _buildColumn(['SL', 'SN'], 70, Colors.orange.shade200),
                _buildColumn(['T.Tiền', 'TN'], 100, Colors.orange.shade200),
                _buildColumn(['SL', 'SX'], 70, Colors.blue.shade200),
                _buildColumn(['Giá xuất', 'GX'], 100, Colors.blue.shade200),
                _buildColumn(['T.Tiền', 'TX'], 100, Colors.blue.shade200),
                _buildColumn(['SL', 'SC'], 70, Colors.orange.shade200),
                _buildColumn(['T.Tiền', 'TC'], 100, Colors.orange.shade200),
              ],
            ),
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }

  _buildText(dynamic text, Color color) {
    return Container(
      color: color.withValues(alpha: .3),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(NumHelper.numFormat(text), style: TextStyle(fontSize: 13)).medium,
    );
  }

  _buildColumn(List<String> title, double width, Color color) {
    return AppTableColumn(
      title: title,
      width: width,
      columnType: ColumnType.num,
      showFooter: true,
      padding: 0,
      headerColor: color,
      renderer: (re) {
        return _buildText(re.cell.value.toString(), color);
      },
    );
  }
}
