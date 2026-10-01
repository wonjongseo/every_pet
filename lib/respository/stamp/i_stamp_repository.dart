import 'package:every_pet/models/stamp_model.dart';

abstract class IStampRepository {
  Future<void> saveStamp(StampModel stamp);

  Future<List<StampModel>> getStamps();

  Future<void> deleteStamp(StampModel stampModel);
}
