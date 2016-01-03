close all; clear all; clc;

sample_points = [1:9 ceil(logspace(1, 3, 21))];

for n = 1:3
    filename = sprintf('data/data%d.mat', n);
    outputname = sprintf('data/output_%d.png', n);
    load(filename);

    samples = dat(:, 1:2);
    labels = dat(:, end);

    h = figure();
    subplot(2, 1, 1)
    hold on
    index = labels == 1;
    plot(samples(index, 1), samples(index, 2), 'r+');
    plot(samples(~index, 1), samples(~index, 2), 'bo');
    title('groundtruth')


    subplot(2, 1, 2)
    hold on
    clf = AdaboostClassifier(1000);
    clf.train(samples, labels);
    classification = clf.test(samples);
    index = classification == 1;
    plot(samples(index, 1), samples(index, 2), 'r+');
    plot(samples(~index, 1), samples(~index, 2), 'bo');
    title('classification')
    print(h, '-dpng', outputname);
    
    errors = zeros(size(sample_points));
    for m = 1:numel(sample_points)
        clf = AdaboostClassifier(sample_points(m));
        clf.train(samples, labels);
        classification = clf.test(samples);
        errors(m) = mean(classification ~= labels);
    end
    h = figure();
    plot(sample_points, errors, 'b-', 'LineWidth', 2);
    title(sprintf('Error on dataset #%d', n))
    print(h, '-dpng', sprintf('error_%d.png', n));    
end