# MB-CHICKEN
A simple chicken job that support QBCore Framework (with processing step and selling location). This script will bring a new job to your roleplay server

# Features
[PREVIEW](https://youtu.be/tqXSLSRVTow)

# Support
Join our discord today for latest update and faster support:

[![Discord](https://dcbadge.vercel.app/api/server/MkXfmb2M2V)](https://discord.gg/MkXfmb2M2V)

# Setup
1. Download the file from [Github](https://github.com/Edvo1901/mb-chicken)
2. Unzipped the file
3. Drag and drop [mb-chicken] to your server folder
4. Add this line to your ```qb-core/shared/item.lua```
```
["alive_chicken"] 		 			 	 = {["name"] = "alive_chicken", 							["label"] = "Alive chicken", 					    ["weight"] = 2000, 		["type"] = "item", 		["image"] = "alive_chicken.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Alive Chicken"},
["slaughtered_chicken"] 		 		     = {["name"] = "slaughtered_chicken", 						["label"] = "Slaughtered chicken", 					    ["weight"] = 2000, 		["type"] = "item", 		["image"] = "slaughteredchicken.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Slaughtered Chicken"},
["packagedchicken"] 		 			 = {["name"] = "packagedchicken", 							["label"] = "Packaged chicken", 					    ["weight"] = 2000, 		["type"] = "item", 		["image"] = "packaged_chicken.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Packaged Chicken"},
```
5. Copy all the file in ```images``` folder and paste it to ```qb-inventory/html/images```
4. Go to your server.cfg and add this
```ensure mb-chicken```

# Bugs/Optimise report
If you find any bugs or have any suggestion, feel free to open an "Issues" on Github or simply join my Discord for support

# Other script
Check out my other script at: https://guess-project.tebex.io/


