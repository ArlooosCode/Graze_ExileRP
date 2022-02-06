local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
ESX = nil
local PlayerData = nil
local CurrentZone = nil
local GUI                     = {}
GUI.Time                      = 0
local MyVehicles 			  = {}
local IsImpounding 			  = false

CreateThread(function()
	while ESX == nil do
		TriggerEvent('hypex:getTwojStarySharedTwojaStaraObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx:setHiddenJob')
AddEventHandler('esx:setHiddenJob', function(hiddenjob)
	PlayerData.hiddenjob = hiddenjob
end)

CreateThread(function()
	Citizen.InvokeNative(0x10D373323E5B9C0D)
end)

function SpawnTowedVehicle(plate)
	TriggerServerEvent('flux_garages:updateState', plate)
end

-- Close Gui and disable NUI
function closeGui()
	SetNuiFocus(false)
	SendNUIMessage({openGarage = false})
end

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false)
	SendNUIMessage({openList = false})
	cb('ok')
end)

RegisterNetEvent('exile_garages:setBusy')
AddEventHandler('exile_garages:setBusy', function(plate)
	MyVehicles[plate] = true
end)

-- NUI Callback Methods
RegisterNUICallback('pull', function(data, cb)
	if Citizen.InvokeNative(0xD422FCC5F239A915) then
		return
	end
	SetNuiFocus(false)
	SendNUIMessage({openList = false})
	cb('ok')
	Citizen.InvokeNative(0xABA17D7CE615ADBF, "FMMC_PLYLOAD")
	Citizen.InvokeNative(0xBD12F8228410D9B4, 4)
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	if data.action == 'garage' then
		local playerPed  = Citizen.InvokeNative(0x43A66C31C68491C0, -1)
		ESX.TriggerServerCallback('flux_garages:checkIfVehicleIsOwned', function (owned)
			local coords = vector3(CurrentZone.x, CurrentZone.y, CurrentZone.z)
			if owned then
				local heading = nil
				if CurrentZone.h ~= nil then
					heading = CurrentZone.h
				else
					heading = GetEntityHeading(playerPed)
				end
				ESX.Game.SpawnVehicle(owned.model, coords, heading, function(veh)
					TaskWarpPedIntoVehicle(playerPed, veh, -1)
					ESX.Game.SetVehicleProperties(veh, owned)
					SetVehicleEngineHealth(veh, owned.engineHealth)
					SetVehicleBodyHealth(veh, owned.bodyHealth)
					TriggerServerEvent('flux_garages:pullCar', owned)
					SetEntityAsMissionEntity(veh, true, true)
					SetVehicleHasBeenOwnedByPlayer(veh, true)
					local localVehPlate = string.lower(GetVehicleNumberPlateText(veh))
					TriggerEvent('ls:dodajklucze2', localVehPlate)
					
					Citizen.InvokeNative(0x10D373323E5B9C0D)
				end)
			else
				ESX.ShowNotification('~r~Nie udało się wyciągnąć pojazdu, spróbuj jeszcze raz')
				Citizen.InvokeNative(0x10D373323E5B9C0D)
			end
		end, data.plate)	
	elseif data.action == 'impound' then
		if IsImpounding == false then
			IsImpounding = true
			ESX.TriggerServerCallback('flux_garages:checkMoney', function(hasMoney)
				if hasMoney == 1 then
					ESX.ShowNotification("~y~Trwa poszukiwanie pojazdu...")
					TriggerServerEvent('exile_garages:findVehicle', data.plate)
					
					exports['ExileRP']:DrawProcent(100, function()
						if MyVehicles[data.plate] == true then
							IsImpounding = false
							ESX.ShowNotification("Nie udało się ~r~odholować pojazdu~w~ o numerze rejestracyjnym ~y~" .. data.plate)
							MyVehicles[data.plate] = nil
						else
							IsImpounding = false
							SpawnTowedVehicle(data.plate)
							ESX.ShowNotification("Pojazd o numerze rejestracyjnym ~y~" .. data.plate .. "~w~ został ~g~odholowany")
						end
					end)
				else
					IsImpounding = false
					local needed = 0
					if hasMoney == 2 then
						needed = 2500
					elseif hasMoney == 3 then
						needed = 5000
					end
					ESX.ShowNotification("Potrzebujesz ~g~" .. needed .. "$~w~ aby ~y~odholować~w~ pojazd")
				end
			end)
		else
			ESX.ShowNotification('~b~Poczekaj aż odholujesz poprzedni pojazd')
		end
		Citizen.InvokeNative(0x10D373323E5B9C0D)
	elseif data.action == 'impoundpd' then
		local playerPed  = Citizen.InvokeNative(0x43A66C31C68491C0, -1)
		ESX.TriggerServerCallback('flux_garages:checkVehProps', function(veh)
			local coords = GetEntityCoords(PlayerPedId())
			ESX.ShowNotification("~b~Trwa poszukiwanie pojazdu...")
			Citizen.Wait(math.random(500, 4000))
			ESX.Game.SpawnVehicle(veh.model, coords, GetEntityHeading(PlayerPedId()), function(vehicle)
				TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
				ESX.Game.SetVehicleProperties(vehicle, veh)
				SetVehicleEngineHealth(vehicle, veh.engineHealth)
				SetVehicleBodyHealth(vehicle, veh.bodyHealth)
				TriggerServerEvent("flux_garages:removeCarFromPoliceParking", data.plate)
				SetEntityAsMissionEntity(vehicle, true, true)
				SetVehicleHasBeenOwnedByPlayer(vehicle, true)
				Citizen.InvokeNative(0x10D373323E5B9C0D)
			end)
		end, data.plate)
	end
	
	
end)

RegisterNetEvent('exile_garages:findVehicle')
AddEventHandler('exile_garages:findVehicle', function(plate, owner)
	if ESX then
        local vehicles = ESX.Game.GetVehicles()
        for _, vehicle in ipairs(vehicles) do
            local vehiclePlate = GetVehicleNumberPlateText(vehicle, true)
            if type(vehiclePlate) == 'string' then
                vehiclePlate = vehiclePlate:gsub("%s$", "")
				if vehiclePlate == plate then
					local attempt = 0
					while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
						Citizen.Wait(100)
						NetworkRequestControlOfEntity(vehicle)
						attempt = attempt + 1
					end
					if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
						if GetVehicleNumberOfPassengers(vehicle) > 0 or not IsVehicleSeatFree(vehicle, -1) then
							TriggerServerEvent('exile_garages:isBusy', plate, owner)
						else
							ESX.Game.DeleteVehicle(vehicle)
						end
					end
                    break
                end
            end
        end
    end
end)

CreateThread(function()
	Citizen.Wait(1000)
	for i=1, #Config.Garage, 1 do
		if not Config.Garage[i].role and Config.Garage[i].blip then
			local blip = AddBlipForCoord(vector3(Config.Garage[i].x, Config.Garage[i].y, Config.Garage[i].z))

			SetBlipSprite (blip, Config.Sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.65)
			SetBlipColour (blip, Config.Colour)	
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Garaż publiczny')
			EndTextCommandSetBlipName(blip)
		end
	end	
	
	for i=1, #Config.Zones, 1 do
		if Config.Zones[i].blip then
			local blip = AddBlipForCoord(vector3(Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z))
			SetBlipSprite (blip, Config.Zones[i].sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.8)
			SetBlipColour (blip, Config.Zones[i].color)	
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Zones[i].blip)
			EndTextCommandSetBlipName(blip)
		end
	end

	for i=1, #Config.Harbors, 1 do
		if Config.Harbors[i].blip then
			local blip = AddBlipForCoord(vector3(Config.Harbors[i].x, Config.Harbors[i].y, Config.Harbors[i].z))

			SetBlipSprite (blip, Config.Sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.65)
			SetBlipColour (blip, Config.Colour2)	
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Port publiczny')
			EndTextCommandSetBlipName(blip)
		end
	end

	for i=1, #Config.Hangar, 1 do
		if Config.Hangar[i].blip then
			local blip = AddBlipForCoord(vector3(Config.Hangar[i].x, Config.Hangar[i].y, Config.Hangar[i].z))

			SetBlipSprite (blip, Config.Sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.65)
			SetBlipColour (blip, Config.Colour3)	
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Hangar publiczny')
			EndTextCommandSetBlipName(blip)
		end
	end
end)

RegisterNetEvent('flux_garages:removeGarage')
AddEventHandler('flux_garages:removeGarage', function(x,y,z)
	for i=1, #Config.Garage, 1 do
		if Config.Garage[i].x == x and Config.Garage[i].y == y and Config.Garage[i].z == z then
			table.remove(Config.Garage, i)
			break
		end
	end	
end)

RegisterNetEvent('flux_garages:addNewGarage')
AddEventHandler('flux_garages:addNewGarage', function(x,y,z)
	table.insert(Config.Garage, {x = x, y = y, z = z, h = 0.0, blip = false})
end)

CreateThread(function()
	Citizen.Wait(2000)
	while true do
		Citizen.Wait(3)
		local garage = FindClosestGarage()

		if (garage ~= nil) then
			if not garage.role then
				if garage.vdist < 3.5 then
					ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby skorzystać z garażu')

					if IsControlJustReleased(0, 51) then
						if IsPedSittingInAnyVehicle(Citizen.InvokeNative(0x43A66C31C68491C0, -1)) then
							LeftCar()
							Citizen.Wait(500)
						else		
							OpenGarage(garage)
							Citizen.Wait(500)
						end
					end
				end

				ESX.DrawBigMarker(vec3(garage.x, garage.y, garage.z-0.95))
			elseif garage.role then
				if PlayerData.job.name == garage.role or PlayerData.hiddenjob.name == garage.role or string.sub(PlayerData.job.name, 4) == garage.role then
					if garage.vdist < 3.5 then
						ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby skorzystać z garażu')

						if IsControlJustReleased(0, 51) then
							if IsPedSittingInAnyVehicle(Citizen.InvokeNative(0x43A66C31C68491C0, -1)) then
								LeftCar()
								Citizen.Wait(500)
							else
								OpenGarage(garage)
								Citizen.Wait(500)
							end
						end
					end

					ESX.DrawBigMarker(vec3(garage.x, garage.y, garage.z-0.95))
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

CreateThread(function()
	Citizen.Wait(2000)
	while true do
		Citizen.Wait(3)
		local garage = FindClosestHarbor()

		if (garage ~= nil) then
			if garage.vdist < 3.5 then
				ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby skorzystać z portu')

				if IsControlJustReleased(0, 51) then
					if IsPedSittingInAnyVehicle(Citizen.InvokeNative(0x43A66C31C68491C0, -1)) then
						LeftCar()
						Citizen.Wait(500)
					else
						OpenHarbor(garage)
						Citizen.Wait(500)
					end
				end
			end

			ESX.DrawBigMarker(vec3(garage.x, garage.y, garage.z-0.95))
		else
			Citizen.Wait(500)
		end
	end
end)

CreateThread(function()
	Citizen.Wait(2000)
	while true do
		Citizen.Wait(3)
		local garage = FindClosestHangar()

		if (garage ~= nil) then
			if garage.vdist < 3.5 then
				ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby skorzystać z hangaru')

				if IsControlJustReleased(0, 51) then
					if IsPedSittingInAnyVehicle(Citizen.InvokeNative(0x43A66C31C68491C0, -1)) then
						LeftCar()
						Citizen.Wait(500)
					else
						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
							if hasLicense then
								OpenHangar(garage)
							else
								ESX.ShowNotification('~r~Potrzebujesz odpowiedniej licencji, aby wyciągać pojazdy powietrzne')
							end
						end, GetPlayerServerId(PlayerId()), 'air')
						Citizen.Wait(500)
					end
				end
			end

			ESX.DrawBigMarker(vec3(garage.x, garage.y, garage.z-0.95))
		else
			Citizen.Wait(500)
		end
	end
end)

CreateThread(function()
	while true do
		Citizen.Wait(3)
		local zone = FindClosestZone()

		if (zone ~= nil) then
			if zone.marker == 1 then
				if zone.vdist < 1.5 then
					ESX.ShowHelpNotification(zone.label)
					if IsControlJustReleased(0, 51) then						
						if not IsPedSittingInAnyVehicle(Citizen.InvokeNative(0x43A66C31C68491C0, -1)) then
							TriggerFunction(zone.name)
						end
					end
				end
				ESX.DrawMarker(vec3(zone.x, zone.y, zone.z))
			else
				if (zone.name == 'impoundpd' and PlayerData.job ~= nil and PlayerData.job.name == 'police') or zone.name ~= 'impoundpd' then
					if zone.vdist < 3.5 then
						ESX.ShowHelpNotification(zone.label)
						if IsControlJustReleased(0, 51) then
							if zone.name == 'destroy' then
								if IsPedSittingInAnyVehicle(Citizen.InvokeNative(0x43A66C31C68491C0, -1)) then
									TriggerFunction(zone.name)
								end
							else
								if not IsPedSittingInAnyVehicle(Citizen.InvokeNative(0x43A66C31C68491C0, -1)) then
									TriggerFunction(zone.name)
								end
							end
						end
					end
					ESX.DrawBigMarker(vec3(zone.x, zone.y, zone.z-0.95))
				end
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

TriggerFunction = function(zone)
	if zone == 'impound' then
		OpenImpoundMenu()
	elseif zone == 'impoundpd' then
		OpenPoliceImpoundMenu()
	elseif zone == 'destroy' then
		StartDestroying()
	elseif zone == 'contract' then
		OpenSellCarMenu()
	elseif zone == 'coowner' then
		OpenCoOwnerMenu()
	end
end

CreateThread(function()
	while true do
		UpdatePedCoords()
		Citizen.Wait(250)
	end
end)

local playerPedCoords = vector3(0.0, 0.0, 0.0)

UpdatePedCoords = function()
	playerPedCoords = GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, -1))
end

FindClosestGarage = function()
	for i=1, #Config.Garage, 1 do
		local distRayCast = GetDistanceBetweenCoords(playerPedCoords, Config.Garage[i].x, Config.Garage[i].y, Config.Garage[i].z, true)

		if distRayCast < 10.0 then
			Config.Garage[i].vdist = distRayCast
			return Config.Garage[i]
		end		
	end
end

FindClosestHarbor = function()
	for i=1, #Config.Harbors, 1 do
		local distRayCast = GetDistanceBetweenCoords(playerPedCoords, Config.Harbors[i].x, Config.Harbors[i].y, Config.Harbors[i].z, true)

		if distRayCast < 10.0 then
			Config.Harbors[i].vdist = distRayCast
			return Config.Harbors[i]
		end		
	end
end

FindClosestHangar = function()
	for i=1, #Config.Hangar, 1 do
		local distRayCast = GetDistanceBetweenCoords(playerPedCoords, Config.Hangar[i].x, Config.Hangar[i].y, Config.Hangar[i].z, true)

		if distRayCast < 10.0 then
			Config.Hangar[i].vdist = distRayCast
			return Config.Hangar[i]
		end		
	end
end

FindClosestZone = function()
	for i=1, #Config.Zones, 1 do
		local distRayCast = GetDistanceBetweenCoords(playerPedCoords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true)

		if distRayCast < 10.0 then
			Config.Zones[i].vdist = distRayCast
			return Config.Zones[i]
		end		
	end
end

StartDestroying = function()
	local veh = GetVehiclePedIsUsing(Citizen.InvokeNative(0x43A66C31C68491C0, -1))
	local vehProperties = ESX.Game.GetVehicleProperties(veh)
	if exports['esx_scoreboard']:BierFrakcje('police') >= 3 then
		if GetPedInVehicleSeat(veh, -1) == Citizen.InvokeNative(0x43A66C31C68491C0, -1) then
			local found = false
			for i = 1, 5, 1 do
				if GetPedInVehicleSeat(veh, i) ~= 0 then
					found = true
					break
				end
			end
			if not found then
				FreezeEntityPosition(veh, true)
				local canceled = false
				local waitTill = math.random(5000, 10000)
				local coords = GetEntityCoords(PlayerPedId())
				local str = "^3Uwaga, podejrzany obywatel w okolicach złomowiska"
				TriggerServerEvent('destroyingInProgress', {x = coords.x, y = coords.y, z = coords.y}, str)
				while waitTill > 0 do
					Citizen.Wait(3)
					DisableControlAction(0,75,true)
					ESX.ShowHelpNotification('Naciśnij ~INPUT_VEH_DUCK~, aby przerwać złomowanie')
					if IsControlJustReleased(0, 73) then
						canceled = true
						break
					end
					waitTill = waitTill - 1
				end
				if canceled == false then
					vehProperties.engineHealth = 0.0
					vehProperties.bodyHealth = 0.0
					TriggerServerEvent('flux_garages:destroyCar', vehProperties)
					while DoesEntityExist(veh) do
						Citizen.Wait(10)
						DeleteEntity(veh)
					end
					FreezeEntityPosition(veh, false)
				elseif canceled == true then
					FreezeEntityPosition(veh, false)
					ESX.ShowNotification("~b~Złomowanie przerwane")
				end
			else
				ESX.ShowNotification("~r~Ktoś jest w pojeździe")
			end
		else
			ESX.ShowNotification('~r~Musisz być kierowcą!')
		end
	else
		ESX.ShowNotification("~b~Musi być minimum 3 funkcjonariuszy na służbie, aby zezłomować pojazd")
	end
end

function LeftCar()
	local veh = GetVehiclePedIsUsing(Citizen.InvokeNative(0x43A66C31C68491C0, -1))
	local vehProperties = ESX.Game.GetVehicleProperties(veh)
	if GetPedInVehicleSeat(veh, -1) == Citizen.InvokeNative(0x43A66C31C68491C0, -1) then
		local found = false
		for i = 1, 5, 1 do
			if GetPedInVehicleSeat(veh, i) ~= 0 then
				found = true
				break
			end
		end
		if not found then
			if GetVehicleEngineHealth(veh) >= 650.0 then
				if GetVehicleBodyHealth(veh) >= 850.0 then
					ESX.TriggerServerCallback('flux_garages:checkCar', function(kalbak)
						if kalbak == 1 or kalbak == 2 then
							TriggerServerEvent('flux_garages:leftCar', vehProperties)
				
							while DoesEntityExist(veh) do
								Citizen.Wait(10)
								DeleteEntity(veh)
							end
						elseif kalbak == false then
							ESX.ShowNotification('~r~Pojazd nie należy do Ciebie!')
						end
					end, vehProperties)
				else
					ESX.ShowNotification('~r~Karoseria tego pojazdu jest za bardzo uszkodzona')
				end
			else
				if GetVehicleBodyHealth(veh) >= 850.0 then
					ESX.ShowNotification('~r~Silnik tego pojazdu jest za bardzo uszkodzony')
				else
					ESX.ShowNotification('~r~Silnik oraz karoseria tego pojazdu są za bardzo uszkodzone')
				end
			end
		else
			ESX.ShowNotification("~r~Ktoś jest w pojeździe")
		end
	else
		ESX.ShowNotification('~r~Musisz być kierowcą!')
	end
end


function OpenGarage(zone)	
	SendNUIMessage({
		clear = true
	})
	ESX.TriggerServerCallback('flux_garages:getVehicles', function(vehicles)
		for i=1, #vehicles, 1 do
			local name = GetDisplayNameFromVehicleModel(vehicles[i].model)
			TriggerEvent('esx_vehicleshop:getVehicles', function(base)
				local found = false
				
				for _, vehicle in ipairs(base) do
					if GetHashKey(vehicle.model) == vehicles[i].model then
						name = vehicle.name
						found = true
						break
					end
				end
			  
				if not found then
					local label = GetLabelText(name)
					if label ~= "NULL" then
						name = label
					end
				end

				SendNUIMessage({
					add = true,
					plate = vehicles[i].plate,
					name = name,
					engine = vehicles[i].engineHealth and math.floor((vehicles[i].engineHealth - 500) / 5) or '??',
					body = vehicles[i].bodyHealth and math.floor(vehicles[i].bodyHealth / 10) or '??'
				})							  
			end)
		end
		
		SetNuiFocus(true, true)
		SendNUIMessage({openList = true, listType = 'garage'})
		CurrentZone = zone
	end)
end

function OpenHarbor(zone)
	SendNUIMessage({
		clear = true
	})
	ESX.TriggerServerCallback('flux_garages:getBoats', function(vehicles)
		for i=1, #vehicles, 1 do
			local name = GetDisplayNameFromVehicleModel(vehicles[i].model)
			TriggerEvent('esx_vehicleshop:getVehicles', function(base)
				local found = false
				
				for _, vehicle in ipairs(base) do
					if GetHashKey(vehicle.model) == vehicles[i].model then
						name = vehicle.name
						found = true
						break
					end
				end
			  
				if not found then
					local label = GetLabelText(name)
					if label ~= "NULL" then
						name = label
					end
				end

				SendNUIMessage({
					add = true,
					plate = vehicles[i].plate,
					name = name,
					engine = vehicles[i].engineHealth and math.floor((vehicles[i].engineHealth - 500) / 5) or '??',
					body = vehicles[i].bodyHealth and math.floor(vehicles[i].bodyHealth / 10) or '??'
				})							  
			end)
		end
		
		SetNuiFocus(true, true)
		SendNUIMessage({openList = true, listType = 'garage'})
		CurrentZone = zone
	end)
end

function OpenHangar(zone)	
	SendNUIMessage({
		clear = true
	})
	ESX.TriggerServerCallback('flux_garages:getPlanes', function(vehicles)
		for i=1, #vehicles, 1 do
			local name = GetDisplayNameFromVehicleModel(vehicles[i].model)
			TriggerEvent('esx_vehicleshop:getVehicles', function(base)
				local found = false
				
				for _, vehicle in ipairs(base) do
					if GetHashKey(vehicle.model) == vehicles[i].model then
						name = vehicle.name
						found = true
						break
					end
				end
			  
				if not found then
					local label = GetLabelText(name)
					if label ~= "NULL" then
						name = label
					end
				end

				SendNUIMessage({
					add = true,
					plate = vehicles[i].plate,
					name = name,
					engine = vehicles[i].engineHealth and math.floor((vehicles[i].engineHealth - 500) / 5) or '??',
					body = vehicles[i].bodyHealth and math.floor(vehicles[i].bodyHealth / 10) or '??'
				})							  
			end)
		end
		
		SetNuiFocus(true, true)
		SendNUIMessage({openList = true, listType = 'garage'})
		CurrentZone = zone
	end)
end

function round(n)
    if not n then return 0; end
    return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

-------------------------------------------------------------------------niniger
function OpenImpoundMenu()
	SendNUIMessage({
		clear = true
	})
	ESX.TriggerServerCallback('flux_garages:getVehiclesToTow', function(vehicles)
		for i=1, #vehicles, 1 do
			local name = GetDisplayNameFromVehicleModel(vehicles[i].model)
			TriggerEvent('esx_vehicleshop:getVehicles', function(base)
				local found = false

				for _, vehicle in ipairs(base) do
					if GetHashKey(vehicle.model) == vehicles[i].model then
						name = vehicle.name
						found = true
						break
					end
				end
			  
				if not found then
					local label = GetLabelText(name)
					if label ~= "NULL" then
						name = label
					end
				end

				SendNUIMessage({
					add = true,
					plate = vehicles[i].plate,
					name = name,
					engine = vehicles[i].engineHealth and math.floor((vehicles[i].engineHealth - 500) / 5) or '??',
					body = vehicles[i].bodyHealth and math.floor(vehicles[i].bodyHealth / 10) or '??'
				})							  
			end)
		end
	end)
	SetNuiFocus(true, true)
	SendNUIMessage({openList = true, listType = 'impound'})
end

------------------------------------------------------------------------
function OpenCoOwnerMenu()
	ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'subowner_player',
		{
			title = "Tablica rejestracyjna",
			align = 'center'
		},
		function(data, menu)
			local plate = string.upper(tostring(data.value))
			ESX.TriggerServerCallback('flux_garages:checkIfPlayerIsOwner', function(isOwner)
				if isOwner then
					menu.close()
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'subowner_menu',
						{
							title = "Zarządzanie pojazdem " .. plate,
							align = 'center',
							elements	= {
								{label = "Nadaj współwłaściciela", value = 'give_sub'},
								{label = "Usuń współwłaścicieli", value = 'manage_sub'},
								{label = "Zmień rejestrację", value = 'change_rej'},
							}
						},
						function(data2, menu2)
							if data2.current.value == 'give_sub' then
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								if closestPlayer ~= -1 and closestDistance <= 3.0 then
									menu2.close()
									TriggerServerEvent('flux_garages:setSubowner', plate, GetPlayerServerId(closestPlayer))
								else
									ESX.ShowNotification("~r~Brak osób w pobliżu")
								end
							elseif data2.current.value == 'manage_sub' then
								local elements = {}
								ESX.TriggerServerCallback('flux_garages:getSubOwners', function(dane, val)
									if dane ~= nil then
									table.insert(elements, {label = "[Pierwszy] "..dane.firstname.." "..dane.lastname, value = val.co_owner, h = 'first'})
									end
									ESX.TriggerServerCallback('flux_garages:getSubOwners2', function(danes, vals)
										if danes ~= nil then
										table.insert(elements, {label = "[Drugi] "..danes.firstname.." "..danes.lastname, value = vals.co_owner2, h = 'second'})
										end
									ESX.UI.Menu.Open(
										'default', GetCurrentResourceName(), 'yesorno',
										{
											title = "Wybierz współwłaściciela",
											align = 'center',
											elements = elements
										},
										function(data3, menu3)
											if data3.current.h == 'first' then
												TriggerServerEvent('flux_garages:deleteSubowner', plate, data3.current.value)
											end
											if data3.current.h == 'second' then
												TriggerServerEvent('flux_garages:deleteSubowner2', plate, data3.current.value)
											end
											menu3.close()
										end,
										function(data3, menu3)
											menu3.close()
										end)
									end, plate)
								end, plate)
								
							elseif data2.current.value == 'change_rej' then
								local vehicles = ESX.Game.GetVehicles()
								local found = false
								for _, vehicle in ipairs(vehicles) do
									local vehiclePlate = GetVehicleNumberPlateText(vehicle, true)
									if type(vehiclePlate) == 'string' then
										vehiclePlate = vehiclePlate:gsub("%s$", "")
										if vehiclePlate == plate then
											found = true
											break
										end
									end
								end
								if found == true then
									ESX.ShowNotification('~r~Pojazd musi zostać schowany do garażu')
								else
									ESX.UI.Menu.Open(
										'dialog', GetCurrentResourceName(), 'rejestracja',
										{
											title = "Nowa rejestracja (8 znaków włącznie ze spacjami)",
											align = 'center'
										},
										function(data3, menu3)
											if string.len(data3.value) == 8 then
												local newPlate = string.upper(data3.value)
												ESX.TriggerServerCallback('esx_vehicleshop:isPlateTaken', function (isPlateTaken)
													if not isPlateTaken then
														menu3.close()
														menu2.close()
														TriggerServerEvent('flux_garages:updatePlate', plate, newPlate)
													else
														ESX.ShowNotification('~r~Ta rejestracja jest już zajęta')
													end
												end, newPlate)
											else
												ESX.ShowNotification('~r~Nieodpowiednia długość tekstu nowej rejestracji')
											end
										end,
										function(data3,menu3)
											menu3.close()
										end
									)
								end
							end
						end,
						function(data2,menu2)
							menu2.close()
						end
					)
				else
					ESX.ShowNotification("~r~Nie jesteś właścicielem tego pojazdu!")
				end
			end, plate)
		end,
		function(data,menu)
			menu.close()
		end
	)
end
---------------------------------------------------------
function OpenSellCarMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'yesorno',
		{
			title = "Czy na pewno chcesz zakupić umowę za 15 000$?",
			align = 'center',
			elements = {
				{label = "Nie", value = 'no'},
				{label = "Tak", value = 'yes'}
			}
		},
		function(data, menu)
			if data.current.value == 'yes' then
				TriggerServerEvent('flux_garages:buyContract')
				menu.close()
			elseif data.current.value == 'no' then
				menu.close()
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end
---------------------------------------------------------
function OpenPoliceImpoundMenu(zone)
	SendNUIMessage({
		clear = true
	})
	ESX.TriggerServerCallback('flux_garages:getTakedVehicles', function(vehicles)
		for i=1, #vehicles, 1 do
			local name = GetDisplayNameFromVehicleModel(vehicles[i].model)
			TriggerEvent('esx_vehicleshop:getVehicles', function(base)
				local found = false
			  
				for _, vehicle in ipairs(base) do
					if GetHashKey(vehicle.model) == vehicles[i].model then
						name = vehicle.name
						found = true
						break
					end
				end
			  
				if not found then
					local label = GetLabelText(name)
					if label ~= "NULL" then
						name = label
					end
				end

				SendNUIMessage({
					add = true,
					plate = vehicles[i].plate,
					name = name,
					engine = vehicles[i].engineHealth and math.floor((vehicles[i].engineHealth - 500) / 5) or '??',
					body = vehicles[i].bodyHealth and math.floor(vehicles[i].bodyHealth / 10) or '??'
				})
			end)
		end
	end)
	CurrentZone = zone
	SetNuiFocus(true, true)
	SendNUIMessage({openList = true, listType = 'impoundpd'})
end

RegisterNetEvent('esx_contract:getVehicle')
AddEventHandler('esx_contract:getVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= -1 and playerDistance <= 3.0 then
		local vehicle = ESX.Game.GetClosestVehicle(coords)
		local vehiclecoords = GetEntityCoords(vehicle)
		local vehDistance = GetDistanceBetweenCoords(coords, vehiclecoords, true)
		if DoesEntityExist(vehicle) and (vehDistance <= 3) then
			local vehProps = ESX.Game.GetVehicleProperties(vehicle)
			ESX.ShowNotification('Wypisywanie Kontraktu na samochod o numerach: '.. vehProps.plate)
			TriggerServerEvent('esx_clothes:sellVehicle', GetPlayerServerId(closestPlayer), vehProps.plate, vehProps.model)
		else
			ESX.ShowNotification('Nie ma samochodu w pobliżu')
		end
	else
		ESX.ShowNotification('Nie ma nikogo w pobliżu')
	end
	
end)

RegisterNetEvent('esx_contract:showAnim')
AddEventHandler('esx_contract:showAnim', function(player)
	loadAnimDict('anim@amb@nightclub@peds@')
	TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, false)
	Citizen.Wait(20000)
	ClearPedTasks(PlayerPedId())
end)


function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end