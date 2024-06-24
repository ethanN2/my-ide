return {
    "mhinz/vim-startify",

    config = function()
        vim.g.startify_bookmarks = vim.fn.systemlist("cut -sd' ' -f 2- ~/.NERDTreeBookmarks")

        -- returns all modified files of the current git repo
        -- `2>/dev/null` makes the command fail quietly, so that when we are not
        -- in a git repo, the list will be empty
        local function gitModified()
            local files = vim.fn.systemlist('git ls-files -m 2>/dev/null')
            return vim.fn.map(files, "{'line': v:val, 'path': v:val}")
        end

        -- same as above, but show untracked files, honouring .gitignore
        local function gitUntracked()
            local files = vim.fn.systemlist('git ls-files -o --exclude-standard 2>/dev/null')
            return vim.fn.map(files, "{'line': v:val, 'path': v:val}")
        end

        local function nerdtreeBookmarks()
            local bookmarks = vim.fn.systemlist("cut -d' ' -f 2- ~/.NERDTreeBookmarks")
            local selected_bookmarks = {}

            -- Loop through the original table and skip the last two elements
            for i = 1, #bookmarks - 2 do
                table.insert(selected_bookmarks, bookmarks[i])
            end
            return vim.fn.map(selected_bookmarks, "{'line': v:val, 'path': v:val}")
        end

        local function branch_name()
            local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
            if branch ~= "" then
                return branch
            else
                return ""
            end
        end

        local function GetUniqueSessionName()
            local path = vim.fn.fnamemodify(vim.fn.getcwd(), ':~:t')
            path = vim.fn.empty(path) and 'no-project' or path
            local branch = branch_name()
            branch = vim.fn.empty(branch) and '' or '-' .. branch
            return vim.fn.substitute(path .. branch, '/', '-', 'g')
        end

        --vim.api.nvim_create_autocmd({"User"}, {
        --    pattern = "StartifyReady",
        --    callback = function() vim.api.nvim_command('SLoad ' .. GetUniqueSessionName()) end,
        --})
        --
        --vim.api.nvim_create_autocmd({"VimLeavePre"}, {
        --    pattern = "*",
        --    callback = function() vim.api.nvim_command('SSave!' .. GetUniqueSessionName()) end,
        --})

        vim.g.startify_lists = {
            { type = 'files',             header = { '   MRU' } },
            { type = 'dir',               header = { '   MRU ' .. vim.fn.getcwd() } },
            { type = 'sessions',          header = { '   Sessions' } },
            { type = 'bookmarks',         header = { '   Bookmarks' } },
            { type = gitModified(),       header = { '   git modified' } },
            { type = gitUntracked(),      header = { '   git untracked' } },
            { type = 'commands',          header = { '   Commands' } },
            { type = nerdtreeBookmarks(), header = { '   NERDTree Bookmarks' } }
        }

        --local header_cmd =  'fortune | cowsay -W 80 -f $(cowsay -l | sed "/[A-Z].*$/d" | shuf -n 1)'
        --vim.g.startify_custom_header = "startify#center(split(system(" .. header_cmd .. ")," .. "'\\n'".. "))"
    end
}
