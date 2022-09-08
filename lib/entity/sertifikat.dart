class Sertifikat {
  String NamaLembaga;
  String NoIzin;

  get getNamaLembaga => this.NamaLembaga;

  set setNamaLembaga(NamaLembaga) => this.NamaLembaga = NamaLembaga;

  get getNoIzin => this.NoIzin;

  set setNoIzin(NoIzin) => this.NoIzin = NoIzin;

  Sertifikat(this.NamaLembaga, this.NoIzin);

  Map<String, dynamic> toJson() => {
        "Lembaga": NamaLembaga,
        "NoIzin": NoIzin,
      };
}
