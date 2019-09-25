#!/usr/bin/luajit
--A script for uploading the releases into gothub using github-release

local GITHUB_WORKSPACE = os.getenv("GITHUB_WORKSPACE") --Get the github workspace location
assert(GITHUB_WORKSPACE, "This script has to be used inside of Github Actions environment!")
dofile(GITHUB_WORKSPACE.."/lua_utils/shared.lua") --Load the shared utilities

--== Upload Templates ==--

local templates = {
    ["love_win32.zip"] = "LIKO-12_i686_Windows.zip",
    ["love_win64.zip"] = "LIKO-12_x86_64_Windows.zip",
    ["LIKO-12-x86_64.AppImage"] = "LIKO-12_x86_64_Linux.AppImage",
    ["love_macos.zip"] = "LIKO-12_macOS.zip"
}

print("GITHUB_REF", os.getenv("GITHUB_REF"))

local tag = getLatestTag()

--Upload a file into github releases
local function upload(path, name)
    local command = {
        "github-release", "upload",
        "--user", USER,
        "--repo", REPO,
        "--tag", tag,
        "--name", escape(name),
        "--file", escape(fixPath(path)),
        "--replace"
    }

    command = table.concat(command, " ")
    execute(command)
end

for path, name in pairs(templates) do
    upload(path, name)
    print("Uploaded", name)
end

print("Uploading releases complete!")