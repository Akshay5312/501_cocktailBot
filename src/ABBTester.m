Bot = ABBBot([0;0;0;0;0.1;0]);
Bot = Bot.setTarget([800; 300; 202; 0; 0.1; 0])

Sim = plotter.PlotSim();

    Bot = Bot.runRealTime();
    F = Bot.getLinkPoints();

    Sim = Sim.plot(F)

    t0 = clock


Bot = Bot.setTarget([800; 300; 202; 0; 0.1; 0])
while (not(Bot.hasReached()))
    Bot = Bot.runRealTime();
    F = Bot.getLinkPoints();

    Sim = Sim.plot(F)

end
pause(1)
Bot = Bot.setTarget([800; 300; 500; 0; 0.1; 0])
while (not(Bot.hasReached()))
    Bot = Bot.runRealTime();
    F = Bot.getLinkPoints();

    Sim = Sim.plot(F)

    "still Running 2"
end

pause(1)
Bot = Bot.setTarget([300; 500; 500; 0; 0.1; 0])
while (not(Bot.hasReached()))
    Bot = Bot.runRealTime();
    F = Bot.getLinkPoints();

    Sim = Sim.plot(F)

    "still Running 3"
end

pause(1)
Bot = Bot.setTarget([300; 500; 300; 0; pi; 0])
while (not(Bot.hasReached()))
    Bot = Bot.runRealTime();
    F = Bot.getLinkPoints();

    Sim = Sim.plot(F)

    "still Running 4"
end

pause(1)
Bot = Bot.setTarget([300; 500; 300; 0; 0.1; 0])
while (not(Bot.hasReached()))
    Bot = Bot.runRealTime();
    F = Bot.getLinkPoints();

    Sim = Sim.plot(F)

end

pause(1)

Bot = Bot.setTarget([800; 300; 500; 0; 0.1; 0])
while (not(Bot.hasReached()))
    Bot = Bot.runRealTime();
    F = Bot.getLinkPoints();

    Sim = Sim.plot(F)

end

pause(1)
Bot = Bot.setTarget([800; 300; 202; 0; 0.1; 0])
while (not(Bot.hasReached()))
    Bot = Bot.runRealTime();
    F = Bot.getLinkPoints();

    Sim = Sim.plot(F)

end

pause(1)

Bot = Bot.setTarget([800; 00; 1000; 0; 0.1; 0])
while (not(Bot.hasReached()))
    Bot = Bot.runRealTime();
    F = Bot.getLinkPoints();

    Sim = Sim.plot(F)

end

