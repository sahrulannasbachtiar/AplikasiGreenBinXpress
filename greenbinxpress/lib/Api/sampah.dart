class Sampah {
  final String idSampah;
  final String jenisSampah;
  final String namaSampah;
  final String beratSampah;
  final String jenisAngkutan;
  final String koin;

  Sampah({
    required this.idSampah,
    required this.jenisSampah,
    required this.namaSampah,
    required this.beratSampah,
    required this.jenisAngkutan,
    required this.koin,
  });

  factory Sampah.fromJson(Map<String, dynamic> json) {
    String parsedIdSampah = json['id_sampah'].toString();
    String parsedBeratSampah = json['berat_sampah'].toString();
    String parsedKoin = json['koin'].toString();

    return Sampah(
      idSampah: parsedIdSampah,
      jenisSampah: json['jenis_sampah'],
      namaSampah: json['nama_sampah'],
      beratSampah: parsedBeratSampah,
      jenisAngkutan: json['jenis_angkutan'],
      koin: parsedKoin,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_sampah': idSampah,
      'jenis_sampah': jenisSampah,
      'nama_sampah': namaSampah,
      'berat_sampah': beratSampah,
      'jenis_angkutan': jenisAngkutan,
      'koin': koin,
    };
  }
}
