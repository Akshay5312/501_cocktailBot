        %organized as 
        %         [d \theta a \alpha]
        DHtable = @(Q)...
            [475 Q(1) 150 pi/2;...
            0 Q(2)+pi/2 600 0;...
            0 Q(3) 120 -pi/2;...%cutoff for 3DOF
            720 Q(4) 0 pi/2;...
            0 Q(5) 0 -pi/2;...
            85 Q(6) 0 0 ];

        dhsize = 6;



        %%anonymous functions
            %for DH
            appPos = @(pos) [[eye(3) pos]; [0 0 0 1]];
            appRot = @(rot) [[rot [0;0;0]]; [0 0 0 1]];
            rDH = @(dtaal) appRot(rotz(dtaal(2)))*appPos([0;0;dtaal(1)])*appRot(rotx(dtaal(4)))*appPos([dtaal(3);0;0]);

           syms q(t)

           DHsolved = DHtable(q);
           Frame = cell(dhsize+1,1);
            Frame{1} = eye(4);
           for m = 2:dhsize+1
               Frame{m} =Frame{m-1} * rDH(DHsolved(m-1,:));
           end
            
           for m = 1:dhsize+1
               disp('FK for frame number ')
               disp(m-1)
                Frame{m}
           end
      

