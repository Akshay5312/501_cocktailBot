function X46 = decomPose(R)
    if norm(R - eye(3)) == 0
        X46 = [0;0;0];
    else
        
        w = null(R-eye(3));
        norm(w);

        %find random unit vector that is not w, -w
        randomVec = [1;0;0];
        while  (norm((randomVec - w))  < 0.2) || (norm((randomVec + w))  < 0.2)
        randomVec = rand(3,1);
        randomVec = randomVec/norm(randomVec);
        end
        %
        

        wperp1 = cross(randomVec, w);
        wperp2 = R*wperp1;

        %positive or negative theta? 
        CosTheta = max(min(dot(wperp1,wperp2)/(norm(wperp1)^2),1),-1);
        theta = real(acos(CosTheta));

        X46 = w*theta;
    end
end