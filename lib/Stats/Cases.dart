class Cases {
  final String state;
  final String active;
  final String confirmed;
  final String deaths;
  final String recovered;
  final DateTime dateTime;
  final String deltaConfirmed;
  final String deltaDeaths;
  final String deltaRecovered;
  final String deltaActive;

  Cases(this.state, this.active, this.confirmed, this.deaths, this.recovered, this.dateTime, this.deltaConfirmed, this.deltaDeaths, this.deltaRecovered, this.deltaActive);
}