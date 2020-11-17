function  ill = rgb2ill( img )
%RGB2ILL convert rgb color space to illuminant invariant image color space.
xyz=rgb2xyz(img);

B = [0.9465229   0.2946927 -0.1313419; ...
    -0.1179179   0.9929960  0.007371554; ...
     0.09230461 -0.04645794 0.9946464];
 
A = [27.07439  -22.80783  -1.806681; ...
     -5.646736  -7.722125 12.86503; ...
     -4.163133  -4.579428 -4.576049];
 
xyzVec = reshape(xyz, size(xyz,1)*size(xyz,2), size(xyz,3))';

illVec = A*log(B*xyzVec);

ill = reshape(illVec', size(xyz,1), size(xyz,2), size(xyz, 3));

%ill =int8( reshape(illVec', size(xyz,1), size(xyz,2), size(xyz, 3)) );
end

