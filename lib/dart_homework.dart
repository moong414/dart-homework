import 'dart:convert';
import 'dart:io';

void main() {
  List<Product> products = [
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];
  Map<dynamic, int> myCart = {};
  ShoppingMall mall = ShoppingMall(products, myCart);
  
  while (true) {
    print(
      '----------------------------------------------------------------------------------------\n[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료 / [6] 장바구니 초기화 \n----------------------------------------------------------------------------------------',
    );
    var answer = stdin.readLineSync();
    if (answer == '1') {
      //상품목록출력
      mall.showProducts();
    } else if (answer == '2') {
      //장바구니에담기
      mall.addToCart();
    } else if (answer == '3') {
      //장바구니에 담긴 상품의 총 가격 보기
      mall.showTotal();
    } else if (answer == '4') {
      //프로그램 종료
      print('종료하시겠습니까? 종료하려면 5를 입력하세요.');
      String? answerExit = stdin.readLineSync();
      if (answerExit == '5') {
        print('이용해 주셔서 감사합니다 ~ 안녕히 가세요!');
        break;
      }else{
        print('종료하지 않습니다.');
      }
    } else if (answer == '6') {
      //장바구니초기화
      mall.clearMyCart();
    }else {
      print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
    }
  }
}

//Product클래스정의
class Product {
  String productName;
  int productPrice;
  Product(this.productName, this.productPrice);
}

//ShoppingMall클래스정의
class ShoppingMall {
  List<Product> productList;
  Map<dynamic, int> myCart;
  int total;
  ShoppingMall(this.productList, this.myCart) : total = 0;

  //상품목록출력
  void showProducts() {
    for (var item in productList) {
      print('${item.productName} / ${item.productPrice}원');
    }
  }

  //장바구니담기
  void addToCart() {
    print('상품명을 입력해주세요!');
    String? itemName = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);
    if (itemName != null && itemName != '' && productList.any((p) => p.productName == itemName)) {
      try {
        print('수량을 입력해주세요!');
        var itemNumber = stdin.readLineSync();
        var itemNum = int.parse(itemNumber!);
        if (itemNum > 0) {
          print('장바구니에 상품이 담겼어요 !');
          int myTotal = 0;
          myCart.update(itemName, (value) => value + itemNum, ifAbsent: () => itemNum);
          myCart.forEach((myCartItem, myCartNum){
            var found = productList.firstWhere((p) => p.productName == myCartItem);
            myTotal += found.productPrice * myCartNum;
          });
          total = myTotal;
        } else {
          print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
        }
      } catch (e) {
        print('수량을 제대로 입력해주세요!');
      }
    } else {
      print('상품명을 제대로 입력해주세요!');
    }
  }

  //장바구니에 담긴 상품의 총 가격 보기
  void showTotal() {
    if (myCart.isNotEmpty) {
      List<String> myItemTotal = [];
      for(var entry in myCart.entries){
        myItemTotal.add('${entry.key} ${entry.value}개');
      }
      print('장바구니에 $myItemTotal 담겨있네요. 총 $total원 입니다!');
      return;
    } else {
      print('장바구니에 담긴 상품이 없습니다.');
      return;
    }
  }

  //장바구니초기화
  void clearMyCart(){
    if(myCart.isNotEmpty && total != 0){
        print('장바구니를 초기화합니다.');
        myCart.clear();
        total = 0;
      }else{
        print('이미 장바구니가 비어있습니다.');
      }
  }

}

