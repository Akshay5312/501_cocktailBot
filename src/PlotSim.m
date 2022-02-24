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
            %X = [LinkPoints(1,1:2); LinkPoints(1,2:3);... Linkpoints(1,n-1:n)
            %Y = [LinkPoints(2,1:2); LinkPoints(2,2:3);... Linkpoints(2,n-1:n)
            %Z = [LinkPoints(3,1:2); LinkPoints(3,2:3);... Linkpoints(3,n-1:n)
            for n = 2:size(LinkPoints,2)
                X = [X;LinkPoints( 1, n-1:n)];
                Y = [Y;LinkPoints( 2, n-1:n)];
                Z = [Z;LinkPoints( 3, n-1:n)];
            end

            plot3(X,Y,Z)
            hold on
            plot3(X,Y,Z, 'o')
            hold off
            drawnow
        end
        

    end
end

