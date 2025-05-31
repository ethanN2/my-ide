local function get_last_line(filename)
  local last_line = nil
  for line in io.lines(filename) do
    last_line = line
  end
  return last_line
end

function input_log(file, value)
    local out = io.open(file, 'w')
    if out then
        out:write(value)
        out:close()
    end
end

get_current_directory = function ()
    local project_root = vim.fn.stdpath("data")

    print("Project root:", project_root)

    return project_root
end
