`#target aftereffects`


# ---------------------------------------------------------
# 
# Returns the first layer with a given comp and layer name
# 
# ---------------------------------------------------------
_layer = (composition, layerName) -> 
    if (typeof composition is "string")
        composition = _comp(composition)

    return esy.composition.first(composition, layerName)


# ---------------------------------------------------------
# 
# Returns the first comp with a given comp name
# 
# ---------------------------------------------------------
_comp = (compositionName) ->
    return esy.project.first compositionName


# ---------------------------------------------------------
# 
# Fits the layer horizontally or vertically
# to fill comp without cropping.
# 
# ---------------------------------------------------------
_fitLayer = (layer) ->    
    size = layer.sourceRectAtTime 0, false
    compRatio = layer.containingComp.width / layer.containingComp.height
    mediaRatio = layer.width / layer.height

    if mediaRatio > compRatio
        scale = layer.containingComp.width / size.width * 100

    else
        scale = layer.containingComp.height / size.height * 100

    layer.property("Scale").setValue [scale, scale]



# alert(_layer("@ Texts", "title-01").property("Source Text").value)
# _fitLayer(_layer("> Logo", "logo"))