fx_version 'cerulean'
game 'gta5'

client_scripts {
  'config.lua',
  'client/*.lua',
}
server_scripts {
  'config.lua',
  'server/*.lua',
}

shared_script {
  '@qb-core/shared/locale.lua',
  'shared/*.lua',
  'config.lua',
  'locales/en.lua',
  'locales/*.lua'
}

lua54 'yes'