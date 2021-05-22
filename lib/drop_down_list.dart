class Sexo {
  String sexo;

  Sexo(this.sexo);

  static List<Sexo> getSexo() {
    return <Sexo>[
      Sexo('Sexo'),
      Sexo('Masculino'),
      Sexo('Feminino'),
    ];
  }
}

class Doencas {
  String doencas;

  Doencas(this.doencas);

  static List<Doencas> getDoencas() {
    return <Doencas>[
      Doencas('Sexo'),
      Doencas('Masculino'),
      Doencas('Feminino'),
    ];
  }
}

class TipoSang {
  String tipoSang;

  TipoSang(this.tipoSang);

  static List<TipoSang> getTipoSang() {
    return <TipoSang>[
      TipoSang('Tipo Sanguíneo'),
      TipoSang('A+'),
      TipoSang('A-'),
      TipoSang('B+'),
      TipoSang('B-'),
      TipoSang('AB+'),
      TipoSang('AB-'),
      TipoSang('O+'),
      TipoSang('O-'),
    ];
  }
}

class PlanSau {
  String planSau;

  PlanSau(this.planSau);

  static List<PlanSau> getPlanSau() {
    return <PlanSau>[
      PlanSau('Possui Plano de Saúde?'),
      PlanSau('Sim'),
      PlanSau('Não'),
    ];
  }
}

class AlergiaRemed {
  String alergRem;

  AlergiaRemed(this.alergRem);

  static List<AlergiaRemed> getAlergiaRemed() {
    return <AlergiaRemed>[
      AlergiaRemed('Possui Alergia a Algum Remédio?'),
      AlergiaRemed('Sim'),
      AlergiaRemed('Não'),
    ];
  }
}

class RemedCont {
  String remedCont;

  RemedCont(this.remedCont);

  static List<RemedCont> getRemedCont() {
    return <RemedCont>[
      RemedCont('Remédio de Uso Contínuo'),
      RemedCont('Sim'),
      RemedCont('Não'),
    ];
  }
}

class DoencaPreex {
  String doencapreex;

  DoencaPreex(this.doencapreex);

  static List<DoencaPreex> getDoencaPreex() {
    return <DoencaPreex>[
      DoencaPreex('Possui Doenças Preexistentes?'),
      DoencaPreex('Sim'),
      DoencaPreex('Não'),
    ];
  }
}

class Febre {
  String febre;

  Febre(this.febre);

  static List<Febre> getFebre() {
    return <Febre>[
      Febre('Tem Febre?'),
      Febre('Sim'),
      Febre('Não'),
    ];
  }
}
