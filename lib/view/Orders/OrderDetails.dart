List<Order> orderList = [];

  bool loading = true;
  double ordersum = 0.0;
  List<DeliveryBoy> deliveryBoyList = [];
  int userCount = 0;
  

  getData() async {
    userCount=await DeliveryBoyService.getAllUser();
    deliveryBoyList =await DeliveryBoyService.getAllDeliveryBoy();
    ordersum = 0.0;
    orderList = await OrderService.getAllOrdersByCount(0,30);
    setState(() {
      orderList.forEach((element) {
        ordersum += double.parse(element.amount) +
            double.parse(element.gst) +
            double.parse(element.packing);
      });
    });
    setState(() {
      loading = false;
    });
  }