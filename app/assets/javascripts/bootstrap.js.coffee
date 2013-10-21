jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  
  $('.dropdown-menu').on('touchstart.dropdown.data-api', (e) ->
    e.stopPropagation() )
  
