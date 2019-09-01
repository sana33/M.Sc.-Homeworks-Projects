function [U_Matrix] = plotU_Matrix(kohonenWeights, hObject, handles)
kWeightsSize = size(kohonenWeights);
kohonenDims = kWeightsSize(1:end-1);

switch length(kohonenDims)
    case 1
        U_Matrix = zeros(2*kohonenDims-1,1);
        for i = 2:2:2*kohonenDims-1
            ii = (i+1)/2;              
            U_Matrix(i) = norm(kohonenWeights(ii-.5, :)-kohonenWeights(ii+.5, :));
        end
        U_Matrix = U_Matrix';

        axes(handles.axes7);
        imagesc(normalizeDataSet(U_Matrix, 1, 0, 0), 'CDataMapping', 'scaled'); colorbar;
        pause(.001);
    case 2
        U_Matrix = zeros(2*kohonenDims(1)-1, 2*kohonenDims(2)-1);
        for i = 1:2:2*kohonenDims(1)-1
            for j = 2:2:2*kohonenDims(2)-1
                ii = (i+1)/2;
                jj = (j+1)/2;                
                U_Matrix(i,j) = norm(squeeze(kohonenWeights(ii, jj-.5, :)-kohonenWeights(ii, jj+.5, :)));
            end
        end
        for i = 2:2:2*kohonenDims(1)-1
            for j = 1:2:2*kohonenDims(2)-1
                ii = (i+1)/2;
                jj = (j+1)/2;                
                U_Matrix(i,j) = norm(squeeze(kohonenWeights(ii-.5, jj, :)-kohonenWeights(ii+.5, jj, :)));
            end
        end
        for i = 2:2:2*kohonenDims(1)-1
            for j = 2:2:2*kohonenDims(2)-1
                ii = (i+1)/2;
                jj = (j+1)/2;                
                U_Matrix(i,j) = .5 * (norm(squeeze(kohonenWeights(ii-.5, jj-.5, :)-kohonenWeights(ii+.5, jj+.5, :)))+ ...
                    norm(squeeze(kohonenWeights(ii+.5, jj-.5, :)-kohonenWeights(ii-.5, jj+.5, :))));
            end
        end
        axes(handles.axes7);
        imagesc(normalizeDataSet(U_Matrix, 1, 0, 0), 'CDataMapping', 'scaled'); colorbar;
        pause(.001);
    case 3
        U_Face1 = zeros(2*kohonenDims(1)-1, 2*kohonenDims(2)-1);
        U_Face11 = zeros(2*kohonenDims(1)-1, 2*kohonenDims(2)-1);
        U_Face2 = zeros(2*kohonenDims(1)-1, 2*kohonenDims(3)-1);
        U_Face22 = zeros(2*kohonenDims(1)-1, 2*kohonenDims(3)-1);
        U_Face3 = zeros(2*kohonenDims(2)-1, 2*kohonenDims(3)-1);
        U_Face33 = zeros(2*kohonenDims(2)-1, 2*kohonenDims(3)-1);
        maxValueUM = 0;
        
        %% Considering facet 1 and its mirroring facet
        for i = 1:2:2*kohonenDims(1)-1
            for j = 2:2:2*kohonenDims(2)-1
                ii = (i+1)/2;
                jj = (j+1)/2;                
                U_Face1(i,j) = norm(squeeze(kohonenWeights(ii, jj-.5, 1, :)-kohonenWeights(ii, jj+.5, 1, :)));
                U_Face11(i,j) = norm(squeeze(kohonenWeights(ii, jj-.5, kohonenDims(3), :)- ...
                    kohonenWeights(ii, jj+.5, kohonenDims(3), :)));
            end
        end
        for i = 2:2:2*kohonenDims(1)-1
            for j = 1:2:2*kohonenDims(2)-1
                ii = (i+1)/2;
                jj = (j+1)/2;                
                U_Face1(i,j) = norm(squeeze(kohonenWeights(ii-.5, jj, 1, :)-kohonenWeights(ii+.5, jj, 1, :)));
                U_Face11(i,j) = norm(squeeze(kohonenWeights(ii-.5, jj, kohonenDims(3), :)- ...
                    kohonenWeights(ii+.5, jj, kohonenDims(3), :)));
            end
        end
        for i = 2:2:2*kohonenDims(1)-1
            for j = 2:2:2*kohonenDims(2)-1
                ii = (i+1)/2;
                jj = (j+1)/2;                
                U_Face1(i,j) = .5 * (norm(squeeze(kohonenWeights(ii-.5, jj-.5, 1, :)- ...
                    kohonenWeights(ii+.5, jj+.5, 1, :)))+norm(squeeze(kohonenWeights(ii+.5, jj-.5, 1, :)- ...
                    kohonenWeights(ii-.5, jj+.5, 1, :))));
                U_Face11(i,j) = .5 * (norm(squeeze(kohonenWeights(ii-.5, jj-.5, kohonenDims(3), :)- ...
                    kohonenWeights(ii+.5, jj+.5, kohonenDims(3), :)))+ ...
                    norm(squeeze(kohonenWeights(ii+.5, jj-.5, kohonenDims(3), :)- ...
                    kohonenWeights(ii-.5, jj+.5, kohonenDims(3), :))));
            end
        end
        
        %% Considering facet 2 and its mirroring facet
        for i = 1:2:2*kohonenDims(1)-1
            for j = 2:2:2*kohonenDims(3)-1
                ii = (i+1)/2;
                jj = (j+1)/2;                
                U_Face2(i,j) = norm(squeeze(kohonenWeights(ii, 1, jj-.5, :)-kohonenWeights(ii, 1, jj+.5, :)));
                U_Face22(i,j) = norm(squeeze(kohonenWeights(ii, kohonenDims(2), jj-.5, :)- ...
                    kohonenWeights(ii, kohonenDims(2), jj+.5, :)));
            end
        end
        for i = 2:2:2*kohonenDims(1)-1
            for j = 1:2:2*kohonenDims(3)-1
                ii = (i+1)/2;
                jj = (j+1)/2;                
                U_Face2(i,j) = norm(squeeze(kohonenWeights(ii-.5, 1, jj, :)-kohonenWeights(ii+.5, 1, jj, :)));
                U_Face22(i,j) = norm(squeeze(kohonenWeights(ii-.5, kohonenDims(2), jj, :)- ...
                    kohonenWeights(ii+.5, kohonenDims(2), jj, :)));
            end
        end
        for i = 2:2:2*kohonenDims(1)-1
            for j = 2:2:2*kohonenDims(3)-1
                ii = (i+1)/2;
                jj = (j+1)/2;                
                U_Face2(i,j) = .5 * (norm(squeeze(kohonenWeights(ii-.5, 1, jj-.5, :)- ...
                    kohonenWeights(ii+.5, 1, jj+.5, :)))+norm(squeeze(kohonenWeights(ii+.5, 1, jj-.5, :)- ...
                    kohonenWeights(ii-.5, 1, jj+.5, :))));
                U_Face22(i,j) = .5 * (norm(squeeze(kohonenWeights(ii-.5, kohonenDims(2), jj-.5, :)- ...
                    kohonenWeights(ii+.5, kohonenDims(2), jj+.5, :)))+ ...
                    norm(squeeze(kohonenWeights(ii+.5, kohonenDims(2), jj-.5, :)- ...
                    kohonenWeights(ii-.5, kohonenDims(2), jj+.5, :))));
            end
        end
        
        %% Considering facet 3 and its mirroring facet
        for i = 1:2:2*kohonenDims(2)-1
            for j = 2:2:2*kohonenDims(3)-1
                ii = (i+1)/2;
                jj = (j+1)/2;                
                U_Face3(i,j) = norm(squeeze(kohonenWeights(1, ii, jj-.5, :)-kohonenWeights(1, ii, jj+.5, :)));
                U_Face33(i,j) = norm(squeeze(kohonenWeights(kohonenDims(1), ii, jj-.5, :)- ...
                    kohonenWeights(kohonenDims(1), ii, jj+.5, :)));
            end
        end
        for i = 2:2:2*kohonenDims(2)-1
            for j = 1:2:2*kohonenDims(3)-1
                ii = (i+1)/2;
                jj = (j+1)/2;                
                U_Face3(i,j) = norm(squeeze(kohonenWeights(1, ii-.5, jj, :)-kohonenWeights(1, ii+.5, jj, :)));
                U_Face33(i,j) = norm(squeeze(kohonenWeights(kohonenDims(1), ii-.5, jj, :)- ...
                    kohonenWeights(kohonenDims(1), ii+.5, jj, :)));
            end
        end
        for i = 2:2:2*kohonenDims(2)-1
            for j = 2:2:2*kohonenDims(3)-1
                ii = (i+1)/2;
                jj = (j+1)/2;                
                U_Face3(i,j) = .5 * (norm(squeeze(kohonenWeights(1, ii-.5, jj-.5, :)- ...
                    kohonenWeights(1, ii+.5, jj+.5, :)))+norm(squeeze(kohonenWeights(1, ii+.5, jj-.5, :)- ...
                    kohonenWeights(1, ii-.5, jj+.5, :))));
                U_Face33(i,j) = .5 * (norm(squeeze(kohonenWeights(kohonenDims(1), ii-.5, jj-.5, :)- ...
                    kohonenWeights(kohonenDims(1), ii+.5, jj+.5, :)))+ ...
                    norm(squeeze(kohonenWeights(kohonenDims(1), ii+.5, jj-.5, :)- ...
                    kohonenWeights(kohonenDims(1), ii-.5, jj+.5, :))));
            end
        end

        max1 = max(max(U_Face1)); max11 = max(max(U_Face11)); max2 = max(max(U_Face2)); 
        max22 = max(max(U_Face22)); max3 = max(max(U_Face3)); max33 = max(max(U_Face33));
        if maxValueUM < max1 || maxValueUM < max11 || maxValueUM < max2 || maxValueUM < max22 || maxValueUM < max3 || maxValueUM < max33
            maxValueUM = max([max1 max11 max2 max22 max3 max33]);
        end

        d1 = size(U_Face1,1);
        d2 = size(U_Face1,2);
        d3 = size(U_Face2,2);
        U_Matrix = zeros(2*d1+2*d3,2*d3+d2);

        U_Matrix(1:d3, 1:d3) = maxValueUM;
        U_Matrix(1:d3, d3+1:d3+d2) = U_Face3(1:d2,1:d3)';
        U_Matrix(1:d3, d3+d2+1:d3+d2+d3) = maxValueUM;

        U_Matrix(d3+1:d3+d1, 1:d3) = U_Face2;
        U_Matrix(d3+1:d3+d1, d3+1:d3+d2) = U_Face1;
        U_Matrix(d3+1:d3+d1, d3+d2+1:d3+d2+d3) = U_Face22;

        U_Matrix(d3+d1+1:d3+d1+d3+d1, 1:d3) = maxValueUM;
        U_Matrix(d3+d1+1:d3+d1+d3+d1, d3+d2+1:d3+d2+d3) = maxValueUM;

        U_Matrix(d3+d1+1:d3+d1+d3, d3+1:d3+d2) = U_Face33';
        U_Matrix(d3+d1+d3+1:d3+d1+d3+d1, d3+1:d3+d2) = U_Face11;

        axes(handles.axes7);
        imagesc(normalizeDataSet(U_Matrix, 1, 0, 0), 'CDataMapping', 'scaled'); colorbar;
        pause(.001);
end
guidata(hObject, handles);