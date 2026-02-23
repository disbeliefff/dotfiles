source ~/.config/fish/aliases/aliases.fish
{{#if isCachyOS}}
source /usr/share/cachyos-fish-config/cachyos-config.fish
{{/if}}

{{#if opencodePath}}
fish_add_path {{opencodePath}}
{{/if}}
