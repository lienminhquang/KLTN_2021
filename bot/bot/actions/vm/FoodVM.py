class FoodVM:
    def __init__(self, 
        id,
        name,
        description,
        price,
        count,
        imagePath,
        agvRating,
        totalRating,
        saleCampaignVM,
        categoryVMs,
        ratings,
       carts):
       self.id=id
       self.name=name
       self.description=description
       self.price=price
       self.count=count
       self.imagePath=imagePath
       self.agvRating=agvRating
       self.totalRating=totalRating
       self.saleCampaignVM=saleCampaignVM
       self.categoryVMs=categoryVMs
       self.ratings=ratings
       self.carts=carts