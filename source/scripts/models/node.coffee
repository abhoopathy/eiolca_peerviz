define ['underscore','backbone'], (_,Backbone) ->

    NodeModel = Backbone.Model.extend

        defaults: {
            "schoolname": "", # Harvard University
            "city": "", # Cambridge
            "state": "", # Massachusetts
            "lat": "", # 42.3756180000
            "lng": "", # -71.1193700000
            "climate": "", # 5
            "enrollment": "", # 27651
            "control": "", # Private not-for-profit
            "degree": "", # Doctor's degree
            "data": "", # 0
            "unitid": "", # 166027
            "level": "", # Four or more years
            "commset": "", # City: Midsize
            "resstat": "", # Highly Residential
            "endowment": "", # 3692669300
        }


    return NodeModel
