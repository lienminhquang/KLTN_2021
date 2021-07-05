class OrderVM:

    def __init__(self, id, appUserID, createdDate, isPaid, datePaid, orderStatusID, promotionID, finalTotalPrice, promotionAmount, addressString,
        addressName, userVM, orderStatusVM, orderDetailVMs
    ):
        self.id = id
        self.appUserID = appUserID
        self.createdDate = createdDate
        self.isPaid = isPaid
        self.datePaid = datePaid
        self.orderStatusID = orderStatusID
        self.promotionID = promotionID
        self.finalTotalPrice = finalTotalPrice
        self.promotionAmount = promotionAmount
        self.addressString = addressString,
        self.addressName = addressName
        self.userVM = userVM
        self.orderStatusVM = orderStatusVM
        self.orderDetailVMs = orderDetailVMs
        