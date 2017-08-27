N = 100;
turn = 100;
win = 0;

avg_earn=0;
for t = 1:turn
    chip = 500;
    R = rand(1,N);
    for i = 1:N
        if(R(i)<0.5)
            chip = chip + 15;
        else
            chip = chip-10;
        end
    end
    avg_earn = avg_earn+chip;
end
avg_earn/turn