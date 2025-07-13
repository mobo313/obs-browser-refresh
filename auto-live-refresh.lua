local obs = obslua
local selected_source_name = ""

-- Script description
function script_description()
    return [[
        <h2>Auto-Refresh Browser Source on Start Streaming</h2>
        🔄 This script automatically refreshes the selected <i>Browser Source</i> whenever streaming starts.
        Select the browser source from the dropdown menu:
    ]]
end

-- UI for script settings
function script_properties()
    local props = obs.obs_properties_create()
    local p = obs.obs_properties_add_list(props, "source", "Browser Source to Refresh",
        obs.OBS_COMBO_TYPE_EDITABLE, obs.OBS_COMBO_FORMAT_STRING)

    local sources = obs.obs_enum_sources()
    if sources ~= nil then
        for _, source in ipairs(sources) do
            local source_id = obs.obs_source_get_id(source)
            if source_id == "browser_source" then
                local name = obs.obs_source_get_name(source)
                obs.obs_property_list_add_string(p, name, name)
            end
        end
        obs.source_list_release(sources)
    end

    return props
end

-- Load saved settings
function script_update(settings)
    selected_source_name = obs.obs_data_get_string(settings, "source")
end

-- Refresh selected browser source
local function refresh_selected_browser()
    if selected_source_name == "" then return end

    local source = obs.obs_get_source_by_name(selected_source_name)
    if source ~= nil then
        local properties = obs.obs_source_properties(source)
        local property = obs.obs_properties_get(properties, "refreshnocache")
        if property ~= nil then
            obs.obs_property_button_clicked(property, source)
        end
        obs.obs_properties_destroy(properties)
        obs.obs_source_release(source)
        print("Refreshed browser source: " .. selected_source_name)
    end
end

-- Respond to OBS events
local function on_event(event)
    if event == obs.OBS_FRONTEND_EVENT_STREAMING_STARTED then
        refresh_selected_browser()
    end
end

-- Register callback on script load
function script_load(settings)
    obs.obs_frontend_add_event_callback(on_event)
end
