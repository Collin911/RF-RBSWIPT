function Pout = Power_Amplify(Pin, model, PLOT)
if(~exist('PLOT','var'))
    PLOT = 0;  % 如果未出现该变量，则对其进行赋值
end

if model== "ADL8106" % 18-54 GHz
    % https://www.analog.com/media/en/technical-documentation/data-sheets/adl8106.pdf
    try
        load ADL8106.mat fitresult
    catch
        fPin = -14:1:10;
        fgain=[20.1 20.07 20.05 20.02 20 19.98 19.95 19.5 19.3 19 18.5 18 17.5 17 16.5 15.2 14.8 13 12 11 10 9 8 7 6]; 
        
        [xData, yData] = prepareCurveData(fPin, fgain );
    
        % Set up fittype and options.
        ft = 'linearinterp';
        opts = fitoptions( 'Method', 'LinearInterpolant' );
        opts.ExtrapolationMethod = 'linear';
        opts.Normalize = 'on';  

        % Fit model to data.
        [fitresult, gof] = fit( xData, yData, ft, opts );

        save ADL8106.mat fitresult 
    end
elseif model == "HMC519" % 27-32 GHz
    % https://www.analog.com/media/en/technical-documentation/data-sheets/hmc519chips.pdf
    try 
        load HMC519.mat fitresult
    catch
        fPin = -20:1.25:10;
        fgain = [15.5 15.5 15.5 15.48 15.48 ...
            15.45 15.4 15.3 15.2 15.1 ...
            15.02 14.98 14.8 14.5 14.05 ...
            13.65 13 12.15 11.3 10.6 9.8...
            8.75 7.5 6.25 5];
        [xData, yData] = prepareCurveData(fPin, fgain );
    
        % Set up fittype and options.
        ft = 'linearinterp';
        opts = fitoptions( 'Method', 'LinearInterpolant' );
        opts.ExtrapolationMethod = 'linear';
        opts.Normalize = 'on';

        % Fit model to data.
        [fitresult, gof] = fit( xData, yData, ft, opts );

        save HMC519.mat fitresult 
    end


end


Pin = pow2db(Pin) + 30; % Input unit: W, fitting unit dBm, convertion: pow2db +30
gain = fitresult(Pin)';

Pout = Pin + gain;

if PLOT
    % Plot fit with data.
    figure( 'Name', 'gain' );
    h = plot( fitresult, Pin, Pout );
    legend( h, '$P_{\rm out}$', 'gain', 'Location', 'NorthEast', 'Interpreter', 'latex' );
    % Label axes
    xlabel( '$P_{\rm in}$(dBm)', 'Interpreter', 'latex' );
    ylabel( 'gain(dB)/$P_{\rm out}$(dBm)', 'Interpreter', 'latex' );
    grid on
end

Pout = db2pow(Pout - 30); % Output unit: W, fitting unit dBm, convertion: -30 db2pow

