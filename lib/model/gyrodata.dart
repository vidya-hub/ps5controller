class GyroData {
  double x;
  double y;
  double z;
  GyroData({
    required this.x,
    required this.y,
    required this.z,
  });
  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "z": z,
      };
}
