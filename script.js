$(document).ready(function() {

    var distance = "30px";

    var up = {bottom: "+=" + distance};
    var down = {bottom: "-=" + distance};
    var left = {left: "-=" + distance};
    var right = {left: "+=" + distance};

    var movement = {
        // W
        87: {
            bot: {forward: 1},
            rotation: {
                0: up,
                90: right,
                180: down,
                270: left
            }
        },

        // S
        83: {
            bot: {forward: -1},
            rotation: {
                0: down,
                90: left,
                180: up,
                270: right
            }
        },

        // A
        65: {
            bot: {strafe: -1},
            rotation: {
                0: left,
                90: up,
                180: right,
                270: down
            }
        },

        // D
        68: {
            bot: {strafe: 1},
            rotation: {
                0: right,
                90: down,
                180: left,
                270: up
            }
        },

        // <-
        37: {
            bot: {turn: -1},
            turn: function() {
                 currentRot -= 90;
                 $('#testcar').css({ 'transform':'rotate(' + currentRot + 'deg)' });
            }
        },

        // ->
        39: {
            bot: {turn: 1},
            turn: function() {
                 currentRot += 90;
                 $('#testcar').css({ 'transform':'rotate(' + currentRot + 'deg)' });
            }
        }
    }

	var url = "http://localhost:8071/motion-control/update";

	var currentRot = 0;

	var storePos = function(currentRot) {
		if ((currentRot < 0) && (currentRot % 360 !== 0)) 
			return (currentRot % 360) + 360;
		else
			return currentRot % 360;
	}

	$(document).keydown(function(keyObject){
        var key = parseInt(keyObject.which, 10);
        var direction = storePos(currentRot);
        if (key !== 37 && key !== 39)
            $('#testcar').animate(movement[key].rotation[direction], 100);
        else
            movement[key].turn();
        $.ajax(url, { dataType: "jsonp", data: (movement[key].bot) });
    });

});
