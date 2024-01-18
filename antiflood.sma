#include <amxmodx>

new Float:g_Flooding[MAX_PLAYERS + 1]
new g_Flood[MAX_PLAYERS + 1]

new Float:amx_flood_time = 0.0

public plugin_init()
{
	register_plugin("Anti Flood", AMXX_VERSION_STR, "AMXX Dev Team")
	register_dictionary("antiflood.txt")
	register_clcmd("say", "chkFlood")
	register_clcmd("say_team", "chkFlood")
	bind_pcvar_float(create_cvar("amx_flood_time", "0.75"), amx_flood_time)
}

public chkFlood(id)
{
	if (amx_flood_time > 0.0)
	{
		new Float:nexTime = get_gametime()
		
		if (g_Flooding[id] > nexTime)
		{
			if (g_Flood[id] >= 3)
			{
				client_print_color(id, print_team_default, "^4**^3 %L ^4**", id, "STOP_FLOOD")
				g_Flooding[id] = nexTime + amx_flood_time + 3.0
				return PLUGIN_HANDLED
			}
			g_Flood[id]++
		}
		else if (g_Flood[id])
		{
			g_Flood[id]--
		}
		
		g_Flooding[id] = nexTime + amx_flood_time
	}

	return PLUGIN_CONTINUE
}
