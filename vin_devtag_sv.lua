TriggerEvent('es:addGroupCommand', 'devtag2', "superadmin", function(source, args, user)
	if source == 0 or source == "Console" then return end
	test = tonumber(args[1])
	if test == nil then
		TriggerClientEvent('devTag:TogglePicDisplay', -1, source, nil, "deeznuts")
	end
	if not test then
	elseif test == 1 then
		TriggerClientEvent('devTag:TogglePicDisplay', -1, source, 1, "deeznuts")
	elseif test == 2 then
		TriggerClientEvent('devTag:TogglePicDisplay', -1, source, 2, "deeznuts")
	elseif test == 3 then
		TriggerClientEvent('devTag:TogglePicDisplay', -1, source, 3, "deeznuts")
end
end, {help = "Activate dev tag pic"})




TriggerEvent('es:addGroupCommand', 'devtag', "superadmin", function(source, args, user)
	if source == 0 or source == "Console" then return end
	TriggerClientEvent('devTag:trigger', -1, source, ('%s | %s'):format(GetPlayerName(source), table.concat(args, " ")))
	if args[1] == nil then
		TriggerClientEvent('devTag:trigger', -1, source, nil)
end
end, {help = "Activate dev tag"})