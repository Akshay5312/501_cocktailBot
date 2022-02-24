classdef BotKinematics
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties

        GroundToOne = eye(4);

        %organized as 
        %         [d \theta a \alpha]
        DHtable = @(Q)...
            [5 Q(1) 0 pi/2;...
            0 Q(2) 5 0;...
            0 Q(3) 5 0];

        Links = 3;


        %%anonymous functions
            %for DH
            appPos = @(pos) [[eye(3) pos]; [0 0 0 1]];
            appRot = @(rot) [[rot [0;0;0]]; [0 0 0 1]]; 
            rDH;
            
    end
    
    methods
        function self = BotKinematics()
          
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %FK functions
        function R = botFK(self,Q)

        end

        function F = getFrame(self,Q, index)
            Fr = getFrames(Q);
            F = Fr{index+1};
        end

        function Frames = getFrames(self, q)
            Frames = cell(7,1);

            Frames{1} =   [   1     0     0     0;     0     1     0     0;     0     0     1     0;     0     0     0     1];
            
            Frames{2} = ...
                [[cos(q(1)), -sin(q(1)), 0,   0];...
                [sin(q(1)),  cos(q(1)), 0,   0];...
                [        0,          0, 1, 475];...
                [        0,          0, 0,   1]];

            Frames{3} =  ...  
                [[cos(q(1)), 0,  sin(q(1)), 150*cos(q(1))];...
                [sin(q(1)), 0, -cos(q(1)), 150*sin(q(1))];...
                [        0, 1,          0,           475];...
                [        0, 0,          0,             1]];


            
            Frames{4} = ...
                [[cos(q(1))*cos(pi/2 + q(2)), -cos(q(1))*sin(pi/2 + q(2)),  sin(q(1)), 150*cos(q(1)) + 600*cos(q(1))*cos(pi/2 + q(2))];...
                [cos(pi/2 + q(2))*sin(q(1)), -sin(q(1))*sin(pi/2 + q(2)), -cos(q(1)), 150*sin(q(1)) + 600*cos(pi/2 + q(2))*sin(q(1))];...
                [          sin(pi/2 + q(2)),            cos(pi/2 + q(2)),          0,                     600*sin(pi/2 + q(2)) + 475];...
                [                         0,                           0,          0,                                              1]];

            Frames{5} =  ...   
                [[cos(q(1))*cos(q(3))*cos(pi/2 + q(2)) - cos(q(1))*sin(q(3))*sin(pi/2 + q(2)),  sin(q(1)), cos(q(1))*cos(q(3))*sin(pi/2 + q(2)) + cos(q(1))*cos(pi/2 + q(2))*sin(q(3)), 150*cos(q(1)) + 600*cos(q(1))*cos(pi/2 + q(2)) - 120*cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) + 120*cos(q(1))*cos(q(3))*cos(pi/2 + q(2))];...
                [cos(q(3))*cos(pi/2 + q(2))*sin(q(1)) - sin(q(1))*sin(q(3))*sin(pi/2 + q(2)), -cos(q(1)), cos(q(3))*sin(q(1))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(1))*sin(q(3)), 150*sin(q(1)) + 600*cos(pi/2 + q(2))*sin(q(1)) - 120*sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) + 120*cos(q(3))*cos(pi/2 + q(2))*sin(q(1))];...
                [                    cos(q(3))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(3)),          0,                     sin(q(3))*sin(pi/2 + q(2)) - cos(q(3))*cos(pi/2 + q(2)),                                         600*sin(pi/2 + q(2)) + 120*cos(q(3))*sin(pi/2 + q(2)) + 120*cos(pi/2 + q(2))*sin(q(3)) + 475];...
                [                                                                          0,          0,                                                                           0,                                                                                                                                    1]];
                 
            
            Frames{6} =  ...
                [[  sin(q(1))*sin(q(4)) - cos(q(4))*(cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(1))*cos(q(3))*cos(pi/2 + q(2))), cos(q(1))*cos(q(3))*sin(pi/2 + q(2)) + cos(q(1))*cos(pi/2 + q(2))*sin(q(3)), - cos(q(4))*sin(q(1)) - sin(q(4))*(cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(1))*cos(q(3))*cos(pi/2 + q(2))), 150*cos(q(1)) + 600*cos(q(1))*cos(pi/2 + q(2)) - 120*cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) + 120*cos(q(1))*cos(q(3))*cos(pi/2 + q(2)) + 720*cos(q(1))*cos(q(3))*sin(pi/2 + q(2)) + 720*cos(q(1))*cos(pi/2 + q(2))*sin(q(3))];...
                [- cos(q(1))*sin(q(4)) - cos(q(4))*(sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(3))*cos(pi/2 + q(2))*sin(q(1))), cos(q(3))*sin(q(1))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(1))*sin(q(3)),   cos(q(1))*cos(q(4)) - sin(q(4))*(sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(3))*cos(pi/2 + q(2))*sin(q(1))), 150*sin(q(1)) + 600*cos(pi/2 + q(2))*sin(q(1)) + 720*cos(q(3))*sin(q(1))*sin(pi/2 + q(2)) + 720*cos(pi/2 + q(2))*sin(q(1))*sin(q(3)) - 120*sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) + 120*cos(q(3))*cos(pi/2 + q(2))*sin(q(1))];...
                [                                            cos(q(4))*(cos(q(3))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(3))),                     sin(q(3))*sin(pi/2 + q(2)) - cos(q(3))*cos(pi/2 + q(2)),                                             sin(q(4))*(cos(q(3))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(3))),                                                             600*sin(pi/2 + q(2)) - 720*cos(q(3))*cos(pi/2 + q(2)) + 120*cos(q(3))*sin(pi/2 + q(2)) + 120*cos(pi/2 + q(2))*sin(q(3)) + 720*sin(q(3))*sin(pi/2 + q(2)) + 475];...
                [                                                                                                              0,                                                                           0,                                                                                                               0,                                                                                                                                                                                                                          1]];
                 
            Frames{7} =  ...
                [[cos(q(5))*(sin(q(1))*sin(q(4)) - cos(q(4))*(cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(1))*cos(q(3))*cos(pi/2 + q(2)))) + sin(q(5))*(cos(q(1))*cos(q(3))*sin(pi/2 + q(2)) + cos(q(1))*cos(pi/2 + q(2))*sin(q(3))), cos(q(4))*sin(q(1)) + sin(q(4))*(cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(1))*cos(q(3))*cos(pi/2 + q(2))), cos(q(5))*(cos(q(1))*cos(q(3))*sin(pi/2 + q(2)) + cos(q(1))*cos(pi/2 + q(2))*sin(q(3))) - sin(q(5))*(sin(q(1))*sin(q(4)) - cos(q(4))*(cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(1))*cos(q(3))*cos(pi/2 + q(2)))), 150*cos(q(1)) + 600*cos(q(1))*cos(pi/2 + q(2)) - 120*cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) + 120*cos(q(1))*cos(q(3))*cos(pi/2 + q(2)) + 720*cos(q(1))*cos(q(3))*sin(pi/2 + q(2)) + 720*cos(q(1))*cos(pi/2 + q(2))*sin(q(3))];...
                [sin(q(5))*(cos(q(3))*sin(q(1))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(1))*sin(q(3))) - cos(q(5))*(cos(q(1))*sin(q(4)) + cos(q(4))*(sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(3))*cos(pi/2 + q(2))*sin(q(1)))), sin(q(4))*(sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(3))*cos(pi/2 + q(2))*sin(q(1))) - cos(q(1))*cos(q(4)), sin(q(5))*(cos(q(1))*sin(q(4)) + cos(q(4))*(sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(3))*cos(pi/2 + q(2))*sin(q(1)))) + cos(q(5))*(cos(q(3))*sin(q(1))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(1))*sin(q(3))), 150*sin(q(1)) + 600*cos(pi/2 + q(2))*sin(q(1)) + 720*cos(q(3))*sin(q(1))*sin(pi/2 + q(2)) + 720*cos(pi/2 + q(2))*sin(q(1))*sin(q(3)) - 120*sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) + 120*cos(q(3))*cos(pi/2 + q(2))*sin(q(1))];...
                [                                                                cos(q(4))*cos(q(5))*(cos(q(3))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(3))) - sin(q(5))*(cos(q(3))*cos(pi/2 + q(2)) - sin(q(3))*sin(pi/2 + q(2))),                                          -sin(q(4))*(cos(q(3))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(3))),                                                               - cos(q(5))*(cos(q(3))*cos(pi/2 + q(2)) - sin(q(3))*sin(pi/2 + q(2))) - cos(q(4))*sin(q(5))*(cos(q(3))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(3))),                                                             600*sin(pi/2 + q(2)) - 720*cos(q(3))*cos(pi/2 + q(2)) + 120*cos(q(3))*sin(pi/2 + q(2)) + 120*cos(pi/2 + q(2))*sin(q(3)) + 720*sin(q(3))*sin(pi/2 + q(2)) + 475];...
                [                                                                                                                                                                                                                  0,                                                                                                             0,                                                                                                                                                                                                                   0,                                                                                                                                                                                                                          1]];
                 


            Frames{8} =  ...   
                [[  sin(q(6))*(cos(q(4))*sin(q(1)) + sin(q(4))*(cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(1))*cos(q(3))*cos(pi/2 + q(2)))) + cos(q(6))*(cos(q(5))*(sin(q(1))*sin(q(4)) - cos(q(4))*(cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(1))*cos(q(3))*cos(pi/2 + q(2)))) + sin(q(5))*(cos(q(1))*cos(q(3))*sin(pi/2 + q(2)) + cos(q(1))*cos(pi/2 + q(2))*sin(q(3)))), cos(q(6))*(cos(q(4))*sin(q(1)) + sin(q(4))*(cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(1))*cos(q(3))*cos(pi/2 + q(2)))) - sin(q(6))*(cos(q(5))*(sin(q(1))*sin(q(4)) - cos(q(4))*(cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(1))*cos(q(3))*cos(pi/2 + q(2)))) + sin(q(5))*(cos(q(1))*cos(q(3))*sin(pi/2 + q(2)) + cos(q(1))*cos(pi/2 + q(2))*sin(q(3)))), cos(q(5))*(cos(q(1))*cos(q(3))*sin(pi/2 + q(2)) + cos(q(1))*cos(pi/2 + q(2))*sin(q(3))) - sin(q(5))*(sin(q(1))*sin(q(4)) - cos(q(4))*(cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(1))*cos(q(3))*cos(pi/2 + q(2)))), 150*cos(q(1)) + 600*cos(q(1))*cos(pi/2 + q(2)) - 85*sin(q(5))*(sin(q(1))*sin(q(4)) - cos(q(4))*(cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(1))*cos(q(3))*cos(pi/2 + q(2)))) + 85*cos(q(5))*(cos(q(1))*cos(q(3))*sin(pi/2 + q(2)) + cos(q(1))*cos(pi/2 + q(2))*sin(q(3))) - 120*cos(q(1))*sin(q(3))*sin(pi/2 + q(2)) + 120*cos(q(1))*cos(q(3))*cos(pi/2 + q(2)) + 720*cos(q(1))*cos(q(3))*sin(pi/2 + q(2)) + 720*cos(q(1))*cos(pi/2 + q(2))*sin(q(3))];...
                [- sin(q(6))*(cos(q(1))*cos(q(4)) - sin(q(4))*(sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(3))*cos(pi/2 + q(2))*sin(q(1)))) - cos(q(6))*(cos(q(5))*(cos(q(1))*sin(q(4)) + cos(q(4))*(sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(3))*cos(pi/2 + q(2))*sin(q(1)))) - sin(q(5))*(cos(q(3))*sin(q(1))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(1))*sin(q(3)))), sin(q(6))*(cos(q(5))*(cos(q(1))*sin(q(4)) + cos(q(4))*(sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(3))*cos(pi/2 + q(2))*sin(q(1)))) - sin(q(5))*(cos(q(3))*sin(q(1))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(1))*sin(q(3)))) - cos(q(6))*(cos(q(1))*cos(q(4)) - sin(q(4))*(sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(3))*cos(pi/2 + q(2))*sin(q(1)))), sin(q(5))*(cos(q(1))*sin(q(4)) + cos(q(4))*(sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(3))*cos(pi/2 + q(2))*sin(q(1)))) + cos(q(5))*(cos(q(3))*sin(q(1))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(1))*sin(q(3))), 150*sin(q(1)) + 600*cos(pi/2 + q(2))*sin(q(1)) + 85*sin(q(5))*(cos(q(1))*sin(q(4)) + cos(q(4))*(sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) - cos(q(3))*cos(pi/2 + q(2))*sin(q(1)))) + 85*cos(q(5))*(cos(q(3))*sin(q(1))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(1))*sin(q(3))) + 720*cos(q(3))*sin(q(1))*sin(pi/2 + q(2)) + 720*cos(pi/2 + q(2))*sin(q(1))*sin(q(3)) - 120*sin(q(1))*sin(q(3))*sin(pi/2 + q(2)) + 120*cos(q(3))*cos(pi/2 + q(2))*sin(q(1))];...
                [                                                                                                            - cos(q(6))*(sin(q(5))*(cos(q(3))*cos(pi/2 + q(2)) - sin(q(3))*sin(pi/2 + q(2))) - cos(q(4))*cos(q(5))*(cos(q(3))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(3)))) - sin(q(4))*sin(q(6))*(cos(q(3))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(3))),                                                                                                             sin(q(6))*(sin(q(5))*(cos(q(3))*cos(pi/2 + q(2)) - sin(q(3))*sin(pi/2 + q(2))) - cos(q(4))*cos(q(5))*(cos(q(3))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(3)))) - cos(q(6))*sin(q(4))*(cos(q(3))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(3))),                                                               - cos(q(5))*(cos(q(3))*cos(pi/2 + q(2)) - sin(q(3))*sin(pi/2 + q(2))) - cos(q(4))*sin(q(5))*(cos(q(3))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(3))),                                                                                                                             600*sin(pi/2 + q(2)) - 720*cos(q(3))*cos(pi/2 + q(2)) + 120*cos(q(3))*sin(pi/2 + q(2)) + 120*cos(pi/2 + q(2))*sin(q(3)) + 720*sin(q(3))*sin(pi/2 + q(2)) - 85*cos(q(5))*(cos(q(3))*cos(pi/2 + q(2)) - sin(q(3))*sin(pi/2 + q(2))) - 85*cos(q(4))*sin(q(5))*(cos(q(3))*sin(pi/2 + q(2)) + cos(pi/2 + q(2))*sin(q(3))) + 475];...
                [                                                                                                                                                                                                                                                                                                                                                            0,                                                                                                                                                                                                                                                                                                                                                           0,                                                                                                                                                                                                                   0,                                                                                                                                                                                                                                                                                                                                                                                                                                                      1]];
                 
        end

        %function Jacobian
        %end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %IK functions


    end
end

