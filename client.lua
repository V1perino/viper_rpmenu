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

local PlayerData = {}
ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setjob')
AddEventHandler('esx:setjob', function(job)
  PlayerData.job = job
end)

function OpenLicensesInformation()
  ESX.UI.Menu.Close()

  ESX.UI.Menu.Open('default',GetCurrentResourceName(),'more_info',
  { 
  title = _U('titleInfo'), 
  align = 'bottom-right', 
  elements = {
    {label = _U('seeid'), value = 'seeID'},
    {label = _U('showid'), value = 'showID'},
      {label = _U('seedriver'), value = 'seeDriver'},
      {label = _U('showdriver'), value = 'showDriver'},
      {label = _U('seeguns'), value = 'seeGuns'},
      {label = _U('showguns'), value = 'showGuns'},
    },
  }, function(data, menu)

    local player, distance = ESX.Game.GetClosestPlayer()

    if data.current.value == 'seeID' then
      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))  -- jsfour-idcard
    elseif data.current.value == 'showID' then
      if distance ~= -1 and distance <= 3.0 then
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
      else
        ESX.ShowNotification('Žádný hráč kolem')
      end      
  elseif data.current.value == 'seeDriver' then
      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')  -- jsfour-idcard
    elseif data.current.value == 'showDriver' then
      if distance ~= -1 and distance <= 3.0 then
        TriggerServerEvent('idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')   -- jsfour-idcard
      else
        ESX.ShowNotification('Žádný hráč kolem')   -- Change notification (I have custom nofitifactions, thats why im using <span>)
      end
    elseif data.current.value == 'seeGuns' then
      TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapons')  -- jsfour-idcard
    elseif data.current.value == 'showGuns' then
      if distance ~= -1 and distance <= 3.0 then
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapons')  -- jsfour-idcard
      else
        ESX.ShowNotification('Žádný hráč kolem')  -- Change notification (I have custom nofitifactions, thats why im using <span>)
      end
    end
  end, function(data, menu) 
  menu.close() 
  end)
end

--[[function OpenHUDMenu()
  ESX.UI.Menu.Close()

  local hud = true
  local cinematica = false
  ESX.UI.Menu.Open('default',GetCurrentResourceName(),'hud_menu',
  { 
  title = _U('hudtitle'), 
  align = 'bottom-right', 
  elements = {
    {label = _U('toggleHUD'), value = 'togglehud'},
    {label = _U('cinematic'), value = 'cinematica'},
    {label = _U('clearChat'), value = 'clearChat'},

  },
  }, function(data, menu)
    if data.current.value == 'togglehud' then
      if hud then
        ExecuteCommand("nohud")                                                         -- Im using InfamesHUD
        ESX.ShowNotification('Has <span style="color:yellow">desactivado</span> el HUD')  -- Change notification (I have custom nofitifactions, thats why im using <span>)
        hud = false
      else
        ExecuteCommand("verhud")                                                        -- Im using InfamesHUD
        ESX.ShowNotification('Has <span style="color:yellow">activado</span> el HUD')  -- Change notification (I have custom nofitifactions, thats why im using <span>)
        hud = true 
      end
    elseif data.current.value == 'cinematica' then
      if cinematica then 
        ExecuteCommand("cinematica")                                                                -- Im using SimpleCinematic
        ESX.ShowNotification('Has <span style="color:yellow">desactivado</span> el modo cinemática')  -- Change notification (I have custom nofitifactions, thats why im using <span>)
        cinematica = false
      else
        ExecuteCommand("cinematica")                                                                -- Im using SimpleCinematic
        ESX.ShowNotification('Has <span style="color:yellow">activado</span> el modo cinemática')  -- Change notification (I have custom nofitifactions, thats why im using <span>)
        cinematica = true
      end
    elseif data.current.value == 'clearChat' then
      ExecuteCommand("clear")
      ESX.ShowNotification('Has <span style="color:yellow">borrado</span> el chat')  -- Change notification (I have custom nofitifactions, thats why im using <span>)
    end
  end, function(data, menu) 
  menu.close() 
  end)
end]]--

function OpenMenuPersonal()
    ESX.UI.Menu.CloseAll()

    local DataJob = ESX.GetPlayerData()
    local ids = true
    local job = DataJob.job.label
    local jobgrade = DataJob.job.grade_label



    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'rp-menupersonal',
      {
        title    = _U('title'),
        align    = 'bottom-right',
        elements = {
          {label = _U('interakce'), value = 'interakce'},
          {label = _U('vozidlo'), value = 'carmenu'},
          {label = _U('billing'), value = 'billing_menu'},
          {label = _U('infoLicenses'), value = 'licenses_interaction'},
          {label = _U('ability'), value = 'ability'},
          {label = _U('headerJob'), value = 'header'},
          {label = job .. " - " .. jobgrade},
        },
      },
      function(data, menu)

        local player, distance = ESX.Game.GetClosestPlayer()

        if data.current.value == 'interakce' then
          OpenSearchActionsMenu() 
        elseif data.current.value == 'carmenu' then
          ExecuteCommand("carmenu")                              
        elseif data.current.value == 'showid' then
          local player, distance = ESX.Game.GetClosestPlayer()
          if distance ~= -1 and distance <= 3.0 then
	          TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))  -- jsfour-idcard
          else
            ESX.ShowNotification('Žádný hráč kolem')  -- Change notification (I have custom nofitifactions, thats why im using <span>)
          end
        elseif data.current.value == 'seeid' then
          TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))   -- jsfour-idcard
        elseif data.current.value == 'licenses_interaction' then
          OpenLicensesInformation()
        elseif data.current.value == 'ability' then
          exports["gamz-skillsystem"]:SkillMenu()
        elseif data.current.value == 'billing_menu' then
          ExecuteCommand("faktury")                                      -- esx_billing
        end
      end,
      function(data, menu)
        menu.close()
      end
    )
end



function ShowBillsMenu()

	ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
		ESX.UI.Menu.CloseAll()
		local elements = {}

		for i=1, #bills, 1 do
			table.insert(elements, {
				label  = ('%s - <span style="color:red;">%s</span>'):format(bills[i].label, _U('invoices_item', ESX.Math.GroupDigits(bills[i].amount))),
				billID = bills[i].id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
		{
			title    = _U('invoices'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			ESX.TriggerServerCallback('esx_billing:payBill', function()
				ShowBillsMenu()
			end, data.current.billID)
		end, function(data, menu)
			menu.close()
		end)
	end)

end


function OpenSearchActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'interakce', {
		css      = 'interakce',
		title    = 'Interakce',
		align    = 'bottom-right',
		elements = {
            {label = ('Prohledat'), value = 'body_search'},
            --{label = ('Cuff'), value = 'handcuff'},
            --{label = ('Uncuff'), value = 'uncuff'},
            --{label = ('Drag'), value = 'drag'},
            {label = ('Vložit do vozidla'), value = 'put_in_vehicle'},
            {label = ('Vyložit z vozidla'), value = 'out_the_vehicle'},
	}}, function(data, menu)

		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			local action = data.current.value

			if data.current.value == 'body_search' then
        TriggerServerEvent('viper_rpmenu:message', GetPlayerServerId(closestPlayer), _U('jsi_prohledavan'))
        exports.ox_inventory:openNearbyInventory()
			elseif data.current.value == 'handcuff' then
				local target, distance = ESX.Game.GetClosestPlayer()
				playerheading = GetEntityHeading(GetPlayerPed(-1))
				playerlocation = GetEntityForwardVector(PlayerPedId())
				playerCoords = GetEntityCoords(GetPlayerPed(-1))
				local target_id = GetPlayerServerId(target)
				if distance <= 2.0 then
					TriggerServerEvent('viper_thiefmenu:requestarrest', target_id, playerheading, playerCoords, playerlocation)
				end
			elseif data.current.value == 'uncuff' then
				local target, distance = ESX.Game.GetClosestPlayer()
				playerheading = GetEntityHeading(GetPlayerPed(-1))
				playerlocation = GetEntityForwardVector(PlayerPedId())
				playerCoords = GetEntityCoords(GetPlayerPed(-1))
				local target_id = GetPlayerServerId(target)
				if distance <= 2.0 then
					TriggerServerEvent('viper_thiefmenu:requestrelease', target_id, playerheading, playerCoords, playerlocation)
				end
			elseif data.current.value == 'drag' then
				TriggerServerEvent('viper_thiefmenu:drag', GetPlayerServerId(closestPlayer))
			elseif data.current.value == 'put_in_vehicle' then
				TriggerServerEvent('viper_thiefmenu:putInVehicle', GetPlayerServerId(closestPlayer))
			elseif data.current.value == 'out_the_vehicle' then
				TriggerServerEvent('viper_thiefmenu:OutVehicle', GetPlayerServerId(closestPlayer))
			end
		else
			ESX.ShowNotification('No players nearby!')
		end
	end, function(data, menu)
		menu.close()
	end)
end



--Key Controls
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlPressed(0,  166) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'rp-menupersonal')  then
      OpenMenuPersonal()
    end
  end
end)

function IsAbleToSteal(targetSID, err)
	ESX.TriggerServerCallback('esx_thief:getValue', function(result)
		local result = result
		if result.value then
			err(false)
		else
			err(_U('no_hands_up'))
		end
	end, targetSID)
end
