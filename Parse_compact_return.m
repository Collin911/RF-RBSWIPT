function [BS_T, MT_R, MT_T, BS_R] = Parse_compact_return(Matrix3d)
    BS_T = Matrix3d(:,:,1);
    MT_R = Matrix3d(:,:,2);
    MT_T = Matrix3d(:,:,3);
    BS_R = Matrix3d(:,:,4);
end