resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/ui.html'
lua54 'yes'
files {
	'html/ui.html',
	'html/play.ttf',
	'html/playb.ttf',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/pl.lua',
	'locales/en.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/pl.lua',
	'locales/en.lua',
	'config.lua',
	'client.lua'
}

dependencies {
  'es_extended'
}

exports {
	'ImpoundVehicle',
	'OpenSellCarMenu'
}
