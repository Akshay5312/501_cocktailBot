classdef ABBBot
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ABBKinematics = kinematics.BotKinematics();
        targetTaskPos
        TaskPos
        JointPos

    end
    
    methods
        function self = ABBBot(initJoints)
            JointPos = initJoints;

        end
        
        function run(self)
            self.ABBKinematics.getFK()
        end
    end
end

