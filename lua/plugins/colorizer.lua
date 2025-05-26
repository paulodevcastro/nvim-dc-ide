-- Plugin to put colors in css and others
return {
	"NvChad/nvim-colorizer.lua",
	ft = { "css", "scss", "html", "javascript", "typescript", "vue", "tsx", "jsx" },
	opts = {
		user_default_options = {
			names = true, -- colors name like 'red'
			rgb_fn = true, -- rgb(), rgba(), hsl() support.
			hsl_fn = true, -- i don't know, it's just on documentation
			css = true, -- enable for CSS files
			css_fn = true, -- functions of CSS like `rgb(0, 0, 0)` are supported
			tailwind = true,
		},
	},
}
