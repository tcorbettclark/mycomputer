function fish_prompt
   set_color magenta
   printf '%s ' (hostname | cut -d . -f 1)
 
   set_color yellow
 
   set_color $fish_color_cwd
   printf '%s ' (prompt_pwd)

   set_color normal

   if set -q VIRTUAL_ENV; and not set -q PIPENV_ACTIVE
       printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
   end

   set_color normal
end
