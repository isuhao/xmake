--!The Make-like Build Utility based on Lua
--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements.  See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership.  The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License.  You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- 
-- Copyright (C) 2015 - 2017, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        load.lua
--

-- imports
import("core.project.config")

-- load it
function main()

    -- init the file formats
    _g.formats          = {}
    _g.formats.static   = {"lib", ".a"}
    _g.formats.object   = {"",    ".o"}
    _g.formats.shared   = {"lib", ".dylib"}
    _g.formats.symbol   = {"",    ".sym"}

    -- init flags for architecture
    local arch          = config.get("arch")
    local target_minver = config.get("target_minver")
    _g.cxflags = { "-arch " .. arch, "-fpascal-strings", "-fmessage-length=0" }
    _g.mxflags = { "-arch " .. arch, "-fpascal-strings", "-fmessage-length=0" }
    _g.asflags = { "-arch " .. arch }
    _g.ldflags = { "-arch " .. arch, "-mmacosx-version-min=" .. target_minver, "-stdlib=libc++", "-lz" }
    _g.shflags = { "-arch " .. arch, "-mmacosx-version-min=" .. target_minver, "-stdlib=libc++", "-lz" }
    _g.scflags = { format("-target %s-apple-macosx%s", arch, target_minver) }

    -- init flags for the xcode sdk directory
    local xcode_dir     = config.get("xcode_dir")
    local xcode_sdkver  = config.get("xcode_sdkver")
    local xcode_sdkdir  = xcode_dir .. "/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX" .. xcode_sdkver .. ".sdk"
    insert(_g.cxflags, "-isysroot " .. xcode_sdkdir)
    insert(_g.asflags, "-isysroot " .. xcode_sdkdir)
    insert(_g.mxflags, "-isysroot " .. xcode_sdkdir)
    insert(_g.ldflags, "-isysroot " .. xcode_sdkdir)
    insert(_g.shflags, "-isysroot " .. xcode_sdkdir)
    insert(_g.scflags, "-sdk " .. xcode_sdkdir)

    -- init includedirs
    --
    -- @note 
    -- cannot use _g.includedirs because the swift/objc compiler will compile code failed
    insert(_g.cxflags, "-I/usr/include")
    insert(_g.cxflags, "-I/usr/local/include")

    -- init linkdirs
    _g.linkdirs    = {"/usr/lib", "/usr/local/lib"}

    -- save swift link directory for tools
    config.set("__swift_linkdirs", xcode_dir .. "/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx")

    -- ok
    return _g
end


