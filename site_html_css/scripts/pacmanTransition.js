function pactransMore(){
  for(var i = 0; i < 3; ++i){
    var pacman = document.createElement('IMG');

    pacman.src = 'res/pacman.png';
    pacman.id = "pacman" + i;
    pacman.style.position = "absolute";
    pacman.style.width = "5%";

    var verticalPoz = 10 + i*40;

    pacman.style.top = "" + verticalPoz + "%";
    pacman.style.zIndex = "-1";
    pacman.style.transition = "left 4s linear";
    pacman.style.left = "0px";

    document.body.appendChild(pacman);
    {
      let k = i;
      window.setTimeout(() => {
        movePacmanId(k);
      }, 500-5*k);
    }
  }
}
function movePacmanId(id){
  var pacmanid = "pacman" + id;

  console.log(pacmanid);

  var pacman = document.getElementById("pacman" + id);

  pacman.style.left = "90%";

  window.setTimeout(() => {
    deletePacmanId(id);
  }, 3900 - 5*id);
}

function deletePacmanId(id){
  document.body.removeChild(document.getElementById("pacman"+id));
}
