local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
if (string.find(data.Content, "状态") == 1) then
        response, error_message =
            http.request(
            "GET",
            "http://localhost:8888/v1/ClusterInfo"
        )
        local html = response.body
        local status = html
		local a = json.decode(status)
            ApiRet =
                Api.Api_SendMsg(
                CurrentQQ,
                {
                    toUser = data.FromGroupId,
                    sendToType = 2,
                    sendMsgType = "TextMsg", 
                    groupid = 0,
                    content = "BOT运行状态: " .. "\nClusterIP: " ..a.ClusterIP.. "\nGCTime: " ..a.GCTime.. "\nVersion:" ..a.Version.. "\nTotalAlloc: " ..a.TotalAlloc.. "\nServerRuntime: " ..a.ServerRuntime.. "\n" ..a.QQUsers[1].UserLevelInfo.. "",
                    atUser = 0
                }
            )
		    html = nil
            status = nil
			a = nil
    end
        return 1
end
function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end
