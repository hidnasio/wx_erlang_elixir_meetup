defmodule Example2 do
  def run() do
    :wx.new()

    modal = :wxMessageDialog.new(:wx.null(), 'Hello World')

    :wxMessageDialog.showModal(modal)

    :wxMessageDialog.destroy(modal)
  end
end
