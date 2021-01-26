local activeTag = {}
local activeTag2 = {}

Utils = {
  Draw3DText = function(coords, message, txtColor)
    local onScreen, x, y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)
    local camCoords = GetGameplayCamCoords()
    local scale = ((1 / GetDistanceBetweenCoords(camCoords, coords, true)) * 2) * ((1 / GetGameplayCamFov()) * 100)
    local txtColor = txtColor or color
  
    if onScreen then
      SetTextColour(txtColor.r, txtColor.g, txtColor.b, txtColor.a)
      SetTextScale(0.0 * scale, 0.55 * scale)
      SetTextFont(font)
      SetTextProportional(true)
      SetTextCentre(true)
  
      BeginTextCommandDisplayText('STRING')
      AddTextComponentSubstringPlayerName(message)
      EndTextCommandDisplayText(x, y)
    end
  end,
}

RegisterNetEvent('devTag:trigger')
AddEventHandler('devTag:trigger', function(sender, message)
	if message ~= nil and message ~= '' and message ~= ' ' then
		activeTag[sender] = message
	else
		activeTag[sender] = nil
    end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		for k, v in pairs(activeTag) do
			local target = GetPlayerFromServerId(k)

			if (target ~= PlayerId() and target > 0) or (GetPlayerServerId(PlayerId()) == k) then
				local targetPed = GetPlayerPed(target)
				local targetCoords = GetPedBoneCoords(targetPed, 31086, 0.5, 0.0, 0.0)

				if GetDistanceBetweenCoords(targetCoords, GetEntityCoords(PlayerPedId(), false)) < 25.0 and not IsPedInAnyVehicle(targetPed, false) then
					Utils.Draw3DText(targetCoords, v, {r = 255, g = 182, b = 13, a = 255})
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
  local string = ""
while true do
      local html = ""
      for k, v in pairs(activeTag2) do
          
        local player = GetPlayerFromServerId(k)
        if NetworkIsPlayerActive(player) then
            local sourcePed, targetPed = GetPlayerPed(player), PlayerPedId()
                local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)
                local pedCoords = GetPedBoneCoords(sourcePed, 0x2e28, 0.0, 0.0, 0.0)
      
                  if player == source or #(sourceCoords - targetCoords) < 10 then
                      local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(pedCoords.x, pedCoords.y, pedCoords.z + 1.2)
                      if not onScreen then
                  if v.type == "deeznuts" then
                      html = html .. "<span style=\"position: absolute; left: ".. xxx * 120 .."%;top: ".. yyy * 120 .."%;\">"
                      html = html .. "<img \" width=\"55px\" height=\"55px\" src=\"option_".. v.num ..".png\">"    
                      html = html .. "</img></span>"
                  end
               end
            end
        end
      end
      if string ~= html then
          SendNUIMessage({
              type = true,
              html = html
          })
          string = html
      end
      Wait(250)
end
end)

RegisterNetEvent("devTag:TogglePicDisplay")
AddEventHandler("devTag:TogglePicDisplay", function(playerId, number, typ)
	activeTag2[tonumber(playerId)] = {num = number, type = typ}
end)

RegisterNetEvent('devTag:trigger')
AddEventHandler('devTag:trigger', function(sender, message)
	if message ~= nil and message ~= '' and message ~= ' ' then
		activeTag[sender] = message
	else
		activeTag[sender] = nil
	end
end)