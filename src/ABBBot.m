classdef ABBBot
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ABBKinematics = kinematics.BotKinematics();
        
        %task space target
        target;

        %taskPos
        X;
        %joint pos
        Q;

        Qsize;
        %current Q set velocity
        Qdot;


        t0;
    end
    
    methods

        function self = ABBBot(initJoints)
            self.Q = initJoints;
            self.X = self.ABBKinematics.getState(self.Q);
            self.standStill();
            self.t0 = clock;


            self.Qsize = 6;
            %current Q set velocity
            self.Qdot = zeros(self.Qsize, 1);
        end

        function self = standStill(self)
            self.setTarget(self.X); 
        end
        
        function self = moveTowards(self, targetState, speed)
            if norm(targetState - self.X) < 0.2
                self.Qdot = zeros(self.Qsize, 1);
            else
                Xvel = (targetState - self.X) / norm(targetState - self.X)*speed;
                self.Qdot = self.ABBKinematics.IKJacobian(self.Q)*Xvel;
            end
        end

        function self = setTarget(self, TargettoGoTo)
            self.target = TargettoGoTo;
            %constVel = false;
        end

        %function self = setVelocity(self, TargVel)
         %   constVel = true;
            
        %end

        function self = runRealTime(self)
            self.runBot(etime(clock, self.t0));
        end

        function self = runBot(self, timeSinceLastRun)
            %5mm per second
            %can setup as PID later
            self.moveTowards(self.target, 5)
            %updateQ
            self.Q = self.Q+self.Qdot*timeSinceLastRun;

            %updateX
            self.X = self.ABBKinematics.getState(self.Q);
        end

        function F = getFrames(self)
            F = self.ABBKinematics.getFrames(self.Q);
        end

    end
end

