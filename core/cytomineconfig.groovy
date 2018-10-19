dataSource.url='jdbc:postgresql://db:5432/docker'
dataSource.username='docker'
dataSource.password='docker'

grails.admin.client='info@cytomine.be'

cytomine.customUI.global = [
        dashboard: ["ALL"],
        search : ["ROLE_ADMIN"],
        project: ["ALL"],
        ontology: ["ROLE_ADMIN"],
        storage : ["ROLE_USER","ROLE_ADMIN"],
        activity : ["ALL"],
        software: ["ALL"],
        feedback : ["ROLE_USER","ROLE_ADMIN"],
        explore : ["ROLE_USER","ROLE_ADMIN"],
        admin : ["ROLE_ADMIN"],
        help : ["ALL"]
]


grails.mongo.options.connectionsPerHost=50
grails.mongo.options.threadsAllowedToBlockForConnectionMultiplier=10

