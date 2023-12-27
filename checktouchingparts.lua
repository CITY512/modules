local module = {}

module.CheckTouchingParts = function(tab,ignoredescendantsinstances)
	if #tab > 0 then
		local touchingparts = {}
		for i = 1,#tab,1 do
			local validated = true
			for v = 1,#ignoredescendantsinstances,1 do
				if tab[i]:FindFirstAncestor(ignoredescendantsinstances[v].Name) or tab[i] == ignoredescendantsinstances[v] then
					--  or tab[i]:IsA("Part") and tab[i].CanCollide
					validated = false
					break
				end
			end
			if validated then
				table.insert(touchingparts,tab[i])
			end
		end
		if #touchingparts > 0 then
			return {true,touchingparts}
		else
			return {false,{}}
		end
	else
		return {false,{}}
	end
end

return module
