#!/usr/bin/luajit
--A script for downloading the appimages.

local GITHUB_WORKSPACE = os.getenv("GITHUB_WORKSPACE") --Get the github workspace location
assert(GITHUB_WORKSPACE, "This script has to be used inside of Github Actions environment!")
dofile(GITHUB_WORKSPACE.."/lua_utils/shared.lua") --Load the shared utilities

--== Download AppImages ==--

--LÖVE AppImages

local baseURL = "https://bitbucket.org/rude/love/downloads/love-%s-%s.AppImage"
local baseDestination = "love-%s-%s.AppImage"

for _, platform in ipairs(LINUX_PLATFORMS) do
    print("Downloading LÖVE "..tostring(LOVE_VERSION).." ")
    local url = string.format(baseURL, LOVE_VERSION, platform)
    local destination = string.format(baseDestination, LOVE_VERSION, platform)
    wget(url, destination)
    chmod(destination)
end

--AppImage Tools
wget("https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage", "appimagetool.AppImage")
chmod("appimagetool.AppImage")