#!/usr/bin/luajit
--A script for patching the Android build files

local GITHUB_WORKSPACE = os.getenv("GITHUB_WORKSPACE") --Get the github workspace location
assert(GITHUB_WORKSPACE, "This script has to be used inside of Github Actions environment!")
dofile(GITHUB_WORKSPACE.."/lua_utils/shared.lua") --Load the shared utilities

--== Patch /app/build.gradle ==--

print(string.rep("-",40))

do
    print("Patching /love_android/app/build.gradle...")
    local data = fs.read("/love_android/app/build.gradle")

    do
        print("Replacing applicationId...")
        local result, occurrences = data:gsub("applicationId 'org.love2d.android'", "applicationId 'me.ramilego4game.liko12'")
        assert(occurrences == 1, "Failed to patch applicationId!")
        data = result
    end

    do
        print("Replacing VersionCode...")
        local result, occurrences = data:gsub("versionCode %d%d", "versionCode "..ANDROID_VERSION_CODE)
        assert(occurrences == 1, "Failed to patch VersionCode!")
        data = result
    end

    do
        print("Replacing VersionName...")
        local result, occurrences = data:gsub("versionName '.-'", "versionName '"..LIKO_VERSION.."'")
        assert(occurrences == 1, "Failed to patch VersionName!")
        data = result
    end
    
    fs.write("/love_android/app/build.gradle", data)
    print("Patched /love_android/app/build.gradle successfully!")
end

print(string.rep("-",40))
