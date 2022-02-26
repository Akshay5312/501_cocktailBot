classdef ABBBot
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ABBKinematics = kinematics.BotKinematics();
        
        %taskPos
        X;
        %joint pos
        Q;
        %current Q set velocity
        Qdot = [0; 0; 0];

        currTraj;
        usingTraj = false;

    end
    
    methods
        function self = ABBBot(initJoints)
            self.Q = initJoints;
            self.X = self.ABBKinematics.getState(self.Q);
            self.standStill();
        end

        function self = standStill(self)
            self.currTraj = planner.Trajectory(self.Q, self.Q);
            self.usingTraj = true;
        end

        function self = moveTowards(self, targetState, speed)
            Xvel = (targetState - self.X) / norm(targetState - self.X)*speed
            self.Qdot = self.ABBKinematics.IKJacob(self.Q)*Xvel;
        end
        
        function self = run(self)
            %updateQ
            self.X = self.ABBKinematics.getState(self.Q);
        end
    end
end

