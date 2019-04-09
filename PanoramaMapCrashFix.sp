#include <sourcemod>

#pragma semicolon 1
#pragma tabsize 0
#pragma newdecls required

public Plugin myinfo =
{
    name = "[CSGO] Panorama Map Crash Fix",
    author = "Kashinoda",
    description = "Prevent client crashes on map change",
    version = "1.4.0",
    url = "https://github.com/kashinoda/"
};

public void OnPluginStart()
{
    AddCommandListener(MapChange, "changelevel");
    AddCommandListener(MapChange, "map");
}

public Action MapChange(int client, const char[] cmd, int argc)
{
    LogMessage("Map changing, sending 'retry' to clients");

    for (int i = 1; i <= MaxClients; i++)
    {
        if (IsClientConnected(i) && !IsFakeClient(i))
        {
            ClientCommand(i, "retry");
            LogMessage("Sending retry to %N", i);
        }
    }
}
