jQuery  ->
  cities = $('#company_city_id').html()
  $('#company_state_id').change ->
    state = $('#company_state_id :selected').text()
    options = $(cities).filter("optgroup[label='#{state}']").html()
    if options
      $('#company_city_id').html(options)
    else
      $('#company_city_id').empty()
