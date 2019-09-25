#!/usr/bin/luajit
--A script for patching LÖVE macOS Info.plist

--== Start of Configuration ==--
local packageName = "LIKO-12"
local packageID = "me.ramilego4game.liko12"
--== End of Configuration ==--

local GITHUB_WORKSPACE = os.getenv("GITHUB_WORKSPACE"))

--Print usage information
if (...) == "-h" or (...) == "--help" or (...) == "-?" or (select("#",...) == 0 and not GITHUB_WORKSPACE then
	print("Usage:")
	print("  luajit patch_info_plist.lua \"<Info.plist>\"")
	print("  luajit patch_info_plist.lua \"<source>\" \"<target>\"")
	os.exit(1)
end

--Arguments
local source, target = ...
source = source or GITHUB_WORKSPACE.."/love_macos/love.app/Contents/Info.plist"
target = target or source


--Read source file data.
print("Openning source for reading...")
local sourceFile = assert(io.open(source,"r"))
print("Reading the whole source file...")
local sourceData = sourceFile:read("*a")
print("Closing source file...")
sourceFile:close()

print(string.rep("-", 40))

--Patch CFBundleIdentifier
do
	local spos, epos = string.find(sourceData, "<key>CFBundleIdentifier</key>\n\t<string>")
	assert(spos, "Could not find CFBundleIdentifier!")
	
	local preData = string.sub(sourceData, 1,epos)
	local postData = string.sub(sourceData, epos + string.len("org.love2d.love") + 1, -1)
	sourceData = preData .. packageID .. postData
	print("Patched CFBundleIdentifier at "..spos..", "..epos)
end

--Patch CFBundleName
do
	local spos, epos = string.find(sourceData, "<key>CFBundleName</key>\n\t<string>")
	assert(spos, "Could not find CFBundleName!")
	
	local preData = string.sub(sourceData, 1,epos)
	local postData = string.sub(sourceData, epos + string.len("LÖVE") + 1, -1)
	sourceData = preData .. packageName .. postData
	print("Patched CFBundleName at "..spos..", "..epos)
end

--Remove UTExportedTypeDeclarations
do
	local removalResult, occurrences = sourceData:gsub("\n\t<key>UTExportedTypeDeclarations</key>.-\n\t</array>", "", 1)
	assert(occurrences and occurrences > 0, "Failed to remove UTExportedTypeDeclarations")
	
	sourceData = removalResult
	print("Removed UTExportedTypeDeclarations")
end

print(string.rep("-", 40))

--Write target data
print("Openning target for writing...")
local targetFile = assert(io.open(target,"w"))
print("Writing the patched source file data...")
targetFile:write(sourceData)
print("Flushing target file content...")
targetFile:flush()
print("Closing target file...")
targetFile:close()

print(string.rep("-", 40))

print("Patched successfully!")
os.exit(0)
