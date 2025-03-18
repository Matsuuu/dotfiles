return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
        user_default_options = {
            tailwind = "both",
            tailwind_opts = {
                update_names = true
            },

            rgb_fn = true,
            hsl_fn = true,

            mode = "virtualtext",
            virtualtext_inline = true
        }
    },
}
