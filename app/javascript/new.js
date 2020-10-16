function calculate(){
  const inputPrice = document.getElementById("item-price")
  inputPrice.addEventListener('input', function(){
    const calculateFee = Math.ceil(inputPrice.value * 0.1);
    const calculateProfit =inputPrice.value - calculateFee;
    const changeCalculateFee = document.getElementById(`add-tax-price`)
    const changeCalculateProfit = document.getElementById(`profit`)
    changeCalculateFee.innerHTML = `${calculateFee}`;
    changeCalculateProfit.innerHTML = `${calculateProfit}`;
  })

}
window.addEventListener('load', calculate);
