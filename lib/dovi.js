// Generated by CoffeeScript 1.12.7
#target aftereffects;
var _comp, _fitLayer, _layer;

_layer = function(composition, layerName) {
  if (typeof composition === "string") {
    composition = _comp(composition);
  }
  return esy.composition.first(composition, layerName);
};

_comp = function(compositionName) {
  return esy.project.first(compositionName);
};

_fitLayer = function(layer) {
  var compRatio, mediaRatio, scale, size;
  size = layer.sourceRectAtTime(0, false);
  compRatio = layer.containingComp.width / layer.containingComp.height;
  mediaRatio = layer.width / layer.height;
  if (mediaRatio > compRatio) {
    scale = layer.containingComp.width / size.width * 100;
  } else {
    scale = layer.containingComp.height / size.height * 100;
  }
  return layer.property("Scale").setValue([scale, scale]);
};