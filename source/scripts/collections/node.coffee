define [
    'lodash',
    'backbone',
    'cs!models/node'

], (_, Backbone, NodeModel) ->

    NodeCollection = Backbone.Collection.extend
        model: NodeModel
        url: 'php/json_all.php'

    return NodeCollection
