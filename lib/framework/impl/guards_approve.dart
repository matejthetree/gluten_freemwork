import 'package:gluten_freemwork/framework/api/i_guard.dart';
import 'package:organic_injection/organic_injection.dart';

bool guardsApprove(List<IGuard> guards, [IInjector injector]) {
  guards.forEach((IGuard guard) {
    if (guard.approve() == false) return false;
  });
  return true;
}
