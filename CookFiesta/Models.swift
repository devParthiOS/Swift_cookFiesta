
// catagoryVC model tableView

struct FoodCategory {
    var namekey : String
    var name: String
    var image: String
    
    init(nameKey: String ,name: String, image: String) {
        self.namekey = nameKey
        self.name = name
        self.image = image
    }
}

// description page

struct DescriptionDetail {
    var index : String
    var type: String
    var recipe: String
    
    init(index: String ,type: String, recipe: String) {
        self.index = index
        self.type = type
        self.recipe = recipe
    }
}
