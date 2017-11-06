#
#  Created by Boyd Multerer on 11/06/17.
#  Copyright © 2017 Kry10 Industries. All rights reserved.
#

# This is a simple tracker for detecting if an object or objects have been "clicked" on
# Mouse down starts on one of the ids, 
# Mouse up must also be on one of the ids to be counted as a click

# note that trackers do not need to be in this directory
# This is just a good place for the common ones


defmodule Scenic.ViewPort.Input.Tracker.Click do
  use GenServer
  alias Scenic.ViewPort.Input
  alias Scenic.Scene

#  import IEx

  @input_registry     :input_registry


  #===========================================================================
  # The genserver part - tracks individual mouse clicks / gestures

  def start( target_button, target_id, valid_uids, scene_pid \\ nil )
  def start( tb, tid, udis, nil ), do: start( tb, tid, udis, self() )
  def start( target_button, target_id, valid_uids, scene_pid ) do
    state = {
      scene_pid,
      target_id,
      valid_uids,
      target_button
    }
    {:ok,_} = start_link( state )
  end

  #--------------------------------------------------------
  def start_link( state ) do
    GenServer.start_link(__MODULE__, state )
  end

  #--------------------------------------------------------
  def init( state ) do
    # register to receive mouse button events
    Input.register_input( :mouse_button )
    {:ok, state }
  end

  #--------------------------------------------------------
  # bit of a cheat going straight for the release code of 0, but hey...
  def handle_cast({:input, {:mouse_button, {btn, 0, _, pos}} }, state) do
    btn = Input.button_to_atom( btn )
    do_handle_release(btn, pos, state)
    {:noreply, state}
  end

  #--------------------------------------------------------
  def handle_cast(msg, state), do: {:noreply, state}

  #--------------------------------------------------------
  defp do_handle_release(btn, pos, { pid, id, uids, t_btn } = state) when btn == t_btn do
    # find the uid the button is over
    uid = Scene.find_by_screen_pos(pos, pid)

    if Enum.member?(uids, uid) do
      GenServer.cast(pid, {:input_uid, {:click, id, pos}, uid})
    end

    # tear down this process - no longer needed
    # input is automatically unregistered
    Process.exit(self(), :normal)

    {:noreply, state}
  end

  defp do_handle_release(_, _, state), do: {:noreply, state}


end