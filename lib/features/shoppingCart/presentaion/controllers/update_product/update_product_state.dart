abstract class CartProductState {

}class CartProductInitial extends CartProductState{}

class CartProductLoading extends CartProductState{}
class CartProductSuccess extends CartProductState{


}
class CartProductFailure extends CartProductState{
  String errMessage;
  CartProductFailure({required this.errMessage});


}