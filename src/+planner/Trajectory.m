classdef Trajectory
    properties
        cofMatrix;
        t0;
        endTime;
        StateSize;
    end

    methods
        %%%%%% initialize with initial and final state as
        %%%%%% [[Position][velocity]]
        function self = Trajectory(initState, finalState, dt)
            self.t0 = clock;
            self.endTime = dt;
            self.StateSize = size(finalState,2);
            self.cofMatrix = zeros(0, 2*self.StateSize);

            %initState
            if self.StateSize == 1
                    initState = [initState zeros(size(initState,1), 1)];
                    finalState = [finalState zeros(size(initState,1), 1)];
                    self.StateSize = 2;
                    self.cofMatrix = zeros(0, 2*self.StateSize);
            end
            
            for m = 1:size(initState,1)
                
                if self.StateSize == 2


                    %'hello world doing cubic'

                    self.cofMatrix = [self.cofMatrix; self.cubicCofs(initState(m,:), finalState(m,:), dt)];
                end
                if self.StateSize == 3
                    self.cofMatrix = [self.cofMatrix; self.quinticCofs(initState(m,:), finalState(m,:), dt)];
                end
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function A = cubicCofs(self,X1V1a,X2V2a,dt)
            %X(1) = position
            %X(2) = velocity

            a0 = X1V1a(1);
            a1 = X1V1a(2);

            Sol = [ X2V2a(2) - a1; X2V2a(1) - a1 - a0];
            T = [ 3*dt^2 2*dt; dt^3 dt^2];

            A32 = (inv(T)*Sol)';

            A = [A32 a1 a0];
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function A = quinticCofs(self,X1V1A1a,X2V2A2a,dt)
            %to be implemented
            dtp = [dt dt^2 dt^3 dt^4 dt^5];

            avf = [X1V1A1a';X2V2A2a'];

            T = [ 1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 2 0 0 0;...
                1 dtp(1) dtp(2) dtp(3) dtp(4) dtp(5);...
                0 1 2*dtp(1) 3*dtp(2) 4*dtp(3) 5*dtp(4);...
                0 0 2 6*dtp(1) 12*dtp(2) 20*dtp(3);...
                ];

            A = (inv(T)*avf);
            A = [A(6) A(5) A(4) A(3) A(2) A(1)];
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function x = getPointAtT(self, t)
            T = zeros(0,0);
            for m = 0 : (size(self.cofMatrix,2)-1)
                T = [t^m;T];
            end
            self.cofMatrix;
            x = self.cofMatrix*T;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function x = isDone(self)
            x = etime(clock, self.t0) > self.endTime;
        end

        function x = getPoint(self)
            self.t0;
            clock;
            if self.isDone()
                x = self.getPointAtT(self.endTime);
            else
                x = self.getPointAtT(etime(clock, self.t0));
            end
        end

    end

end

