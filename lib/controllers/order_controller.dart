import 'package:foodapp/data/repository/order_repo.dart';
import 'package:foodapp/models/oder_model.dart';
import 'package:foodapp/models/place_order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService{
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});
   bool _isLoading = false;
  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;
   bool get isLoading => _isLoading;
   List<OrderModel> get currentOrderList => _currentOrderList;
   List<OrderModel> get historyOrderList => _historyOrderList;

   int _paymentIndex = 0;
   int get paymentIndex => _paymentIndex;

   String _orderType = "delivery";
   String get orderType => _orderType;

   String _foodNote = "";
   String get foodNote => _foodNote;

   Future<void>placeOrder(PlaceOrderBody placeOrder, Function callback)async{
     _isLoading = true;
     Response response = await orderRepo.placeOrder(placeOrder);
     if(response.statusCode == 200){
       _isLoading = false;
       print(response.body.toString());
       String message = response.body['message'];
       String orderId = response.body['order_id'].toString();
       callback(true, message, orderId);
     }else{
       print("My status cod is "+response.statusCode.toString());
       callback(false, response.statusText, "-1");
     }
   }
   Future<void>getOrderList()async {
     _isLoading = true;
     Response respose = await orderRepo.getOrderList();
     if(respose.statusCode == 200){
       _historyOrderList = [];
       _currentOrderList = [];
       respose.body.forEach((order){
         OrderModel orderModel = OrderModel.fromJson(order);
         if(orderModel.orderStatus == 'pending'||
             orderModel.orderStatus == 'accepted'||
             orderModel.orderStatus == 'processing'||
             orderModel.orderStatus == 'handover'||
             orderModel.orderStatus == 'picked_up'){
           _currentOrderList.add(orderModel);
         }else{
           _historyOrderList.add(orderModel);
         }
       }
       );
     }else{
       _historyOrderList = [];
       _currentOrderList = [];
     }
     _isLoading = false;
     print("The length of the order "+_currentOrderList.length.toString());
     print("The length of the order "+_historyOrderList.length.toString());
     update();
   }

   void  setPaymentIndex(int index){
     _paymentIndex = index;
     update();
   }

   void setDeliveryType(String type){
     _orderType = type;
     update();
   }

   void setFoodNote(String note){
     _foodNote = note;
   }

}