K = BotKinematics();
Q = [0 0 0 0 0 0];
%K.getFK([0 0 0])

Fr = K.getFrames(Q)
LinkPoints = zeros(7,3)

for m = 1:7
    Frame = Fr{m}
    LinkPoints(m,:) = Frame(1:3,4)'
end



ps = PlotSim();

ps.plot(LinkPoints)