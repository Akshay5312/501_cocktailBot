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
        getFrame


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
           R = self.getFrame(Q, self.Links+1)
        end

        function R = setFrame(self, index)
            syms Q(t);
            R = self.GroundToOne;
            DH = self.DHtable(Q)
            for m = 1:index-1
                R = R*self.rDH(DH(m,:))
            end
            if index == 0
                R = eye(4);
            end
            R = matlabFunction(R)
        end

        function Jacobian
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %IK functions


    end
end

