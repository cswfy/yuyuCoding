function adjusted_luma = apply_gamma( Luma, gamma )
    mapping = gamma_serial(gamma);
    [rows columns] = size(Luma);
    
    adjusted_luma = Luma;
    for i = 1:1:rows
       for j = 1:1:columns
           adjusted_luma(i,j) = mapping(Luma(i,j)+1);
       end
    end

end