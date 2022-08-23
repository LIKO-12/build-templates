#!/usr/bin/luajit
--A script for downloading the appimages.

local GITHUB_WORKSPACE = os.getenv("GITHUB_WORKSPACE") --Get the github workspace location
assert(GITHUB_WORKSPACE, "This script has to be used inside of Github Actions environment!")
dofile(GITHUB_WORKSPACE.."/lua_utils/shared.lua") --Load the shared utilities

--== Patch AppImages ==--

local baseName = "love-%s-%s.AppImage"

for _, platform in ipairs(LINUX_PLATFORMS) do
    print("Making platform",platform)
    local appImageName = string.format(baseName, LOVE_VERSION, platform)
    print("Extracting the AppImage...")
    execute(fixPath(appImageName), "--appimage-extract")
    print("Adding in License file...")
    fs.copy("LIKO-12-license.txt", "squashfs-root/license.txt")
    print("Replacing Icon and Manifest")
    fs.copy("linux/love.svg", "squashfs-root/love.svg")
    fs.copy("linux/love.desktop", "squashfs-root/love.desktop")
    print("Packing back the AppImage...")
    execute(fixPath("appimagetool.AppImage"), "squashfs-root")
    fs.remove("squashfs-root")
    print("Removing the original LÖVE AppImage...")
    fs.remove(appImageName)
end

print("Patched AppImages successfully!")