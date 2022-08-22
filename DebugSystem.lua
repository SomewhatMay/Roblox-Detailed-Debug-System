--// Debug Handler \\--
--// SomewhatMay \\--
-- August 19, 2022



local debugHandler = {}

function debugHandler.debug(sourceScript: Script, messageType: string, ...: string)
    local args = {...}
    local gotMessageType = false
    local strings = {}
    
    if typeof(sourceScript) == "Instance" and (sourceScript:IsA("BaseScript") or sourceScript:IsA("ModuleScript")) then
        table.insert(strings, "[" .. sourceScript.Name .. "]:")
    elseif sourceScript ~= nil then
        table.insert(strings, sourceScript)
    end

    if messageType == "_warn" then
        gotMessageType = "warn"
    elseif messageType == "_error" then
        gotMessageType = "error"
    elseif messageType == "_output" then
        gotMessageType = "output"
    else
        gotMessageType = "output"

        if messageType ~= nil then
            table.insert(strings, messageType)
        end
    end

    if args and #args > 0 then
        for _, v in pairs(args) do
            table.insert(strings, v)
        end
    end

    if gotMessageType == "output" then
        print(unpack(strings))
    elseif gotMessageType == "warn" then
        warn(unpack(strings))
    elseif gotMessageType == "error" then
        error(table.concat(strings, " "))
    end
end

function debugHandler.GetPrint(sourceScript: Script)
    return function(...: string)
        return debugHandler.debug(sourceScript, "_output", ...)
    end
end

function debugHandler.GetWarn(sourceScript: Script)
    return function(...: string)
        return debugHandler.debug(sourceScript, "_warn", ...)
    end
end

function debugHandler.GetError(sourceScript: Script)
    return function(...: string)
        return debugHandler.debug(sourceScript, "_error", ...)
    end
end

function debugHandler.GetDebugs(sourceScript: Script)
    return function (...: string)
        return debugHandler.debug(sourceScript, "_output", ...)
    end, function(...: string)
        return debugHandler.debug(sourceScript, "_warn", ...)
    end, function(...: string)
        return debugHandler.debug(sourceScript, "_error", ...)
    end
end


return debugHandler