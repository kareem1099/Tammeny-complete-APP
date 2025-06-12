import 'package:tamenny_app/core/entites/doctor_entity.dart';

List<DoctorEntity> getDummyDoctors() {
  return [
    DoctorEntity(
      name: "د. محمود فتحي",
      latitude: 26.560074,
      longitude: 31.692398,
      specialty: "أمراض القلب",
      city: "سوهاج",
      imageUrl: "https://via.placeholder.com/150",
      rating: 4.6,
      address: "أمام محطة قطار سوهاج",
      phone: "01241160025",
    ),
    DoctorEntity(
      name: "د. محمد الشيخ",
      latitude: 26.558586,
      longitude: 31.700561,
      specialty: "أمراض الرئة",
      city: "سوهاج",
      imageUrl: "https://via.placeholder.com/150",
      rating: 4.4,
      address: "شارع الهلال - أمام مستشفى الهلال",
      phone: "01259724296",
    ),
    DoctorEntity(
      name: "د. محمد عبد التواب",
      latitude: 26.561557,
      longitude: 31.699874,
      specialty: "أمراض المخ والأعصاب",
      city: "سوهاج",
      imageUrl: "https://via.placeholder.com/150",
      rating: 4.5,
      address: "ميدان الثقافة - أعلى صيدلية العزبي",
      phone: "01227658991",
    ),
    // يمكنك الآن إضافة المزيد من الدكاترة بنفس هذا النمط
  ];
}
