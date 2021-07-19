function fee (){
  const itemPrice = document.getElementById("item-price");

  itemPrice.addEventListener("keyup", () => {

    const addTaxPriceVal = Math.floor(itemPrice.value * 0.1);
    const addTaxPrice = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = addTaxPriceVal;

    const profitVal = itemPrice.value - addTaxPriceVal;
    const profit = document.getElementById("profit");
    profit.innerHTML = profitVal;
  });
};

window.addEventListener('load', fee)