var pressed = false;

function hideshowStart(){
  window.addEventListener('keydown', (event) =>{
    if(event.keyCode === 86 && event.ctrlKey)
      if(!pressed){
        pressed = true;
        vanish();
      }
      else {
        pressed = false;
        reappear();
      }
  });
}

function vanish(){
    var items = document.getElementsByClassName('item');
    Array.prototype.forEach.call(items, hide);
}

function reappear(){
  var items = document.getElementsByClassName('item');
  Array.prototype.forEach.call(items, show);
}

function show(item){
  item.style.display = "inline-block";
}

function hide(item){
  item.style.display = "none";
}
