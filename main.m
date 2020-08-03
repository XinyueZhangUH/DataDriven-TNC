clc
clear all
selected_file = 'Chengdu1';
privacy = 'noP';
filename1 = ['data/', selected_file, '.mat'];
solveTNC(filename1, selected_file, privacy);

clc
clear all
selected_file = 'Chengdu1';
privacy = 'eps15';
filename1 = ['data/', selected_file, '_', privacy '.mat'];
solveTNC(filename1, selected_file, privacy);