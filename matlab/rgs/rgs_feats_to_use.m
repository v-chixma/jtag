function to_use = rgs_feats_to_use();

%
% 1    'l_page_dist'
% 2    't_page_dist'
% 3    'r_page_dist'
% 4    'b_page_dist'
% 5    'l_ws_dist'
% 6    't_ws_dist'
% 7    'r_ws_dist'
% 8    'b_ws_dist'
% 9    'height'
%10    'width'
%11    'area'
%12    'height_over_width'
%13    'width_over_height'
%14    'is_centered'
%15    'on_left_edge'
%16    'on_top_edge'
%17    'on_right_edge'
%18    'on_bottom_edge'
%19    'furthest_left'
%20    'furthest_up'
%21    'furthest_right'
%22    'furthest_down'
%23    'left_neighbour_dist'
%24    'top_neighbour_dist'
%25    'right_neighbour_dist'
%26    'bottom_neighbour_dist'
%27    'left_neighbour_covers'
%28    'top_neighbour_covers'
%29    'right_neighbour_covers'
%30    'bottom_neighbour_covers'
%31    'covers_left_neighbour'
%32    'covers_top_neighbour'
%33    'covers_right_neighbour'
%34    'covers_bottom_neighbour'
%35    'rect_order_fraction'
%36    'rect_dens'
%37    'sr_dens'
%38    'h_sharpness'
%39    'h_line'
%40    'v_line'
%41    'left_quarter_ink_fraction'
%42    'is_first_page'
%43    'is_last_page'
%44    'in_last_15pct_of_pages'
%45    'pnum_over_numpages'
%46    'num_marks'
%47    'marks_per_hundred_pixels'
%48    'marks_per_pixel_wide'
%49    'marks_per_pixel_high'
%50    'avg_pixels_per_mark'
%51    'std_pixels_per_mark'
%52    'pixels_in_largest_mark'
%53    'largest_mark_height'
%54    'largest_mark_width'
%55    'largets_mark_area'
%56    'highest_mark_height'
%57    'highest_mark_width'
%58    'widest_mark_height'
%59    'widest_mark_width'

to_use = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 ...
          19 20 21 22 36 37 38 39 40 41 42 43 44 45]; % 46 ...
%          47 48 49 50 51 52 53 54 55 56 57 58 59];

