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
  int total = 0;
  ShoppingMall mall = ShoppingMall(products, myCart, total);
  
  while (true) {
    print(
      '----------------------------------------------------------------------------------------\n[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료\n----------------------------------------------------------------------------------------',
    );
    var answer = stdin.readLineSync();

    if (answer == '1') {
      //상품목록출력
      mall.showProducts();
    } else if (answer == '2') {
      //장바구니에담기
      mall.addToCart();
      print('2번이 종료되면 $myCart');
    } else if (answer == '3') {
      //장바구니에 담긴 상품의 총 가격 보기
      mall.showTotal();
    } else if (answer == '4') {
      //프로그램 종료
      print('프로그램을 종료합니다.');
      break;
    } else {
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
  ShoppingMall(this.productList, this.myCart, this.total);

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
            myTotal = found.productPrice * myCartNum;
          });
          total += myTotal;
          return;
        } else {
          print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
        }
      } catch (e) {
        print('입력값이 올바르지 않아요!2');
      }
    } else {
      print('입력값이 올바르지 않아요!1');
    }
  }

  //장바구니에담긴상품가격보기
  void showTotal() {
    if (myCart.isNotEmpty) {
      print('장바구니에 총 $total이 있네요!');
      return;
    } else {
      print('장바구니가 비어있어요!');
      return;
    }
  }
}

