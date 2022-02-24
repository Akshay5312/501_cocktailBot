K = BotKinematics();
Q = [0 0 0 0 0 0];
%K.getFK([0 0 0])

Fr = K.getFrames(Q)
LinkPoints = zeros(3,8)

for m = 1:8
    Frame = Fr{m}
    LinkPoints(:,m) = Frame(1:3,4)
end



ps = PlotSim();

ps.plot(LinkPoints)