#
#  Created by Boyd Multerer on 10/02/17.
#  Copyright © 2017 Kry10 Industries. All rights reserved.
#

defmodule Scenic.Primitive.Transform.Scale do
  use Scenic.Primitive.Transform

  #============================================================================
  # data verification and serialization

  #--------------------------------------------------------
  def info(), do: "Transform :scale must conform to the documentation\n"

  #--------------------------------------------------------
  def verify( percent ) do
    try do
      normalize( percent )
      true
    rescue
      _ -> false
    end
  end

  #--------------------------------------------------------
  # normalize named stipples
  def normalize( pct ) when is_number(pct), do: {pct, pct}
  def normalize( {px, py} ) when is_number(px) and is_number(py), do: {px, py}

end