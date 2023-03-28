# Debug Handler
Debug Handler is a Lua module designed to provide developers with an easy-to-use debugging system. The module enables you to print output messages, warnings, and errors to the console with customizable traceback information.

## Features
Print output messages, warnings, and errors to the console
Customizable traceback information
Convenient functions to retrieve print, warning, and error functions with a top-level traceback mode set
## Usage
### Importing the module
```lua
local debugHandler = require(path.to.debugHandler)
```
### Printing to the console
```lua
debugHandler.debug(sourceScript, messageType, tracebackMode, ...)
```
The debug function allows you to print output messages, warnings, and errors to the console with optional traceback information.

#### Parameters:
* `sourceScript`: The script that the message is coming from. This can be either a Script or ModuleScript instance or any other value.
* `messageType`: A string indicating the type of message. This can be either "messageTypeOutput", "messageTypeWarning", or "messageTypeError".
* `tracebackMode`: An optional value indicating the type of traceback information to be displayed. This can be either "debugTracebackEnabled", "debugTracebackOpen", "debugTracebackDisabled", or "debugTracebackCode".
* `...`: The messages to be printed to the console. These can be any number of strings.
#### Example:
```lua
debugHandler.debug(script, debugHandler.MessageType.Output, debugHandler.TracebackMode.Enabled, "Hello World!")
```

### Retrieving print, warning, and error functions with a top-level traceback mode
```lua
debugHandler.GetPrint(sourceScript, TopLevelTracebackMode?)
debugHandler.GetWarn(sourceScript, TopLevelTracebackMode?)
debugHandler.GetError(sourceScript, TopLevelTracebackMode?)
debugHandler.GetDebugs(sourceScript, TopLevelTracebackMode?)
```
These functions allow you to retrieve print, warning, and error functions with a top-level traceback mode set. The top-level traceback mode is a fallback mode that will be used if no traceback mode is specified in the debug function.

#### Parameters:
* `sourceScript`: The script that the message is coming from. This can be either a Script or ModuleScript instance or any other value.
* `TopLevelTracebackMode`: An optional value indicating the type of traceback information to be displayed. This can be either "debugTracebackEnabled", "debugTracebackOpen", "debugTracebackDisabled", or "debugTracebackCode".
#### Example:
```lua
local print, warn, error = debugHandler.GetDebugs(script, debugHandler.TracebackMode.Enabled)
print("Hello World!")
warn("Something went wrong.")
error("An error occurred.")
```

## API Reference
### `debugHandler.debug(sourceScript: Script, messageType: string, tracebackMode: TracebackMode, ...: string)`
Prints a debug message to the console with optional traceback information.

#### Arguments:
* `sourceScript: Script` (required): The script that the message originates from.
* `messageType: string` (required): The type of message to display. Valid values are MessageType.Output, MessageType.Warning, and MessageType.Error.
* `tracebackMode: TracebackMode` (optional): The level of traceback information to display. Valid values are `TracebackMode.Enabled`, `TracebackMode.EnabledOpen`, `TracebackMode.Disabled`, and `TracebackMode.Code`. Defaults to `TracebackMode.Enabled` if not specified.
* `...: string` (optional): The message string and any additional arguments to include in the debug message.


### `debugHandler.GetPrint(sourceScript: Script, TopLevelTracebackMode: TracebackMode?) -> function(...)`
Returns a function that prints an output message to the console with optional traceback information.

####  Arguments:
* `sourceScript: Script` (required): The script that the message originates from.
* `TopLevelTracebackMode: TracebackMode` (optional): The level of traceback information to display. Valid values are `TracebackMode.Enabled`, `TracebackMode.EnabledOpen`, `TracebackMode.Disabled`, and `TracebackMode.Code`. Defaults to `TracebackMode.Enabled` if not specified.

Returns:
`function(...: string)`: A function that takes a message string and any additional arguments, and prints an output message to the console with optional traceback information.

### `debugHandler.GetWarn(sourceScript: Script, TopLevelTracebackMode: TracebackMode?) -> function(...)`
Returns a function that prints a warning message to the console with optional traceback information.

#### Arguments:
* `sourceScript: Script` (required): The script that the message originates from.
* `TopLevelTracebackMode: TracebackMode` (optional): The level of traceback information to display. Valid values are `TracebackMode.Enabled`, 
* `TracebackMode.EnabledOpen`, `TracebackMode.Disabled`, and `TracebackMode.Code`. Defaults to `TracebackMode.Enabled` if not specified.

Returns:
`function(...: string)`: A function that takes a message string and any additional arguments, and prints a warning message to the console with optional traceback information.

### `debugHandler.GetError(sourceScript: Script, TopLevelTracebackMode: TracebackMode?) -> function(...)`
Returns a function that prints an error message to the console with optional traceback information.

####Arguments:
* `sourceScript: Script` (required): The script that the message originates from.
* `TopLevelTracebackMode: TracebackMode` (optional): The level of traceback information to display. Valid values are `TracebackMode.Enabled`, `TracebackMode.EnabledOpen`, `TracebackMode.Disabled`, and `TracebackMode.Code`. Defaults to `TracebackMode.Enabled` if not specified.

Returns:
`function(...: string)`: A function that takes a message string and any additional arguments, and prints an error message to the console with optional traceback information.

### `debugHandler.GetDebugs(sourceScript: Script, TopLevelTracebackMode: TracebackMode?) -> function(...: string), function(...: string), function(...: string)`
Returns three functions that respectively print an output message, a warning message, and an error message to the console with optional traceback information.

#### Arguments:
`sourceScript: Script` (required): The script that the message originates
