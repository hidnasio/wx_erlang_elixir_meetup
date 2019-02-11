defmodule Example3 do
  import :wx_const

  def run() do
    :wx.new()
    frame = :wxFrame.new(:wx.null(), wx_id_any(), 'Example 3')

    label = :wxTextCtrl.new(frame, wx_id_any(), [{:value, 'Hello'}, {:size, {150, 70}}])

    font = :wxFont.new(42, wx_fontfamily_default(), wx_fontstyle_normal(), wx_fontweight_bold())

    :wxTextCtrl.setFont(label, font)

    button =
      :wxButton.new(frame, wx_id_any(), [
        {:label, 'Click me!'},
        {:pos, {0, 64}},
        {:size, {150, 50}}
      ])

    :wxButton.connect(button, :command_button_clicked, [
      {:callback, &handle_click/2},
      {:userData, %{label: label}}
    ])

    :wxFrame.show(frame)
  end

  # event type {:wx, _id, component that fired the event, user data, wxCommand}
  # event info {:wx_ref, _id, :wxCommandEvent, []}

  def handle_click({:wx, _, button, %{label: label}, _command}, _event) do

    :wxTextCtrl.setValue(label, 'World')
    :wxButton.setLabel(button, 'Clicked!')
    :wxButton.disable(button)
  end
end
