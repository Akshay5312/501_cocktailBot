classdef PlotSim
    %THREEDPLOTSIM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods
        function obj = PlotSim()
        end
        
        %LinkPoints as 
        %[ground, link1 origin, link 2 origin,...end effector]
        %each point is a column vector
        function obj = plot(obj,LinkPoints)
            X = zeros(0,2);
            Y = zeros(0,2);
            Z = zeros(0,2);
            %X = [LinkPoints(1:2,1); LinkPoints(2:3,1); Linkpoints(n-1:n,1)
            %Y = [LinkPoints(1:2,2); LinkPoints(2:3,2); Linkpoints(n-1:n,2)
            %Z = [LinkPoints(1:2,3); LinkPoints(2:3,3); Linkpoints(n-1:n,3)
            for n = 2:size(LinkPoints,2)
                X = [X;LinkPoints(n-1:n, 1)];
                Y = [Y;LinkPoints(n-1:n, 2)];
                Z = [Z;LinkPoints(n-1:n, 3)];
            end

            plot3(X,Y,Z)
            drawnow
        end
        

    end
end

