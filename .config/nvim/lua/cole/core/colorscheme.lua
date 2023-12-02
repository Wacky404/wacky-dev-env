local status, _ = pcall(vim.cmd, "colorscheme nordic")
if not status then 
    print("Color Scheme not Found")
    return 
end
