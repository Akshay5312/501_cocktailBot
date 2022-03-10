        %organized as 
        %         [d \theta a \alpha]
        DHtable = @(Q)...
            [475 Q(1) 0 0;...
            0 0 150 pi/2;...
            0 Q(2)+pi/2 600 0;...
            0 Q(3) 120 pi/2;...%cutoff for 3DOF
            720 Q(4) 0 pi/2;...
            0 Q(5) 0 -pi/2;...
            85 Q(6) 0 0 ];

        dhsize = 7;
        joints = 6;



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
               disp('FK for frame number ');
               disp(m-1);
                Frame{m};
           end
      
           FK = Frame{dhsize+1};
           FK = FK(1:3,4);
            
           syms q1 q2 q3 q4 q5 q6
           FK;
           FK = subs(FK, [q(1) q(2) q(3) q(4) q(5) q(6)], [q1 q2 q3 q4 q5 q6]);

           J = jacobian(FK, [q1 q2 q3 q4 q5 q6]);


           F1 = Frame{1};
           F3 = Frame{3};
           F4 = Frame{4};
           F5 = Frame{5};
           F6 = Frame{6};
           F7 = Frame{7};

           Jo = [F1(1:3,3) F3(1:3,3) F4(1:3,3) F5(1:3,3) F6(1:3,3) F7(1:3,3)];

           Jo = subs(Jo, [q(1) q(2) q(3) q(4) q(5) q(6)], [q1 q2 q3 q4 q5 q6]);
            
           j = [J;Jo];
            
           
           iJ = inv(j)
