classdef countP < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        Panel                           matlab.ui.container.Panel
        UIAxes                          matlab.ui.control.UIAxes
        NoofVacantParkingSlotsEditFieldLabel  matlab.ui.control.Label
        NoofVacantParkingSlotsEditField  matlab.ui.control.NumericEditField
        BrowseimageButton               matlab.ui.control.Button
        CARPARKINGIMAGEPROCESSINGLabel  matlab.ui.control.Label
    end

    methods (Access = private)

        % Button pushed function: BrowseimageButton
        function BrowseimageButtonPushed(app, event)
            
            global image;
            
            % Browse image 
            [filename pathname] = uigetfile();
            
            % Storing image address            
            imageAddress = strcat([pathname , filename]);            
            
            % Reading the image
            image = imread(imageAddress);
            
            % preview image            
            imshow(image,'Parent',app.UIAxes);
            figure(app.UIFigure);
            
            % Counting number of vacant parking slots using OPTICAL CHARACTER RECOGNITION
            count = 0;
            info = ocr(image);
            text = info.Text;
            for letter = text
                if letter == 'P'
                    count = count + 1;
                end
            end
            
            % Displaying no. of vacant slots
            app.NoofVacantParkingSlotsEditField.Value = count;
            
        end

        
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'UI Figure';

            % Create Panel
            app.Panel = uipanel(app.UIFigure);
            app.Panel.ForegroundColor = [0.4902 0.1804 0.5608];
            app.Panel.TitlePosition = 'centertop';
            app.Panel.BackgroundColor = [0.8 0.8 0.8];
            app.Panel.FontWeight = 'bold';
            app.Panel.FontSize = 20;
            app.Panel.Position = [41 40 556 383];

            % Create UIAxes
            app.UIAxes = uiaxes(app.Panel);
            title(app.UIAxes, 'IMAGE')
            app.UIAxes.PlotBoxAspectRatio = [1 0.5 0.5];
            app.UIAxes.Color = [0 0.451 0.7412];
            app.UIAxes.Position = [66 136 418 234];

            % Create NoofVacantParkingSlotsEditFieldLabel
            app.NoofVacantParkingSlotsEditFieldLabel = uilabel(app.Panel);
            app.NoofVacantParkingSlotsEditFieldLabel.BackgroundColor = [0.4706 0.6706 0.1882];
            app.NoofVacantParkingSlotsEditFieldLabel.HorizontalAlignment = 'center';
            app.NoofVacantParkingSlotsEditFieldLabel.FontSize = 14;
            app.NoofVacantParkingSlotsEditFieldLabel.FontWeight = 'bold';
            app.NoofVacantParkingSlotsEditFieldLabel.FontColor = [1 1 1];
            app.NoofVacantParkingSlotsEditFieldLabel.Position = [66 38 200 22];
            app.NoofVacantParkingSlotsEditFieldLabel.Text = 'No. of Vacant Parking Slots';

            % Create NoofVacantParkingSlotsEditField
            app.NoofVacantParkingSlotsEditField = uieditfield(app.Panel, 'numeric');
            app.NoofVacantParkingSlotsEditField.ValueChangedFcn = createCallbackFcn(app, @NoofVacantParkingSlotsEditFieldValueChanged, true);
            app.NoofVacantParkingSlotsEditField.FontSize = 14;
            app.NoofVacantParkingSlotsEditField.FontWeight = 'bold';
            app.NoofVacantParkingSlotsEditField.FontColor = [1 1 1];
            app.NoofVacantParkingSlotsEditField.BackgroundColor = [0.4706 0.6706 0.1882];
            app.NoofVacantParkingSlotsEditField.Position = [284 38 150 22];

            % Create BrowseimageButton
            app.BrowseimageButton = uibutton(app.Panel, 'push');
            app.BrowseimageButton.ButtonPushedFcn = createCallbackFcn(app, @BrowseimageButtonPushed, true);
            app.BrowseimageButton.BackgroundColor = [0.4706 0.6706 0.1882];
            app.BrowseimageButton.FontSize = 16;
            app.BrowseimageButton.FontWeight = 'bold';
            app.BrowseimageButton.FontColor = [1 1 1];
            app.BrowseimageButton.Position = [164 77 194 27];
            app.BrowseimageButton.Text = 'Browse image';

            % Create CARPARKINGIMAGEPROCESSINGLabel
            app.CARPARKINGIMAGEPROCESSINGLabel = uilabel(app.UIFigure);
            app.CARPARKINGIMAGEPROCESSINGLabel.BackgroundColor = [0.4902 0.1804 0.5608];
            app.CARPARKINGIMAGEPROCESSINGLabel.HorizontalAlignment = 'center';
            app.CARPARKINGIMAGEPROCESSINGLabel.FontSize = 24;
            app.CARPARKINGIMAGEPROCESSINGLabel.FontWeight = 'bold';
            app.CARPARKINGIMAGEPROCESSINGLabel.FontColor = [1 1 1];
            app.CARPARKINGIMAGEPROCESSINGLabel.Position = [84 433 464 35];
            app.CARPARKINGIMAGEPROCESSINGLabel.Text = 'CAR PARKING IMAGE PROCESSING';
        end
    end

    methods (Access = public)

        % Construct app
        function app = gui

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end