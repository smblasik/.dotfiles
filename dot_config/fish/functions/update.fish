function update --wraps='sudo cachyos-rate-mirrors && sudo pacman -Syu' --wraps='sudo pacman -Syu' --description 'alias update=sudo pacman -Syu'
    sudo pacman -Syu $argv
end
