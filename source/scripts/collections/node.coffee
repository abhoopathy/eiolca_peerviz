define [
    'underscore',
    'backbone',
    'cs!models/node'

], (_, Backbone, NodeModel) ->

    NodeCollection = Backbone.Collection.extend
        model: NodeModel
        url: 'php/json_all.php'

        someCollectionMethod: (class_id) -> this.get(class_id)

    return NodeCollection
