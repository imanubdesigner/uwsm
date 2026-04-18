Name = "manuBackgroundSelector"
NamePretty = "Wallpapers"
Cache = false
HideFromProviderlist = false
SearchName = true

local function ShellEscape(s)
	return "'" .. s:gsub("'", "'\\''") .. "'"
end

function FormatName(filename)
	local name = filename:gsub("%.[^%.]+$", ""):gsub("[-_]", " ")
	name = name:gsub("%S+", function(word)
		return word:sub(1, 1):upper() .. word:sub(2):lower()
	end)
	return name
end

function GetEntries()
	local entries = {}
	local home = os.getenv("HOME")
	local wallpaper_dir = home .. "/Pictures/wallpapers"

	local handle = io.popen(
		"find "
			.. ShellEscape(wallpaper_dir)
			.. " -maxdepth 1 -type f \\( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.webp' \\) 2>/dev/null | sort"
	)

	if handle then
		for background in handle:lines() do
			local filename = background:match("([^/]+)$")
			if filename then
				table.insert(entries, {
					Text = FormatName(filename),
					Value = background,
					Actions = {
						activate = "manu-walker-background " .. ShellEscape(background),
					},
					Preview = background,
					PreviewType = "file",
				})
			end
		end
		handle:close()
	end

	return entries
end
