-- From https://gist.github.com/tarleb/1a78c3aacf917f362805ee1404689dbe
-- Licensed under MIT
local header_ids = {}

local function collect_id(header)
    if header.identifier and header.identifier ~= "" then
        header_ids[header.identifier] = header.content
        header.identifier = ""
        return header
    end
end

local function raw_inlines(s)
    return pandoc.List { pandoc.RawInline('org', s) }
end

local function modify_link(link)
    -- only modify internal links
    if link.target:sub(1, 1) ~= '#' then
        return
    end
    local target_id = link.target:sub(2)
    local header_content = header_ids[target_id]
    if header_content then
        return raw_inlines '[[*'
            .. header_content
            .. raw_inlines ']['
            .. link.content
            .. raw_inlines ']]'
    end
end

return {
    { Header = collect_id },
    { Link = modify_link },
}
