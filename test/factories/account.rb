Factory.define :account do |f|
  f.title 'Giro'
  f.feed 'http://localhost:16717/PADUIC2QNEO2Y2B6IDWJU7AD8TMXW42XYZ/konto.xml'
  f.importer 'Saldomat'
end