% Loading the data:
load starData.mat

% Calculating the wavelenghts:
intervals = size(spectra, 1);
lambdaStart = 630.02;
lambdaDelta = 0.14;

lambdaEnd = lambdaStart + (intervals-1) * lambdaDelta;
lambda = (lambdaStart:lambdaDelta:lambdaEnd).';

% Redshift calculation for all stars
[sHa, idx] = min(spectra);
lambdaHa = lambda(idx);
z = (lambdaHa / 656.28) - 1;
speed = z * 299792.458;

% Loop through each star for analysis and visualization
for i = 1:size(spectra, 2) % Looping through each star
    spectrum = spectra(:, i); % Extracting the spectrum of the current star
    wavelength = lambda; % Wavelength values

    % Basic spectral analysis (finding the peak value)
    [peakIntensity, peakIndex] = max(spectrum);
    peakWavelength = wavelength(peakIndex);

    % Movement analysis
    restWavelength = 656.28; % Hydrogen alpha line in nanometers
    observedWavelength = peakWavelength;
    z = (observedWavelength - restWavelength) / restWavelength;

    % Determining the direction of movement, star name and number
    starName = starnames{i};
    if z > 0
        disp([starName, ' (Star ', num2str(i), ') is moving away.']);
    else
        disp([starName, ' (Star ', num2str(i), ') is moving towards.']);
    end

    % Visualization
    figure;
    plot(wavelength, spectrum);
    hold on;
    plot(peakWavelength, peakIntensity, 'r*', 'MarkerSize', 10);
    title(['Spectrum of ', starName, ' (Star ', num2str(i), ')']);
    xlabel('Wavelength');
    ylabel('Intensity');
    hold off;

    % Add some blank line after each plot for spacing
    disp(' '); 
    disp(' ');
    disp(' ');
end


disp("Stars' wavelenghts comparison:")
plot(lambda,spectra)
legend(starnames)



% Identifying stars moving away/toward
moveAway = starnames(speed > 0);
moveToward = starnames(speed <=0);
disp("These stars are moving away:")
disp(moveAway)

disp("and these stars are moving toward the Earth:") 
disp(moveToward)