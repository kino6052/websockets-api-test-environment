<!DOCTYPE html>
<html>
<head>
    <title>WEBSOCKETS TEST</title>
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.1/css/bootstrap.min.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.1/js/bootstrap.min.js"></script>
</head>
<body>
<div id="container">
    <h1>WEBSOCKETS TEST</h1>
    <ul id="ul">
        <li id="li"><span class="time"></span> <span class="msg"></span></li>
    </ul>
</div>
<script type="text/javascript" language="javascript">
    var move;
    $(document).ready(function() {
        if(!("WebSocket" in window))
        {
            console.log('WebSockets are not supported in this ' +
                    'browser. Try Internet Explorer 10 or the latest ' +
                    'versions of Mozilla Firefox or Google Chrome.');
            return;
        }

        console.log('Connecting to the server.');

        var server;
        try {
            server = new WebSocket('ws://' + window.location.host + '<c:url value="/ticTacToe"></c:url>');
        } catch(error) {
            console.warn(error);
            return;
        }

        server.onopen = function(event) {
            //                    modalWaitingBody
            //                            .text('Waiting on your opponent to join the game.');
            //                    modalWaiting.modal({ keyboard: false, show: true });
        };

        window.onbeforeunload = function() {
            //                    server.close();
        };

        server.onclose = function(event) {
            //                    if(!event.wasClean || event.code != 1000) {
            //                        toggleTurn(false, 'Game over due to error!');
            //                        modalWaiting.modal('hide');
            //                        modalErrorBody.text('Code ' + event.code + ': ' +
            //                                event.reason);
            //                        modalError.modal('show');
            //                    }
        };

        server.onerror = function(event) {
            //                    modalWaiting.modal('hide');
            //                    modalErrorBody.text(event.data);
            //                    modalError.modal('show');
        };

        server.onmessage = function(event) {
            var message = event.data;
            var time = new Date;
            var clientTime = time.getHours() + ":" + time.getMinutes() + ":" + time.getSeconds() + ":" + time.getMilliseconds();
            console.log(message, clientTime);
            var $ul = $("#ul");
            var $li = $("#li").clone();
            $li.find(".time").html(message);
            $li.find(".msg").html(clientTime);
            $ul.append($li);

            //                    if(message.action == 'gameStarted') {
            //                        if(message.game.player1 == username)
            //                            opponentUsername = message.game.player2;
            //                        else
            //                            opponentUsername = message.game.player1;
            //                        opponent.text(opponentUsername);
            //                        toggleTurn(message.game.nextMoveBy == username);
            //                        modalWaiting.modal('hide');
            //                    } else if(message.action == 'opponentMadeMove') {
            //                        $('#r' + message.move.row + 'c' + message.move.column)
            //                                .unbind('click')
            //                                .removeClass('game-cell-selectable')
            //                                .addClass('game-cell-opponent game-cell-taken');
            //                        toggleTurn(true);
            //                    } else if(message.action == 'gameOver') {
            //                        toggleTurn(false, 'Game Over!');
            //                        if(message.winner) {
            //                            modalGameOverBody.text('Congratulations, you won!');
            //                        } else {
            //                            modalGameOverBody.text('User "' + opponentUsername +
            //                                    '" won the game.');
            //                        }
            //                        modalGameOver.modal('show');
            //                    } else if(message.action == 'gameIsDraw') {
            //                        toggleTurn(false, 'The game is a draw. ' +
            //                                'There is no winner.');
            //                        modalGameOverBody.text('The game ended in a draw. ' +
            //                                'Nobody wins!');
            //                        modalGameOver.modal('show');
            //                    } else if(message.action == 'gameForfeited') {
            //                        toggleTurn(false, 'Your opponent forfeited!');
            //                        modalGameOverBody.text('User "' + opponentUsername +
            //                                '" forfeited the game. You win!');
            //                        modalGameOver.modal('show');
            //                    }
        };
    });
</script>
</body>
</html>
