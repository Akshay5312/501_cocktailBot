Bot = ABBBot([0;0;0;0;0.1;0]);
Bot = Bot.setTarget([800; 300; 202; 0; 0.1; 0])

Sim = plotter.PlotSim();

    Bot = Bot.runRealTime();
    F = Bot.getLinkPoints();

    Sim = Sim.plot(F)

    t0 = clock
while (not(Bot.hasReached))
    Bot = Bot.runRealTime();
    F = Bot.getLinkPoints();

    Sim = Sim.plot(F)

%     if etime(t0, clock) > 1
%         EE = F{8};
%         EE = EE(1:3,4);
%         EE;
%         t0 = clock;
%     end
end