function [kohonenOutputs] = somTrain(somDataSet, kohonenSet, hObject, handles)
% Specifying the length and number of input data
inputLength = size(somDataSet.trainSetFinal, 2);
inputNo = size(somDataSet.trainSetFinal, 1);
% Specifying kohonen layer's neurons weights
kohonenWeights = normrnd(0, 1, [kohonenSet.kohonenDims, inputLength]);
% Recognizing kohonen layer's dimensions
kohonenDimsSize = numel(kohonenSet.kohonenDims);
winnerDistType = kohonenSet.winnerDistType;

switch kohonenDimsSize
    case 1
        % Defining output for any kohonen layer's neuron
        outputZ = zeros(kohonenSet.kohonenDims, 1);
        % Defining winning time relation for any kohonen layer's neuron in desino approach
        outputF = zeros(kohonenSet.kohonenDims, 1);
        % Defining bias for any kohonen layer's neuron in desino approach
        outputB = zeros(kohonenSet.kohonenDims, 1);
        deadFlag = zeros(kohonenSet.kohonenDims, 1);
        winCounter = zeros(kohonenSet.kohonenDims, 1);
        deadNeuron = [];
        errorMean = [];
        clustersNo = [];
        maxEPOCH = kohonenSet.EPOCH1;
        
        for trainPhase = 1:2
            if trainPhase == 1
                switch kohonenSet.neighbParamsSelectedObject
                    case 'recognizable_neighb_radioButton'
                        zigma = ceil(max(kohonenSet.kohonenDims) ./ 2);
                        eta = .1;
                    case 'unRecognizable_neighb_radioButton'
                        zigma = kohonenSet.unRecognizableOpt.zigma_zero;
                        eta = kohonenSet.unRecognizableOpt.eta_zero;
                end
            else
                if strcmp(kohonenSet.neighbParamsSelectedObject, 'unRecognizable_neighb_radioButton')
                    eta = etaConv;
                else
                    eta = .01;
                end
                zigma = 2;
                outputF = 0 .* outputF;
            end
            for ii = 1:maxEPOCH
                kError = 0;
                kErrorCounter = 0;
                for jj = 1:inputNo
                    switch winnerDistType
                        case 'euclidian_winDistType_radioButton'
                            distMatrix = squareform(pdist([kohonenWeights; somDataSet.trainSetFinal(jj, :)]));
                            kWeightsDist = distMatrix(1:end-1, 1:end-1);
                        case 'spherGeomDist_winDistType_radioButton'
                            distMatrix = squareform(pdist([kohonenWeights; somDataSet.trainSetFinal(jj, :)], @sgDist));
                            kWeightsDist = distMatrix(1:end-1, 1:end-1);
                    end
                    [bmuDist, bmuIndex] = min(transpose(distMatrix(end, 1:end-1)));
                    [bmuRow, bmuCol] = ind2sub(kohonenSet.kohonenDims, bmuIndex);
                    bmu = kohonenWeights(bmuRow, :);
                    hDist = exp(-(kWeightsDist(:, bmuIndex) .^ 2) ./ (2 .* (zigma .^ 2)));
                    outputZ = 0 .* outputZ;
                    outputZ(bmuRow, bmuCol) = 1;
                    deadFlag(bmuRow, bmuCol) = 1;
                    winCounter(bmuRow, bmuCol) = winCounter(bmuRow, bmuCol) + 1;
                    switch kohonenSet.desinoParams.isDesino
                        case 0
                            switch kohonenSet.neighbParamsSelectedObject
                                case 'recognizable_neighb_radioButton'
                                    rowLow = bmuRow-zigma;
                                    rowHigh = bmuRow+zigma;
                                    if rowLow < 1
                                        rowLow = 1;
                                    end
                                    if rowHigh > kohonenSet.kohonenDims(1)
                                        rowHigh = kohonenSet.kohonenDims(1);
                                    end
                                    kohonenWeightsTmp = kohonenWeights(rowLow:rowHigh, :);
                                    kohonenWeights(rowLow:rowHigh, :) = kohonenWeights(rowLow:rowHigh, :) ...
                                        + eta .* (ones(rowHigh- rowLow + 1, 1) * somDataSet.trainSetFinal(jj, :) - ...
                                        kohonenWeights(rowLow:rowHigh, :));
                                    kError = kError + sum(sqrt(sum((kohonenWeightsTmp - kohonenWeights(rowLow:rowHigh, :)) .^ 2, 2)));
                                    kErrorCounter = kErrorCounter + rowHigh - rowLow + 1;
                                case 'unRecognizable_neighb_radioButton'
                                    kohonenWeightsTmp = kohonenWeights;
                                    kohonenWeights = kohonenWeights + eta .* (hDist * ones(1, inputLength)) ...
                                        .* (ones(prod(kohonenSet.kohonenDims), 1) * ...
                                        somDataSet.trainSetFinal(jj, :) - kohonenWeights);
                                    kError = kError + sum(sqrt(sum((kohonenWeightsTmp - kohonenWeights) .^ 2, 2)));
                                    kErrorCounter = kErrorCounter + prod(kohonenSet.kohonenDims);
                            end
                        case 1
                            outputF = outputF + kohonenSet.desinoParams.desinoBeta .* (outputZ - outputF);
                            outputB = kohonenSet.desinoParams.desinoGamma .* ((1 ./ ...
                                prod(kohonenSet.kohonenDims)) - outputF);
                            [desinoWinnerDist, desinoWinnerIndex] = min(transpose(distMatrix(end, 1:end-1)) - outputB);
                            [desinoWinnerRow, desinoWinnerCol] = ind2sub(kohonenSet.kohonenDims, desinoWinnerIndex);
                            kohonenWeightsTmp = kohonenWeights(desinoWinnerRow, :);
                            kohonenWeights(desinoWinnerRow, :) = kohonenWeights(desinoWinnerRow, :) + ...
                                eta .* (somDataSet.trainSetFinal(jj, :) - kohonenWeights(desinoWinnerRow, :));
                            kError = kError + sqrt(sum((kohonenWeightsTmp - kohonenWeights(desinoWinnerRow, :)) .^ 2, 2));
                            kErrorCounter = kErrorCounter + 1;
                    end
                end
                if trainPhase == 1
                    switch kohonenSet.neighbParamsSelectedObject
                        case 'recognizable_neighb_radioButton'
                            if mod(ii, ceil(maxEPOCH ./ zigma)) == 0
                                zigma = zigma - 1;
                            end
                            eta = eta - 9e-2./maxEPOCH;
                        case 'unRecognizable_neighb_radioButton'
                            zigma = zigma .* exp(-ii ./ kohonenSet.unRecognizableOpt.t1);
                            eta = eta .* exp(-ii ./ kohonenSet.unRecognizableOpt.t2);
                            etaConv = eta;
                    end
                end
                
                deadNeuron = [deadNeuron sum(deadFlag == 0)];
                axes(handles.axes2);
                plot(deadNeuron, '-k');
                grid on;
                pause(.001);
                guidata(hObject, handles);

                errorMean = [errorMean kError./kErrorCounter];
                axes(handles.axes1);
                plot(errorMean, '-r');
                grid on;
                pause(.001);
                guidata(hObject, handles);

                clusters = zeros(kohonenSet.kohonenDims, 1);
                clusterIndicator = [];
                clusterId = 1;
                clusterMeasure = kohonenSet.clusterMeasure;
                for c1 = 1:prod(kohonenSet.kohonenDims)
                    if clusters(c1) == 0
                        clusters(c1) = clusterId;
                        clusterIndicator = [clusterIndicator; kohonenWeights(c1, :)];
                        clusterIndCount = 1;
                        for k1 = c1:prod(kohonenSet.kohonenDims)
                            if clusters(k1) == 0
                                if norm(kohonenWeights(c1, :) - kohonenWeights(k1, :)) < clusterMeasure
                                    clusters(k1) = clusterId;
                                    clusterIndCount = clusterIndCount + 1;
                                    clusterIndicator(clusterId, :) = (1./clusterIndCount).*((clusterIndCount-1).*clusterIndicator(clusterId, :) ...
                                        + kohonenWeights(k1, :));
                                end
                            end
                        end
                        clusterId = clusterId + 1;
                    end
                end
                groups = zeros(1, size(clusterIndicator, 1));
                for p1 = 1:size(clusterIndicator, 1)
                    groups(p1) = sum(clusters == p1);
                end
                axes(handles.axes3);
                bar(groups);
                grid on;
                pause(.001);
                guidata(hObject, handles);

                clustersNo = [clustersNo size(clusterIndicator, 1)];
                axes(handles.axes4);
                plot(clustersNo);
                grid on;
                pause(.001);
                guidata(hObject, handles);

                set(handles.winner_neurons_table, 'Data', winCounter);

                plotKWeightsDims(hObject, handles, kohonenWeights, prod(kohonenSet.kohonenDims), inputLength);
                
                U_Matrix = plotU_Matrix(kohonenWeights, hObject, handles);
            end
            maxEPOCH = kohonenSet.EPOCH2;
        end
        legend(handles.axes1, 'Updating Error Rate');
        legend(handles.axes2, 'Dead Neurons No.');
        legend(handles.axes3, 'Clusters Bar');
        legend(handles.axes4, 'Clusters Count');
        % Saving output results
        kohonenOutputs = struct('winCounter', winCounter, 'errorMean', errorMean, 'deadNeuron', deadNeuron, 'groups', groups, ...
            'clustersNo', clustersNo, 'clusterIndicator', clusterIndicator, 'kohonenWeights', kohonenWeights, 'U_Matrix', ...
            U_Matrix, 'kohonenSet', kohonenSet);
        % Considering test procedure
        kMeansVSsom(somDataSet.testSetFinal, somDataSet.testSetClass, clusterIndicator, winnerDistType, hObject, handles);
    case 2
        % Defining output for any kohonen layer's neuron
        outputZ = zeros(kohonenSet.kohonenDims);
        % Defining winning time relation for any kohonen layer's neuron in desino approach
        outputF = zeros(kohonenSet.kohonenDims);
        % Defining bias for any kohonen layer's neuron in desino approach
        outputB = zeros(kohonenSet.kohonenDims);
        deadFlag = zeros(kohonenSet.kohonenDims);
        winCounter = zeros(kohonenSet.kohonenDims);
        deadNeuron = [];
        errorMean = [];
        clustersNo = [];
        kWeightsReshaped = reshape(kohonenWeights, [prod(kohonenSet.kohonenDims), inputLength]);
        maxEPOCH = kohonenSet.EPOCH1;
        
        for trainPhase = 1:2
            if trainPhase == 1
                switch kohonenSet.neighbParamsSelectedObject
                    case 'recognizable_neighb_radioButton'
                        zigma = ceil(max(kohonenSet.kohonenDims) ./ 2);
                        eta = .1;
                    case 'unRecognizable_neighb_radioButton'
                        zigma = kohonenSet.unRecognizableOpt.zigma_zero;
                        eta = kohonenSet.unRecognizableOpt.eta_zero;
                end
            else
                if strcmp(kohonenSet.neighbParamsSelectedObject, 'unRecognizable_neighb_radioButton')
                    eta = etaConv;
                else
                    eta = .01;
                end
                zigma = 2;
                outputF = 0 .* outputF;
            end
            for ii = 1:maxEPOCH
                kError = 0;
                kErrorCounter = 0;
                for jj = 1:inputNo
                    switch winnerDistType
                        case 'euclidian_winDistType_radioButton'
                            distMatrix = squareform(pdist([kWeightsReshaped; somDataSet.trainSetFinal(jj, :)]));
                            kWeightsDist = distMatrix(1:end-1, 1:end-1);
                        case 'spherGeomDist_winDistType_radioButton'
                            distMatrix = squareform(pdist([kWeightsReshaped; somDataSet.trainSetFinal(jj, :)], @sgDist));
                            kWeightsDist = distMatrix(1:end-1, 1:end-1);
                    end
                    [bmuDist, bmuIndex] = min(transpose(distMatrix(end, 1:end-1)));
                    [bmuRow, bmuCol] = ind2sub(kohonenSet.kohonenDims, bmuIndex);
                    bmu = kohonenWeights(bmuRow, bmuCol, :);
                    hDist = exp(-(kWeightsDist(:, bmuIndex) .^ 2) ./ (2 .* (zigma .^ 2)));
                    outputZ = 0 .* outputZ;
                    outputZ(bmuRow, bmuCol) = 1;
                    deadFlag(bmuRow, bmuCol) = 1;
                    winCounter(bmuRow, bmuCol) = winCounter(bmuRow, bmuCol) + 1;
                    switch kohonenSet.desinoParams.isDesino
                        case 0
                            switch kohonenSet.neighbParamsSelectedObject
                                case 'recognizable_neighb_radioButton'
                                    switch kohonenSet.recognizableOpt
                                        case 'circle_recog_neighb_opt_radioButton'
                                            neighbours = [];
                                            for l2 = 1:kohonenSet.kohonenDims(2)
                                                for l1 = 1:kohonenSet.kohonenDims(1)
                                                    if norm([bmuRow - l1, bmuCol - l2]) <= zigma
                                                        neighbours = [neighbours; l1 l2];
                                                    end
                                                end
                                            end
                                            linearIndex1 = sub2ind([kohonenSet.kohonenDims], neighbours(:,1), neighbours(:,2));
                                            kWeightsReshapedTmp = kWeightsReshaped(linearIndex1, :);
                                            kWeightsReshaped(linearIndex1, :) = ...
                                            kWeightsReshaped(linearIndex1, :) ...
                                            + eta .* (ones(size(linearIndex1, 1), 1) * somDataSet.trainSetFinal(jj, :) - ...
                                            kWeightsReshaped(linearIndex1, :));
                                            kError = kError + sum(sqrt(sum((kWeightsReshapedTmp - kWeightsReshaped(linearIndex1, :)) .^ 2, 2)));
                                            kErrorCounter = kErrorCounter + numel(linearIndex1);
                                        case 'rectangle_recog_neighb_opt_radioButton'
                                            rowLow = bmuRow - zigma;
                                            rowHigh = bmuRow + zigma;
                                            colLow = bmuCol - zigma;
                                            colHigh = bmuCol + zigma;
                                            if rowLow < 1
                                                rowLow = 1;
                                            end
                                            if rowHigh > kohonenSet.kohonenDims(1)
                                                rowHigh = kohonenSet.kohonenDims(1);
                                            end
                                            if colLow < 1
                                                colLow = 1;
                                            end
                                            if colHigh > kohonenSet.kohonenDims(2)
                                                colHigh = kohonenSet.kohonenDims(2);
                                            end
                                            neighbours = [];
                                            for l2 = colLow:colHigh
                                                for l1 = rowLow:rowHigh
                                                    neighbours = [neighbours; l1 l2];
                                                end
                                            end
                                            linearIndex1 = sub2ind([kohonenSet.kohonenDims], neighbours(:,1), neighbours(:,2));
                                            kWeightsReshapedTmp = kWeightsReshaped(linearIndex1, :);
                                            kWeightsReshaped(linearIndex1, :) = ...
                                            kWeightsReshaped(linearIndex1, :) ...
                                            + eta .* (ones(size(linearIndex1, 1), 1) * somDataSet.trainSetFinal(jj, :) - ...
                                            kWeightsReshaped(linearIndex1, :));
                                            kError = kError + sum(sqrt(sum((kWeightsReshapedTmp - kWeightsReshaped(linearIndex1, :)) .^ 2, 2)));
                                            kErrorCounter = kErrorCounter + numel(linearIndex1);
                                        case 'hexagon_recog_neighb_opt_radioButton'
                                            neighbours = HexagonNeighborhood([bmuRow, bmuCol], kohonenSet.kohonenDims(1), ...
                                                kohonenSet.kohonenDims(2), zigma);
                                            linearIndex1 = sub2ind([kohonenSet.kohonenDims], neighbours(:,1), neighbours(:,2));
                                            kWeightsReshapedTmp = kWeightsReshaped(linearIndex1, :);
                                            kWeightsReshaped(linearIndex1, :) = ...
                                            kWeightsReshaped(linearIndex1, :) ...
                                            + eta .* (ones(size(linearIndex1, 1), 1) * somDataSet.trainSetFinal(jj, :) - ...
                                            kWeightsReshaped(linearIndex1, :));
                                            kError = kError + sum(sqrt(sum((kWeightsReshapedTmp - kWeightsReshaped(linearIndex1, :)) .^ 2, 2)));
                                            kErrorCounter = kErrorCounter + numel(linearIndex1);
                                    end
                                case 'unRecognizable_neighb_radioButton'
                                    kWeightsReshapedTmp = kWeightsReshaped;
                                    kWeightsReshaped = kWeightsReshaped + eta .* (hDist * ones(1, inputLength)) ...
                                        .* (ones(prod(kohonenSet.kohonenDims), 1) * ...
                                        somDataSet.trainSetFinal(jj, :) - kWeightsReshaped);
                                    kError = kError + sum(sqrt(sum((kWeightsReshapedTmp - kWeightsReshaped) .^ 2, 2)));
                                    kErrorCounter = kErrorCounter + prod(kohonenSet.kohonenDims);
                            end
                            kohonenWeights = reshape(kWeightsReshaped, [kohonenSet.kohonenDims, inputLength]);
                        case 1
                            outputF = outputF + kohonenSet.desinoParams.desinoBeta .* (outputZ - outputF);
                            outputB = kohonenSet.desinoParams.desinoGamma .* ((1 ./ ...
                                prod(kohonenSet.kohonenDims)) - outputF);
                            [desinoWinnerDist, desinoWinnerIndex] = min(transpose(distMatrix(end, 1:end-1)) - outputB(:));
                            [desinoWinnerRow, desinoWinnerCol] = ind2sub([kohonenSet.kohonenDims], desinoWinnerIndex);
                            kohonenWeightsTmp = kohonenWeights(desinoWinnerRow, desinoWinnerCol, :);
                            kohonenWeights(desinoWinnerRow, desinoWinnerCol, :) = kohonenWeights(desinoWinnerRow, desinoWinnerCol, :) + ...
                                eta .* (reshape(somDataSet.trainSetFinal(jj, :), [1, 1, inputLength]) ...
                                - kohonenWeights(desinoWinnerRow, desinoWinnerCol, :));
                            kError = kError + sqrt(sum(reshape(kohonenWeightsTmp - kohonenWeights(desinoWinnerRow, desinoWinnerCol, :), [1, ...
                                inputLength]) .^ 2, 2));
                            kErrorCounter = kErrorCounter + 1;
                    end
                end
                if trainPhase == 1
                    switch kohonenSet.neighbParamsSelectedObject
                        case 'recognizable_neighb_radioButton'
                            if mod(ii, ceil(maxEPOCH ./ zigma)) == 0
                                zigma = zigma - 1;
                            end
                            eta = eta - 9e-2./maxEPOCH;
                        case 'unRecognizable_neighb_radioButton'
                            zigma = zigma .* exp(-ii ./ kohonenSet.unRecognizableOpt.t1);
                            eta = eta .* exp(-ii ./ kohonenSet.unRecognizableOpt.t2);
                            etaConv = eta;
                    end
                end

                deadNeuron = [deadNeuron sum(sum(deadFlag == 0))];
                axes(handles.axes2);
                plot(deadNeuron, '-k');
                grid on;
                pause(.001);
                guidata(hObject, handles);

                errorMean = [errorMean kError./kErrorCounter];
                axes(handles.axes1);
                plot(errorMean, '-r');
                grid on;
                pause(.001);
                guidata(hObject, handles);

                clusters = zeros(prod(kohonenSet.kohonenDims), 1);
                clusterIndicator = [];
                clusterId = 1;
                clusterMeasure = kohonenSet.clusterMeasure;
                for c1 = 1:prod(kohonenSet.kohonenDims)
                    if clusters(c1) == 0
                        clusters(c1) = clusterId;
                        clusterIndicator = [clusterIndicator; kWeightsReshaped(c1, :)];
                        clusterIndCount = 1;
                        for k1 = c1:prod(kohonenSet.kohonenDims)
                            if clusters(k1) == 0
                                if norm(kWeightsReshaped(c1, :) - kWeightsReshaped(k1, :)) < clusterMeasure
                                    clusters(k1) = clusterId;
                                    clusterIndCount = clusterIndCount + 1;
                                    clusterIndicator(clusterId, :) = (1./clusterIndCount).*((clusterIndCount-1).*clusterIndicator(clusterId, :) ...
                                        + kWeightsReshaped(k1, :));
                                end
                            end
                        end
                        clusterId = clusterId + 1;
                    end
                end
                groups = zeros(1, size(clusterIndicator, 1));
                for p1 = 1:size(clusterIndicator, 1)
                    groups(p1) = sum(clusters == p1);
                end
                axes(handles.axes3);
                bar(groups);
                grid on;
                pause(.001);
                guidata(hObject, handles);

                clustersNo = [clustersNo size(clusterIndicator, 1)];
                axes(handles.axes4);
                plot(clustersNo);
                grid on;
                pause(.001);
                guidata(hObject, handles);

                set(handles.winner_neurons_table, 'Data', winCounter);

                plotKWeightsDims(hObject, handles, kWeightsReshaped, prod(kohonenSet.kohonenDims), inputLength);
                
                U_Matrix = plotU_Matrix(kohonenWeights, hObject, handles);
            end
            maxEPOCH = kohonenSet.EPOCH2;
        end
        legend(handles.axes1, 'Updating Error Rate');
        legend(handles.axes2, 'Dead Neurons No.');
        legend(handles.axes3, 'Clusters Bar');
        legend(handles.axes4, 'Clusters Count');
        % Saving output results
        kohonenOutputs = struct('winCounter', winCounter, 'errorMean', errorMean, 'deadNeuron', deadNeuron, 'groups', groups, ...
            'clustersNo', clustersNo, 'clusterIndicator', clusterIndicator, 'kohonenWeights', kohonenWeights, 'U_Matrix', ...
            U_Matrix, 'kohonenSet', kohonenSet);
        % Considering test procedure
        kMeansVSsom(somDataSet.testSetFinal, somDataSet.testSetClass, clusterIndicator, winnerDistType, hObject, handles);
    case 3
        % Defining output for any kohonen layer's neuron
        outputZ = zeros(kohonenSet.kohonenDims);
        % Defining winning time relation for any kohonen layer's neuron in desino approach
        outputF = zeros(kohonenSet.kohonenDims);
        % Defining bias for any kohonen layer's neuron in desino approach
        outputB = zeros(kohonenSet.kohonenDims);
        deadFlag = zeros(kohonenSet.kohonenDims);
        winCounter = zeros(kohonenSet.kohonenDims);
        deadNeuron = [];
        errorMean = [];
        clustersNo = [];
        kWeightsReshaped = reshape(kohonenWeights, [prod(kohonenSet.kohonenDims), inputLength]);
        maxEPOCH = kohonenSet.EPOCH1;
        
        for trainPhase = 1:2
            if trainPhase == 1
                switch kohonenSet.neighbParamsSelectedObject
                    case 'recognizable_neighb_radioButton'
                        zigma = ceil(max(kohonenSet.kohonenDims) ./ 2);
                        eta = .1;
                    case 'unRecognizable_neighb_radioButton'
                        zigma = kohonenSet.unRecognizableOpt.zigma_zero;
                        eta = kohonenSet.unRecognizableOpt.eta_zero;
                end
            else
                if strcmp(kohonenSet.neighbParamsSelectedObject, 'unRecognizable_neighb_radioButton')
                    eta = etaConv;
                else
                    eta = .01;
                end
                zigma = 2;
                outputF = 0 .* outputF;
            end
            for ii = 1:maxEPOCH
                kError = 0;
                kErrorCounter = 0;
                for jj = 1:inputNo
                    switch winnerDistType
                        case 'euclidian_winDistType_radioButton'
                            distMatrix = squareform(pdist([kWeightsReshaped; somDataSet.trainSetFinal(jj, :)]));
                            kWeightsDist = distMatrix(1:end-1, 1:end-1);
                        case 'spherGeomDist_winDistType_radioButton'
                            distMatrix = squareform(pdist([kWeightsReshaped; somDataSet.trainSetFinal(jj, :)], @sgDist));
                            kWeightsDist = distMatrix(1:end-1, 1:end-1);
                    end
                    [bmuDist, bmuIndex] = min(transpose(distMatrix(end, 1:end-1)));
                    [bmuRow, bmuCol, bmuPag] = ind2sub(kohonenSet.kohonenDims, bmuIndex);
                    bmu = kohonenWeights(bmuRow, bmuCol, bmuPag, :);
                    hDist = exp(-(kWeightsDist(:, bmuIndex) .^ 2) ./ (2 .* (zigma .^ 2)));
                    outputZ = 0 .* outputZ;
                    outputZ(bmuRow, bmuCol, bmuPag) = 1;
                    deadFlag(bmuRow, bmuCol, bmuPag) = 1;
                    winCounter(bmuRow, bmuCol, bmuPag) = winCounter(bmuRow, bmuCol, bmuPag) + 1;
                    switch kohonenSet.desinoParams.isDesino
                        case 0
                            switch kohonenSet.neighbParamsSelectedObject
                                case 'recognizable_neighb_radioButton'
                                    rowLow = bmuRow - zigma;
                                    rowHigh = bmuRow + zigma;
                                    colLow = bmuCol - zigma;
                                    colHigh = bmuCol + zigma;
                                    pagLow = bmuPag - zigma;
                                    pagHigh = bmuPag + zigma;
                                    if rowLow < 1
                                        rowLow = 1;
                                    end
                                    if rowHigh > kohonenSet.kohonenDims(1)
                                        rowHigh = kohonenSet.kohonenDims(1);
                                    end
                                    if colLow < 1
                                        colLow = 1;
                                    end
                                    if colHigh > kohonenSet.kohonenDims(2)
                                        colHigh = kohonenSet.kohonenDims(2);
                                    end
                                    if pagLow < 1
                                        pagLow = 1;
                                    end
                                    if pagHigh > kohonenSet.kohonenDims(3)
                                        pagHigh = kohonenSet.kohonenDims(3);
                                    end
                                    neighbours = [];
                                    for l3 = pagLow:pagHigh
                                        for l2 = colLow:colHigh
                                            for l1 = rowLow:rowHigh
                                                neighbours = [neighbours; l1 l2 l3];
                                            end
                                        end
                                    end
                                    linearIndex1 = sub2ind([kohonenSet.kohonenDims], neighbours(:,1), neighbours(:,2), neighbours(:,3));
                                    kWeightsReshapedTmp = kWeightsReshaped(linearIndex1, :);
                                    kWeightsReshaped(linearIndex1, :) = ...
                                    kWeightsReshaped(linearIndex1, :) ...
                                    + eta .* (ones(size(linearIndex1, 1), 1) * somDataSet.trainSetFinal(jj, :) - ...
                                    kWeightsReshaped(linearIndex1, :));
                                    kError = kError + sum(sqrt(sum((kWeightsReshapedTmp - kWeightsReshaped(linearIndex1, :)) .^ 2, 2)));
                                    kErrorCounter = kErrorCounter + 1;
                                case 'unRecognizable_neighb_radioButton'
                                    kWeightsReshapedTmp = kWeightsReshaped;
                                    kWeightsReshaped = kWeightsReshaped + eta .* (hDist * ones(1, inputLength)) ...
                                        .* (ones(prod(kohonenSet.kohonenDims), 1) * ...
                                        somDataSet.trainSetFinal(jj, :) - kWeightsReshaped);
                                    kError = kError + sum(sqrt(sum((kWeightsReshapedTmp - kWeightsReshaped) .^ 2, 2)));
                                    kErrorCounter = kErrorCounter + prod(kohonenSet.kohonenDims);
                            end
                            kohonenWeights = reshape(kWeightsReshaped, [kohonenSet.kohonenDims, inputLength]);
                        case 1
                            outputF = outputF + kohonenSet.desinoParams.desinoBeta .* (outputZ - outputF);
                            outputB = kohonenSet.desinoParams.desinoGamma .* ((1 ./ ...
                                prod(kohonenSet.kohonenDims)) - outputF);
                            [desinoWinnerDist, desinoWinnerIndex] = min(transpose(distMatrix(end, 1:end-1)) - outputB(:));
                            [desinoWinnerRow, desinoWinnerCol, desinoWinnerPag] = ind2sub([kohonenSet.kohonenDims], desinoWinnerIndex);
                            kohonenWeightsTmp = kohonenWeights(desinoWinnerRow, desinoWinnerCol, desinoWinnerPag, :);
                            kohonenWeights(desinoWinnerRow, desinoWinnerCol, desinoWinnerPag, :) = ... 
                                kohonenWeights(desinoWinnerRow, desinoWinnerCol, desinoWinnerPag, :) + ...
                                eta .* (reshape(somDataSet.trainSetFinal(jj, :), [1, 1, 1, inputLength]) - ...
                                kohonenWeights(desinoWinnerRow, desinoWinnerCol, desinoWinnerPag, :));
                            kError = kError + sqrt(sum(reshape(kohonenWeightsTmp - kohonenWeights(desinoWinnerRow, desinoWinnerCol, desinoWinnerPag, :), [1, ...
                                inputLength]) .^ 2, 2));
                            kErrorCounter = kErrorCounter + 1;
                    end
                end
                if trainPhase == 1
                    switch kohonenSet.neighbParamsSelectedObject
                        case 'recognizable_neighb_radioButton'
                            if mod(ii, ceil(maxEPOCH ./ zigma)) == 0
                                zigma = zigma - 1;
                            end
                            eta = eta - 9e-2./maxEPOCH;
                        case 'unRecognizable_neighb_radioButton'
                            zigma = zigma .* exp(-ii ./ kohonenSet.unRecognizableOpt.t1);
                            eta = eta .* exp(-ii ./ kohonenSet.unRecognizableOpt.t2);
                            etaConv = eta;
                    end
                end
            
                deadNeuron = [deadNeuron sum(sum(sum(deadFlag == 0)))];
                axes(handles.axes2);
                plot(deadNeuron, '-k');
                grid on;
                pause(.001);
                guidata(hObject, handles);

                errorMean = [errorMean kError./kErrorCounter];
                axes(handles.axes1);
                plot(errorMean, '-r');
                grid on;
                pause(.001);
                guidata(hObject, handles);

                clusters = zeros(prod(kohonenSet.kohonenDims), 1);
                clusterIndicator = [];
                clusterId = 1;
                clusterMeasure = kohonenSet.clusterMeasure;
                for c1 = 1:prod(kohonenSet.kohonenDims)
                    if clusters(c1) == 0
                        clusters(c1) = clusterId;
                        clusterIndicator = [clusterIndicator; kWeightsReshaped(c1, :)];
                        clusterIndCount = 1;
                        for k1 = c1:prod(kohonenSet.kohonenDims)
                            if clusters(k1) == 0
                                if norm(kWeightsReshaped(c1, :) - kWeightsReshaped(k1, :)) < clusterMeasure
                                    clusters(k1) = clusterId;
                                    clusterIndCount = clusterIndCount + 1;
                                    clusterIndicator(clusterId, :) = (1./clusterIndCount).*((clusterIndCount-1).*clusterIndicator(clusterId, :) ...
                                        + kWeightsReshaped(k1, :));
                                end
                            end
                        end
                        clusterId = clusterId + 1;
                    end
                end
                groups = zeros(1, size(clusterIndicator, 1));
                for p1 = 1:size(clusterIndicator, 1)
                    groups(p1) = sum(clusters == p1);
                end
                axes(handles.axes3);
                bar(groups);
                grid on;
                pause(.001);
                guidata(hObject, handles);

                clustersNo = [clustersNo size(clusterIndicator, 1)];
                axes(handles.axes4);
                plot(clustersNo);
                grid on;
                pause(.001);
                guidata(hObject, handles);

                set(handles.winner_neurons_table, 'Data', reshape(winCounter, kohonenSet.kohonenDims(1), []));

                plotKWeightsDims(hObject, handles, kWeightsReshaped, prod(kohonenSet.kohonenDims), inputLength);
                
                U_Matrix = plotU_Matrix(kohonenWeights, hObject, handles);
            end
            maxEPOCH = kohonenSet.EPOCH2;
        end
        legend(handles.axes1, 'Updating Error Rate');
        legend(handles.axes2, 'Dead Neurons No.');
        legend(handles.axes3, 'Clusters Bar');
        legend(handles.axes4, 'Clusters Count');
        % Saving output results
        kohonenOutputs = struct('winCounter', winCounter, 'errorMean', errorMean, 'deadNeuron', deadNeuron, 'groups', groups, ...
            'clustersNo', clustersNo, 'clusterIndicator', clusterIndicator, 'kohonenWeights', kohonenWeights, 'U_Matrix', ...
            U_Matrix, 'kohonenSet', kohonenSet);
        % Considering test procedure
        kMeansVSsom(somDataSet.testSetFinal, somDataSet.testSetClass, clusterIndicator, winnerDistType, hObject, handles);
end