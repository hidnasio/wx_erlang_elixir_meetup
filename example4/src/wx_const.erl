-module(wx_const).
-compile(export_all).

-include_lib("wx/include/wx.hrl").

wx_id_any() ->
  ?wxID_ANY.

wx_all() ->
  ?wxALL.

wx_vertical() ->
  ?wxVERTICAL.

wx_full_repaint_on_resize() ->
  ?wxFULL_REPAINT_ON_RESIZE.

wx_expand() ->
  ?wxEXPAND.

wx_red_brush() ->
  ?wxRED_BRUSH.

wx_black_pen() ->
  ?wxBLACK_PEN.

wx_italic_font() ->
  ?wxITALIC_FONT.
