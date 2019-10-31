
`#target aftereffects`

# ---------------------------------------------------------
#
# Will bake all layers of given comp or will accept and
# pass along a single layer as well.
#
# ---------------------------------------------------------
_bake = (target) ->
    if(target instanceof CompItem)
        for i in [1..target.numLayers]
            _bakeLayer(target.layers[i])
    else if(target instanceof AVLayer)
        _bakeLayer(target)


# ---------------------------------------------------------
#
# Will bake all properties on a given layer
#
# ---------------------------------------------------------
_bakeLayer = (layer)->
    comp = layer.containingComp
    comp.openInViewer();
    layer.outPoint = 1 * layer.containingComp.frameDuration
    for i in [1..layer.Effects.numProperties]
        effect = layer.Effects.property(i)
        property = effect.property(1)
        if ((property.canSetExpression) && (property.expressionEnabled))
            property.selected = true;

    app.executeCommand(app.findMenuCommandId("Convert Expression to Keyframes"));

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
# Cancels file replacement if path is not provided
#
# ---------------------------------------------------------
_replace = (source, path) ->
    if (path)
        source.replace(new File(path))

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