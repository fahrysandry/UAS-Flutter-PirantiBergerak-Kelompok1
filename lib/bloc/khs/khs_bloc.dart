import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'khs_event.dart';
part 'khs_state.dart';
part 'khs_bloc.freezed.dart';

class KhsBloc extends Bloc<KhsEvent, KhsState> {
  KhsBloc() : super(const _Initial()) {
    // on<KhsEvent>((event, emit) async {
    //   final response = await KhsRemoteDatasource().getKhs();
    //   response.fold(
    //     (l) => emit(_Error(l)),
    //     (r) => emit(_Loaded(r.data)),
    //   );
  }
}
