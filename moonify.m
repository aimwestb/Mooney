
% inputDir = input directory extension from where .m is saved, i.e. if .m is
% saved in C:\Moony and input images are saved in C:\Moony\Images inputDir
% would be 'Images'

% outputDir = output directory formatted same as inputDir

% smoothingDegree = degree of gaussian smoothing for imgaussfilt func

% extension = input image file extension formatted as e.g. '*.png'


function imageFiles = moonify(inputDir, outputDir, smoothingDegree, extension)

% list of images in the input directory
    imageFiles = dir(fullfile(inputDir, extension)); 
    disp('image files read');

    % process each image
    for k = 1:length(imageFiles)
        
        % read the input image
        inputImagePath = fullfile(inputDir, imageFiles(k).name);
        originalImage = imread(inputImagePath);

        % convert the image to grayscale
        grayImage = rgb2gray(originalImage);
        disp('converted to greyscale');

        % apply Gaussian smoothing
        smoothedImage = imgaussfilt(grayImage, smoothingDegree);
        disp('smoothed image');

        % binarize the smoothed image (Otsu's method)
        threshold = graythresh(smoothedImage);
        binaryImage = imbinarize(smoothedImage, threshold);
        disp('binarised image');

        % save the moonified image
        [~, name, ext] = fileparts(imageFiles(k).name);
        outputImagePath = fullfile(outputDir, [name, '_mooney', ext]);
        imwrite(binaryImage, outputImagePath);
        disp('saved to output directory');

    end

    disp('Mooney images generated and saved.');
end
