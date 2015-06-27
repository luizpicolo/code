Rails.env.on(:any) do |config|
  # Configuration default for time zone
  config.time_zone = 'Brasilia'
  config.i18n.default_locale = :'pt-BR'
end
