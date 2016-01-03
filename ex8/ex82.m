

load('data/Classifiers.mat')
faceDetector = HaarFeatures(classifiers);

img = rgb2gray(imread('data/faceA.jpg'));
imshow(img)

response = faceDetector.classify(img)