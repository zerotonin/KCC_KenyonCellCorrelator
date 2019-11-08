function cmap = KCC_plot_cmap()
% Standard colormap
%
%          R   G   B
% y2 pre  146 194  83 
% y3 pre  242 229   0
% y4 pre  135  82 131
% y5 pre  31  115 159
% y2 pos  186 208  78
% y3 pos  240 235 135
% y4 pos  185 130 180
% y5 pos  0   164 194
% 

cmap = [146 194  83
        242 229   0
        135  82 131
        31  115 159
        186 208  78
        240 235 135
        185 130 180
        0   164 194];
cmap = cmap./255;
%cmap = 1-cmap;