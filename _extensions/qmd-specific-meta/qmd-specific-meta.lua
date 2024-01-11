
function Meta (el)
  local fromPath = quarto.project.directory
  local toPath = quarto.doc.input_file
  local offset = quarto.project.offset
  local pathFromYml = getRelativePath(fromPath, toPath, offset)
  
  local qmdMeta = el["qmd-specific-meta"]
  el["qmd-specific-meta"] = nil
  
  for _,doc in ipairs(qmdMeta) do
    if doc.href[1].text == pathFromYml then
      doc.href = nil
      for k,v in pairs(doc) do
        el[k] = nil
        el[k] = v
      end
    end
  end

  return el

end

-----------------------
-- Utility Functions --
-----------------------

function getRelativePath(fromPath, toPath, offset)
    local fromSegments = {}
    local toSegments = {}
    
    -- Split the paths into segments using the path separator
    for segment in fromPath:gmatch("([^/]+)") do
        table.insert(fromSegments, segment)
    end
    
    for segment in toPath:gmatch("([^/]+)") do
        table.insert(toSegments, segment)
    end
    
    -- Find the common prefix
    local commonPrefix = {}
    for i, segment in ipairs(fromSegments) do
        if toSegments[i] == segment then
            table.insert(commonPrefix, segment)
        else
            break
        end
    end
    
    -- Calculate the number of segments to go up from the 'from' path
    local upSegments = {}
    for _ = #commonPrefix + 1, #fromSegments do
        table.insert(upSegments, "..")
    end
    
    -- Build the relative path
    local relativePathSegments = {}
    for i = #commonPrefix + 1, #toSegments do
        table.insert(relativePathSegments, toSegments[i])
    end
    
    -- Combine the segments into a single path
    local relativePath = table.concat(upSegments, "/") .. "/" .. table.concat(relativePathSegments, "/")
    
    -- Remove a leading "/" if it exists
    if relativePath:sub(1, 1) == "/" then
        relativePath = relativePath:sub(2)
    end
    
    -- Add the offset to the beginning of the relative path
    if offset and offset ~= "" then
        if relativePath == "" then
            relativePath = offset
        else
            if offset == "." then
                relativePath = relativePath
            else
                relativePath = offset .. "/" .. relativePath
            end
        end
    end
    
    return relativePath
end
