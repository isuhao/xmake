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
-- @file        compiler.lua
--

-- define module
local sandbox_core_tool_compiler = sandbox_core_tool_compiler or {}

-- load modules
local platform  = require("platform/platform")
local compiler  = require("tool/compiler")
local raise     = require("sandbox/modules/raise")

-- make command for compiling source file
function sandbox_core_tool_compiler.compcmd(sourcefile, objectfile, target)
 
    -- get the compiler instance
    local instance, errors = compiler.load(compiler.kind_of_file(sourcefile))
    if not instance then
        raise(errors)
    end

    -- make command
    return instance:compcmd(sourcefile, objectfile, target)
end

-- make compiling flags for the given target
function sandbox_core_tool_compiler.compflags(sourcefile, target)
 
    -- get the compiler instance
    local instance, errors = compiler.load(compiler.kind_of_file(sourcefile))
    if not instance then
        raise(errors)
    end

    -- make flags
    return instance:compflags(target)
end

-- compile source file
function sandbox_core_tool_compiler.compile(sourcefile, objectfile, incdepfile, target)
 
    -- get the compiler instance
    local instance, errors = compiler.load(compiler.kind_of_file(sourcefile))
    if not instance then
        raise(errors)
    end

    -- compile it
    local ok, errors = instance:compile(sourcefile, objectfile, incdepfile, target)
    if not ok then
        raise(errors)
    end
end

-- get kind of the compiling source file
function sandbox_core_tool_compiler.kind_of_file(sourcefile)
    return compiler.kind_of_file(sourcefile)
end

-- return module
return sandbox_core_tool_compiler
