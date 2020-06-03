function ice-create-token
    ssh $argv[1] docker exec icecore pew in core icectl token --lifespan=1000000
end