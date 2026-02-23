alias t="talosctl"

alias k="kubectl"
alias kg="kubectl get"

alias kctx="kubectx"
alias kns="kubens"

alias kgp="kubectl get pods"
alias kl="kubectl logs"
alias kgn="kubectl get no"
alias kdp="kubectl describe pod"
alias kge="kubectl get events"
alias ke="kubectl exec -it"
alias knsh="kubectl node-shell"

alias d="docker"
alias dps="docker ps"


alias f="flux"
alias fga="flux get all -A"

if uname -a | grep -q cachyos
    alias z="zeditor"
else
    alias z="~/.local/bin/zed"
end

alias g="gcloud"

alias tg="terragrunt"
alias tgp="terragrunt plan"
alias tga="terragrunt apply"

alias gc="git commit -am"
alias gp="git push"

alias ff="fastfetch"

alias ssh="kitten ssh"

alias v="neovim"
