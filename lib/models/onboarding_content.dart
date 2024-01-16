class Onboard {
  final String image, title, description;

  Onboard(this.image, this.title, this.description);
}

class OnboadingContent {
  List<Onboard> data = [
    Onboard(
      'assets/images/monitoramento_cut.png',
      'Batimentos \nem tempo real',
      'Monitore seu coração com facilidade usando nosso app. Cuide da sua saúde com notificações e compartilhe dados com profissionais. Este é o futuro do monitoramento cardíaco!',
    ),
    Onboard(
      'assets/images/arduino-cut.png',
      "Microcontrolador\nintegrado",
      'Nosso aplicativo é alimentado por um microcontrolador integrado que coleta dados valiosos de um sensor de batimentos cardíacos. Entre em sintonia com sua saúde e bem-estar enquanto exploramos as maravilhas da tecnologia e do monitoramento personalizado de frequência cardíaca.',
    ),
    Onboard(
      'assets/images/database-cut.jpg',
      "Mantenha-se\natualizado",
      'Explore a conveniência de ter seus dados sempre à mão, enquanto nossa solução baseada em nuvem oferece a você a flexibilidade e confiabilidade necessárias para uma experiência de usuário excepcional.',
    ),
    Onboard(
        'assets/images/inteligencia-artificial.png',
        'Inteligência\nArtificial',
        'Com a ajuda da inteligência artificial, nosso aplicativo é capaz de analisar informações de forma rápida e eficiente, identificando padrões, tendências e anomalias que seriam difíceis de detectar de outra forma. Isso significa que você terá acesso a relatórios confiáveis e personalizados que o ajudarão a tomar decisões informadas e estratégicas.')
  ];
}
