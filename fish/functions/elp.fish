# Defined in - @ line 1
function elp --wraps='ENCAPSIA_HOST=localhost encapsia plugins' --description 'alias ep ENCAPSIA_HOST=localhost encapsia plugins'
  ENCAPSIA_HOST=localhost encapsia plugins $argv;
end
