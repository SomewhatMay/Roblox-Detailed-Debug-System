--// Debug Handler \\--
--// SomewhatMay \\--
-- August 19, 2022


local debugHandler = {}

-- Create enums
-- If there is not tracebackMode set, the deafult is `TracebackMode.Enabled`
local TracebackMode = {
    Enabled = "debugTracebackEnabled";
    EnabledOpen = "debugTracebackOpen";
    Disabled = "debugTracebackDisabled";
    Code = "debugTracebackCode";
}
local MessageType = {
    Output = "messageTypeOutput";
    Warning = "messageTypeWarning";
    Error = "messageTypeError";
};

debugHandler.TracebackMode = TracebackMode
debugHandler.MessageType = MessageType

function debugHandler.debug(sourceScript: Script, messageType: string, tracebackMode: TracebackMode, ...: string)
    tracebackMode = tracebackMode or TracebackMode.Enabled

    local args = {...}
    local strings = {}
    
    if typeof(sourceScript) == "Instance" and (sourceScript:IsA("BaseScript") or sourceScript:IsA("ModuleScript")) then
        table.insert(strings, "[" .. sourceScript.Name .. "]:")
    elseif sourceScript ~= nil then
        table.insert(strings, tostring(sourceScript))
    end

    if args and #args > 0 then
        for _, v in pairs(args) do
            table.insert(strings, v)
        end
    end

    if (messageType ~= "error") and (tracebackMode ~= TracebackMode.Disabled) then
        local tracebackInformation

        if tracebackMode == TracebackMode.Enabled then
            tracebackInformation = {
                debug.traceback("", 2)
            }
        elseif tracebackMode == TracebackMode.EnabledOpen then
            tracebackInformation = debug.traceback("", 2)
        elseif tracebackMode == TracebackMode.Code then
            tracebackInformation = " (Code: ".. strings[1] .. ")"
            table.remove(strings, 1) -- remove the code from the outputted message
        end

        table.insert(args, tracebackInformation)
    end

    if messageType == MessageType.Output then
        print(unpack(strings))
    elseif messageType == MessageType.Warning then
        warn(unpack(strings))
    elseif messageType == MessageType.Error then
        error(table.concat(strings, " ")) -- does not require a traceback method, automatically creates a traceback
    end
end

function debugHandler.GetPrint(sourceScript: Script, TopLevelTracebackMode: TracebackMode?)
    return function(...: string)
        return debugHandler.debug(sourceScript, MessageType.Output, TopLevelTracebackMode, ...)
    end
end

function debugHandler.GetWarn(sourceScript: Script, TopLevelTracebackMode: TracebackMode?)
    return function(...: string)
        return debugHandler.debug(sourceScript, MessageType.Warning, TopLevelTracebackMode, ...)
    end
end

function debugHandler.GetError(sourceScript: Script, TopLevelTracebackMode: TracebackMode?)
    return function(...: string)
        return debugHandler.debug(sourceScript, MessageType.Error, TopLevelTracebackMode, ...)
    end
end

function debugHandler.GetDebugs(sourceScript: Script, TopLevelTracebackMode: TracebackMode?)
    return debugHandler.GetPrint(sourceScript, TopLevelTracebackMode), 
        debugHandler.GetWarn(sourceScript, TopLevelTracebackMode), 
        debugHandler.GetError(sourceScript, TopLevelTracebackMode)
end


return debugHandler