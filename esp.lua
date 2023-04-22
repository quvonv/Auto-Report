repeat task.wait() until game:IsLoaded()

words = {
    ['pidoras'] = 'Bullying',
    ['blyat'] = 'Bullying',
    ['@БЛЯТЬ'] = 'Bullying',
    ['@ИДИ НАХУЙ'] = 'Bullying',
    ['клоун'] = 'Bullying',
    ['пидарас'] = 'Bullying',
    ['shluha'] = 'Bullying',
    ['shlyha'] = 'Bullying',
    ['@шлюха'] = 'Bullying',
    ['wizard'] = 'Bullying',
    ['reports'] = 'Bullying',
    ['папа'] = 'Bullying',
    ['мама'] = 'Bullying',
    ['тупой'] = 'Bullying',
    ['stupid'] = 'Bullying',
    ['нищий'] = 'Bullying',
    ['дурак'] = 'Bullying',
    ['даун'] = 'Bullying',
    ['yblydok'] = 'Bullying',
    ['урод'] = 'Bullying',
    ['ублюдок'] = 'Bullying',
    ['твар'] = 'Bullying',
    ['тварь'] = 'Bullying',
    ['tvar'] = 'Bullying',
    ['kid'] = 'Bullying',
    ['родители'] = 'Bullying',
    ['кидай дс'] = 'Bullying',
    ['безмамный'] = 'Bullying',
    ['лох'] = 'Bullying',
    ['lox'] = 'Bullying',
    ['loh'] = 'Bullying',
    ['negro'] = 'Bullying',
    ['нига'] = 'Bullying',
    ['negar'] = 'Bullying',
    ['нищий'] = 'Bullying',
    ['умри'] = 'Bullying',
    ['БЛ'] = 'Bullying',
    ['hack'] = 'Scamming',
    ['exploit'] = 'Scamming',
    ['cheat'] = 'Scamming',
    ['download'] = 'Offsite Links',
    ['youtube'] = 'Offsite Links',
    ['dizzy'] = 'Offsite Links',
}

if not game:GetService('ReplicatedStorage'):FindFirstChild('DefaultChatSystemChatEvents') or not game:GetService('ReplicatedStorage'):FindFirstChild('DefaultChatSystemChatEvents'):FindFirstChild('OnMessageDoneFiltering') then return end
DCSCE = game:GetService('ReplicatedStorage'):FindFirstChild('DefaultChatSystemChatEvents')
if not autoreportcfg then
getgenv().autoreportcfg = {
    Webhook = '', 
    autoMessage = {
       enabled = true,
       Message = 'so sad you got autoreported :(',
    },
}
end

local players = game:GetService("Players")
local notifs = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

function notify(title, text)
    notifs:MakeNotification({
        Name = title,
        Content = text,
        Time = 5
    });
end;


if syn then
   notify("Autoreport",'this DOESNT WORK ON SYNAPSE!')
   notify('Autoreport','3ds disabled ReportAbuse so yea')
   return
end

function handler(msg,speaker)
   for i,v in next, words do
      if string.match(string.lower(msg),i) then
         players:ReportAbuse(players[speaker],v,'He is breaking roblox TOS')
         task.wait(1.5)
         players:ReportAbuse(players[speaker],v,'He is breaking roblox TOS')
         if autoreportcfg.Webhook ~= nil and autoreportcfg.Webhook ~= '' and autoreportcfg.Webhook ~= ' ' then
         local data = 
         {
             ["embeds"] = {{
                 ["title"] = "**" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "**",
                 ["description"] = "Auto-reported a player",
                 ["type"] = "rich",
                 ["color"] = tonumber(0x00aff4),
                 ["url"] = "https://www.roblox.com/games/" .. game.PlaceId,
                 ["fields"] = {
                     {
                         ["name"] = "Name",
                         ["value"] = "[" .. players[speaker].Name .. "](https://www.roblox.com/users/" .. players[speaker].UserId .. ")",
                         ["inline"] = true
                     },
                     {
                         ["name"] = "Message",
                         ["value"] = msg,
                         ["inline"] = true
                     },
                     {
                        ["name"] = "Offensive Part",
                        ["value"] = i,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Reported For",
                        ["value"] = v,
                        ["inline"] = true
                    },
                 },
                 ["footer"] = {
                     ["text"] = "\nIf you think this is a mistake: stfu"
                 },
                 ["author"] = {
                     ["name"] = "Auto Report"
                 }
             }}
         }
     local newdata = (game:GetService("HttpService")):JSONEncode(data);
     local request = http_request or request or HttpPost or http.request or syn.request;
     local abcdef = {
         Url = autoreportcfg.Webhook,
         Body = newdata,
         Method = "POST",
         Headers = {
             ["content-type"] = "application/json"
         }
     };
     request(abcdef);
    else
        notify('Autoreport','Autoreported ' .. speaker .. ' | offensive part: ' .. i)
    end
    if DCSCE:FindFirstChild('SayMessageRequest') and autoreportcfg.autoMessage.enabled == true then
       DCSCE.SayMessageRequest:FireServer('/w ' .. speaker .. ' ' .. autoreportcfg.autoMessage.Message,'All')
    end
      end
   end
end

msg = DCSCE:FindFirstChild('OnMessageDoneFiltering')
msg.OnClientEvent:Connect(function(msgdata)
    if tostring(msgdata.FromSpeaker) ~= players.LocalPlayer.Name then
       handler(tostring(msgdata.Message),tostring(msgdata.FromSpeaker))
    end
end)
