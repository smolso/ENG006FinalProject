classdef game
    
    properties (Constant)
        
        %Channel writing numbers
        writeKeyTurn = 'NGW99VVOQPSVSISN';
        readKeyTurn = '5RYFWLGNF8I4GSQU';
        channelIDTurn = 1302152;
        
        writeKeyStatus = '5PMM9O7QNFYBH0OH';
        readKeyStatus = 'DCJX3N1VGVPW10I7';
        channelIDStatus = 1302961;
          
    end
    
    properties
        
        %Each game has a player class that contains the board and player
        %number. It also has the moves for the player that can happen.
        player;
        madeColorMove;
        madeWhiteMove;
        
    end
    
    methods
        
        %Constructor for the game class. Each game has a player and if the
        %player has made a move this turn.
        function obj = game()
            obj.player=player(obj);
            obj.madeColorMove=false;
            obj.madeWhiteMove=false;
        end
        
        %Function for when a specific key is pressed, takes the color press
        %and the position of the pressed key as well as if its the
        %player's turn.
        function obj = pressed(obj,color,position,playerTurn)
            
            %Gets the valid moves for the positions and then shifts them
            %because I'm too lazy to fix it, I think.
            [colorMoves,whiteMoves] = obj.getValidMoves(playerTurn);
            colorMoves=colorMoves-1;
            whiteMoves=whiteMoves-1;
            
            %Gets the  current values of the status channel so that it can
            %check if the rows are closed.
            status=thingSpeakRead(obj.channelIDStatus,'ReadKey',obj.readKeyStatus);
            
            %Code that checks if the move made is a valid move and then
            %makes the move if it is.
            switch color
                
                %Explanation will only be written for one chunck
                case "red"
                    %Checks to see if the rest row is open
                    if(~status(1))
                        %Checks if the move is a valid whitemove and a
                        %white move hasn't been made.
                        if(ismember(10+position,whiteMoves)&&~obj.madeWhiteMove)
                            %As long the position isn't the last one make
                            %the move.
                            if(position~=11)
                                obj.madeWhiteMove=true;
                                obj.player.board=obj.player.board.setValue(color,position);
                            else
                                %If the move is the last one, check if
                                %there is at least 5 numbers marked to
                                %allow for the last one to be marked.
                                total=obj.board.total("red");
                                if(total>=5)
                                    %If the last one in a row is marked,
                                    %then close the row.
                                    obj.madeWhiteMove=true;
                                    obj.player.board=obj.player.board.setValue(color,position);
                                    status(1)=1;
                                    thingSpeakWrite(obj.channelIDStatus,status,'WriteKey',obj.writeKeyStatus);
                                end
                            end
                        elseif(ismember(10+position,colorMoves))
                            %Do the same thing as before but with the color
                            %move instead. See above explanation
                            if(position~=11)
                                obj.madeColorMove=true;
                                obj.player.board=obj.player.board.setValue(color,position);
                            else
                                total=obj.board.total("red");
                                if(total>=5)
                                    obj.madeColorMove=true;
                                    obj.player.board=obj.player.board.setValue(color,position);
                                    status(1)=1;
                                    thingSpeakWrite(obj.channelIDStatus,status,'WriteKey',obj.writeKeyStatus);
                                end
                            end
                        end
                    end
                case "yellow"
                    if(~status(2))
                        if(ismember(10+position,whiteMoves)&&~obj.madeWhiteMove)
                            if(postion~=11)
                                obj.madeWhiteMove=true;
                                obj.player.board=obj.player.board.setValue(color,position);
                            else
                                total=obj.board.total("yellow");
                                if(total>=5)
                                    obj.madeWhiteMove=true;
                                    obj.player.board=obj.player.board.setValue(color,position);
                                    status(2)=1;
                                    thingSpeakWrite(obj.channelIDStatus,status,'WriteKey',obj.writeKeyStatus);
                                end
                            end
                        elseif(ismember(20+position,colorMoves))
                            if(position~=11)
                                obj.madeColorMove=true;
                                obj.player.board=obj.player.board.setValue(color,position);
                            else
                                total=obj.board.total("yellow");
                                if(total>=5)
                                    obj.madeColorMove=true;
                                    obj.player.board=obj.player.board.setValue(color,position);
                                    status(2)=1;
                                    thingSpeakWrite(obj.channelIDStatus,status,'WriteKey',obj.writeKeyStatus);
                                end
                            end
                        end
                    end
                case "blue"
                    if(~status(3))
                        if(ismember(10+position,whiteMoves)&&~obj.madeWhiteMove)
                            if(position~=11)
                                obj.madeWhiteMove=true;
                                obj.player.board=obj.player.board.setValue(color,position);
                            else
                                total=obj.board.total("blue");
                                if(total>=5)
                                    obj.madeWhiteMove=true;
                                    obj.player.board=obj.player.board.setValue(color,position);
                                    status(3)=1;
                                    thingSpeakWrite(obj.channelIDStatus,status,'WriteKey',obj.writeKeyStatus);
                                end
                            end
                        elseif(ismember(30+position,colorMoves))
                            if(position~=11)
                                obj.madeColorMove=true;
                                obj.player.board=obj.player.board.setValue(color,position);
                            else
                                total=obj.board.total("blue");
                                if(total>=5)
                                    obj.madeColorMove=true;
                                    obj.player.board=obj.player.board.setValue(color,position);
                                    status(3)=1;
                                    thingSpeakWrite(obj.channelIDStatus,status,'WriteKey',obj.writeKeyStatus);
                                end
                            end
                        end
                    end
                case "green"
                    if(~status(4))
                        if(ismember(10+position,whiteMoves)&&~obj.madeWhiteMove)
                            if(position~=11)
                                obj.madeWhiteMove=true;
                                obj.player.board=obj.player.board.setValue(color,position);
                            else
                                total=obj.board.total("green");
                                if(total>=5)
                                    obj.madeWhiteMove=true;
                                    obj.player.board=obj.player.board.setValue(color,position);
                                    status(4)=1;
                                    thingSpeakWrite(obj.channelIDStatus,status,'WriteKey',obj.writeKeyStatus);
                                end
                            end
                        elseif(ismember(40+position,colorMoves))
                            if(position~=11)
                                obj.madeColorMove=true;
                                obj.player.board=obj.player.board.setValue(color,position);
                            else
                                total=obj.board.total("green");
                                if(total>=5)
                                    obj.madeColorMove=true;
                                    obj.player.board=obj.player.board.setValue(color,position);
                                    status(4)=1;
                                    thingSpeakWrite(obj.channelIDStatus,status,'WriteKey',obj.writeKeyStatus);
                                end
                            end
                        end
                    end
            end
        end
        
        %If the player hasn't made a move, see if said move is a valid move
        function obj = makeMove(obj,color,position)
            %This improves processing time by stopping the computer from
            %getting a move if the player can't make a move.
            temp=obj.getCurrentTurn();
            if((~obj.madeWhiteMove||temp==obj.player.playerTurn)&&~obj.madeColorMove)
                obj=obj.pressed(color,position,temp==obj.player.playerTurn);
            end
        end
        
        %Gets the current turn from thingspeak.
        function playerTurn = getCurrentTurn(obj)
            var = obj.getCurrentValuesT();
            playerTurn=var(7);
        end
        
        %Function that finds all of the valid moves.
        function [colorMoves,whiteMoves] = getValidMoves(obj,playerTurn)
            
            %Initialize necessary variables for calculations
            whiteMoves=[];
            colorMoves=[];
            dice = obj.getCurrentValuesT();
            total = dice(5)+dice(6);
            %The below code chunk need to be checked to make sure it works
            %as intended. 
            %This finds the last indice of the rows, you cant put a value
            %to the left of said number.
            maxValues=[find(obj.player.board.red,'last')+1,find(obj.player.board.yellow,'last')+1,find(obj.player.board.green,'last')+1,find(obj.player.board.blue,'last')+1];
            
            %If its the player turn they have extra possible moves that the
            %player can do.
            if(playerTurn)
                
                %This code needs to be checked that it functions as
                %intened.
                %This code goes through the possible dice combinations and
                %checks to see if they are greater than the the last number
                %marked in that row.
                colorValues=[[dice(1)+dice(5),dice(1)+dice(6)],[dice(2)+dice(5),dice(2)+dice(6)],[-1*(dice(3)+dice(5))+14,-1*(dice(3)+dice(6))+14],[-1*(dice(4)+dice(5))+14,-1*(dice(4)+dice(6))+14]];
                for(i=1:1:length(maxValues))
                    for(j=1:1:2)
                        if(maxValues(i)<colorValues(j+i*2-2))
                            colorMoves=[colorMoves,i*10+colorValues(j+i*2-2)];
                        end
                    end
                end
            end
            
            %Generalized move list for all players
            for (i=1:1:length(maxValues))
                if(total>maxValues(i))
                    whiteMoves=[whiteMoves,i*10+total];
                end
            end
        end
        
        %This is the function for moving to the next turn
        function obj = newTurn(obj)
            %Checks if it is currently the players turn
            currentTurn=getCurrentValuesT();
            if(obj.player.playerTurn==currentTurn(7))
                %If its the players turn and they didn't make a move, add a
                %penalty
                if(~obj.madeColorMove||~obj.madeWhiteMove)
                    obj.player.board.incrementPenalties();
                end
                currentPlayers=getCurrentValuesS();
                %Tells the game whos turn it is next
                if(obj.player.playerTurn==currentPlayers(6))
                    newTurn=1;
                else
                    newTurn=currentTurn(7)+1;
                end
                %Checks if the end conditions of the game have been met
                if(obj.player.board.totalPenalties==4||sum(currentPlayers(1:4)>=2))
                    thingSpeakWrite(obj.channelIDStatus,[currentPlayers(1:4),0,currentPlayers(6)],'WriteKey',obj.writeKeyStatus);
                end
                %Writes the new dice numbers and turn to the thingspeak
                %array
                thingSpeakWrite(obj.channelIDTurn,[randi(6,1,6),newTurn],'WriteKey',obj.writeKeyTurn);
            end
            %Runs the general start turn function for all players
            startTurn();
        end
        
        function obj = startTurn(obj)
            %Waits a bit to let code run to end game
            pause(10);
            temp=getCurrentValuesS();
            %If the game is over, run the function to end the game.
            if(temp(5)==0)
                endGame();
                return;
            end
            %Sets the moves amde to be false for a new turn.
            obj.madeWhiteMove=false;
            obj.madeColorMove=false;
        end
        
        %Function that runs at the end of the game. Unknown what features
        %are wanted in it yet.
        function obj = endGame(obj)
            
        end
    end
    methods (Static)
        
        %Get the current values stored in the turn channel
        function currentValsTurns = getCurrentValuesT()
            currentValsTurns = thingSpeakRead(game.channelIDTurn,'Readkey',game.readKeyTurn);
        end
        
        %Get the current values stored in the status channel
        function currentValsStatus = getCurrentValuesS()
            currentValsStatus = thingSpeakRead(game.channelIDStatus,'Readkey',game.readKeyStatus);
        end
        
    end
end