fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

server_scripts {
	"lib/utils.lua",
	"base.lua",
	"queue.lua",
	"server-side/*"
}

client_scripts {
	"lib/utils.lua",
	"client-side/*"
}

files {
	"loading-side/*",
	"web-side/*",
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"lib/Luaseq.lua",
	"lib/Tools.lua",

	'loading-side/index.html',
    'loading-side/style.css',
    'loading-side/video.mp4'
}


loadscreen "loading-side/index.html"
--loadscreen_manual_shutdown "yes"