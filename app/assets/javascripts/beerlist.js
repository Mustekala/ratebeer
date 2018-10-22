const BEERS = {}

BEERS.show = () => {
  $("#beertable tr:gt(0)").remove()
  const table = $("#beertable")

  BEERS.list.forEach((beer) => {
    table.append('<tr>'
      + '<td>' + beer['name'] + '</td>'
      + '<td>' + beer['style']['name'] + '</td>'
      + '<td>' + beer['brewery']['name'] + '</td>'
      + '</tr>')
  })
}

BEERS.sort_by_name = () => {
  BEERS.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  })
}

BEERS.sort_by_style = () => {
  BEERS.list.sort((a, b) => {
    return a.style.name.toUpperCase().localeCompare(b.style.name.toUpperCase())
  })
}

BEERS.sort_by_brewery = () => {
  BEERS.list.sort((a, b) => {
    return a.brewery.name.toUpperCase().localeCompare(b.brewery.name.toUpperCase());
  })
}

document.addEventListener("turbolinks:load", () => {
  if ($("#beertable").length == 0) {
    return
  } 
  
  $("#name").click((e) => {
    e.preventDefault()
    BEERS.sort_by_name()
    BEERS.show();
    
  })

  $("#style").click((e) => {
    e.preventDefault()
    BEERS.sort_by_style()
    BEERS.show()
  })

  $("#brewery").click((e) => {
    e.preventDefault()
    BEERS.sort_by_brewery()
    BEERS.show()
  })

  $.getJSON('beers.json', (beers) => {
    BEERS.list = beers
    BEERS.show()
  })
})