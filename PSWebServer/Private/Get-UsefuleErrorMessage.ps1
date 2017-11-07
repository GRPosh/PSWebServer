function Get-UsefulErrorMessage {
    
                param(
                    $PowerShellError,
                    $Parameters
                )
                try {
                    $JSON = ($PowerShellError | ConvertTo-Json) + ($parameters | ConvertTo-Json )
                } catch {
                    $JSON = "JSON serialization of this error failed. Fix this for more detailed response    $($PowerShellError.Exception)" + ($parameters | ConvertTo-Json )
                }
    
                $WebPage = @"
            <!DOCTYPE HTML>
            <html>
            <head>
            <title>ERROR 500</title>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <!-- when using the mode "code", it's important to specify charset utf-8 -->
            <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/jsoneditor/5.5.6/jsoneditor.min.css" rel="stylesheet" type="text/css">
            <script src="https://cdnjs.cloudflare.com/ajax/libs/jsoneditor/5.5.6/jsoneditor.min.js"></script>
            <style type="text/css">
                body {
                font: 10.5pt arial;
                color: #4d4d4d;
                line-height: 150%;
                width: 100%;
                }
                code {
                background-color: #f5f5f5;
                }
                #jsoneditor {
                width: 90%;
                }
            </style>
            </head>
            <body>
            <h1>
            Error 500: PSWebServer encountered an unhandled exception
            </h1>
            <h3 style="color:red;">
            $($PowerShellError.InvocationInfo.MyCommand.Name) : $($PowerShellError.Exception.Message)<br/>
            $($PowerShellError.InvocationInfo.PositionMessage -replace "`n","<br/>")<br/>
            $($PowerShellError.CategoryInfo | ConvertTo-Html -Fragment -As List)<br/>
            $($PowerShellError.FullyQualifiedErrorId)<br/>
            </h3>
            <h3>
            Details
            </h3>
            <div id="jsoneditor"></div>
            <script>
            var container = document.getElementById('jsoneditor');
            var options = {
                mode: 'tree',
                modes: ['code', 'form', 'text', 'tree', 'view'], // allowed modes
                onError: function (err) {
                alert(err.toString());
                },
                onModeChange: function (newMode, oldMode) {
                console.log('Mode switched from', oldMode, 'to', newMode);
                }
            };
            var json = $JSON
            var editor = new JSONEditor(container, options, json);
            </script>
            </body>
            </html>
"@
    
                return $WebPage
    
            }