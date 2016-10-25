Rails.env.on(:any) do
  # Configuration default for time zone
  config.time_zone = 'Brasilia'
  config.i18n.available_locales = ['pt-BR', :pt,:en]
  config.i18n.default_locale = 'pt-BR'
  config.i18n.fallbacks = ['pt-BR', :pt, :en]
end
