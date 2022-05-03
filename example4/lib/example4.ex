defmodule Example4 do
  @behaviour :wx_object
  use Bitwise
  import :wx_const

  def run() do
    wx = :wx.new()
    frame = :wxFrame.new(wx, wx_id_any(), 'Hello World', [{:size, {500, 500}}])

    :wx_object.start_link(__MODULE__, %{frame: frame}, [])

    :wxFrame.show(frame)
  end

  def init(config) do
    :wx.batch(fn() -> do_init(config) end)
  end

  def do_init(config) do
    panel = :wxPanel.new(config.frame, [])


    main_sizer = :wxBoxSizer.new(wx_vertical())
    sizer = :wxStaticBoxSizer.new(wx_vertical(), panel, [{:label, 'Circle'}])

    win = :wxPanel.new(panel, [])
    pen = wx_black_pen()
    brush = :wxBrush.new({30, 175, 23, 127})
    font = wx_italic_font()
    :wxPanel.connect(win, :paint, [:callback])
    :wxPanel.connect(win, :key_down)
    :wxPanel.setFocus(win)

    :wxSizer.add(sizer, win, [{:flag, wx_expand()}, {:proportion, 1}])
    :wxSizer.add(main_sizer, sizer, [{:flag, wx_expand()}, {:proportion, 1}])

    :wxPanel.setSizer(panel, main_sizer)
    {panel, %{parent: panel, config: config, win: win, pen: pen, brush: brush, font: font, pos: {40.0, 250.0}}}
  end

  def handle_sync_event(_evt, _, state) do
    dc = :wxPaintDC.new(state.win)

    draw(dc, state.pen, state.brush, state.font, state.pos)
    :wxPaintDC.destroy(dc)
    :ok
  end

  def handle_event({:wx, _, _, _, {:wxKey, :key_down, _, _, 315, false, false, false, false, _, _, _}}, state) do
    IO.inspect "up"

    dc = :wxClientDC.new(state.win)
    %{pos: {x, y}} = state
    new_pos = {x, y - 10}
    new_state = %{state | pos: new_pos}

    draw(dc, state.pen, state.brush, state.font, new_pos)

    :wxDC.clear(dc)
    :wxClientDC.destroy(dc)

    {:noreply, new_state}
  end

  def handle_event({:wx, _, _, _, {:wxKey, :key_down, _, _, 317, false, false, false, false, _, _, _}}, state) do
    IO.inspect "down"
    dc = :wxClientDC.new(state.win)
    %{pos: {x, y}} = state
    new_pos = {x, y + 10}
    new_state = %{state | pos: new_pos}

    draw(dc, state.pen, state.brush, state.font, new_pos)

    :wxDC.clear(dc)
    :wxClientDC.destroy(dc)

    {:noreply, new_state}
  end
  def handle_event({:wx, _, _, _, {:wxKey, :key_down, _, _, 316, false, false, false, false, _, _, _}}, state) do
    IO.inspect "right"
    dc = :wxClientDC.new(state.win)
    %{pos: {x, y}} = state
    new_pos = {x + 10, y}
    new_state = %{state | pos: new_pos}

    draw(dc, state.pen, state.brush, state.font, new_pos)

    :wxDC.clear(dc)
    :wxClientDC.destroy(dc)

    {:noreply, new_state}
  end

  def handle_event({:wx, _, _, _, {:wxKey, :key_down, _, _, 314, false, false, false, false, _, _, _}}, state) do
    IO.inspect "left"
    dc = :wxClientDC.new(state.win)
    %{pos: {x, y}} = state
    new_pos = {x - 10, y}
    new_state = %{state | pos: new_pos}

    draw(dc, state.pen, state.brush, state.font, new_pos)

    :wxDC.clear(dc)
    :wxClientDC.destroy(dc)

    {:noreply, new_state}
  end

  def handle_event({:wx, _, _, _, _} = evt, state) do
    IO.inspect evt
    {:noreply, state}
  end

  def handle_info(msg, state) do
    IO.inspect msg
    {:noreply, state}
  end

  def handle_call(:shutdown, _from, %{panel: panel} = state) do
    :wxPanel.destroy(panel)
    {:stop, :normal, :ok, state}
  end

  def handle_call(msg, _from, state) do
    IO.inspect msg
    {:reply,{:error, :nyi}, state}
  end

  def handle_cast(msg, state) do
    IO.inspect msg
    {:noreply,state}
  end

  def code_change(_, _, state) do
    {:stop, :ignore, state}
  end

  def terminate(_reason, _state) do
    :ok
  end

  def draw(win, pen, brush, font, {pos_x, pos_y}) do
    canvas = :wxGraphicsContext.create(win)
    :wxGraphicsContext.setPen(canvas, pen)
    :wxGraphicsContext.setBrush(canvas, brush)
    :wxGraphicsContext.setFont(canvas, font, {0, 0, 50})

    path = :wxGraphicsContext.createPath(canvas)
    :wxGraphicsPath.addCircle(path, 0, 0, 40.0)
    :wxGraphicsPath.closeSubpath(path)
    :wxGraphicsContext.translate(canvas, pos_x, pos_y)
    :wxGraphicsContext.drawPath(canvas, path)

    :wxGraphicsObject.destroy(path)
    :wxGraphicsObject.destroy(canvas)
    :ok
  end
end
