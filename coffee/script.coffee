jQuery(document).ready ->

    distance = "30px"

    up = bottom: "+=" + distance
    down = bottom: "-=" + distance
    left = left: "-=" + distance
    right = left: "+=" + distance

    movement =
        # W
        87:
            bot:
                forward: 0.3
            rotation: 
                0: up
                90: right
                180: down
                270: left
        # S
        83: 
            bot:
                forward: -0.3
            rotation: 
                0: down
                90: left
                180: up
                270: right
        # A
        65: 
            bot: 
                strafe: -1
            rotation: 
                0: left
                90: up
                180: right
                270: down
        # D
        68: 
            bot: 
                strafe: 1
            rotation: 
                0: right
                90: down
                180: left
                270: up
        # <-
        37: 
            bot:
                turn: -1
            turn: ->
                currentRot -= 90
                $('#testcar').css( "transform": "rotate(#{currentRot}deg)" )
        # ->
        39: 
            bot:
                turn: 1
            turn: ->
                currentRot += 90
                $('#testcar').css( "transform": "rotate(#{currentRot}deg)" )

    url = "http://localhost:8071/motion-control/update"
    # urlBot = "http://192.168.0.105:8071/motion-control/update"

    currentRot = 0

    storePos = (currentRot) ->
        if (currentRot < 0) && (currentRot % 360 != 0)
            (currentRot % 360) + 360
        else
            currentRot % 360


    $(document).keydown (keyObject) ->
        key = parseInt(keyObject.which, 10)
        direction = storePos(currentRot)
        reset = ->
            $.ajax url, dataType: "jsonp", data: strafe: 0
            # $.ajax url, dataType: "jsonp", data: turn: 0
            # $.ajax url, dataType: "jsonp", data: forward: 0
        unless movement[key] == null
            if key != 37 && key != 39
                $('#testcar').animate(movement[key].rotation[direction], 100)
            else
                movement[key].turn()
            $.ajax(url, dataType: "jsonp", data: movement[key].bot)
            setTimeout ->
                reset()
            , 1000



















