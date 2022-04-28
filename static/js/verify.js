$(document).ready(function(){
    
    function update_form(action){
        if(action == 'return'){
            var url = document.getElementById('form-return-url-for').innerHTML;
            $('#modal-title').html('Devolver?')
            $('#action-button').html('Devolver ')
            $("#action-href").prop("href", url)
        }
        if(action == 'renew'){
            var url = document.getElementById('form-renew-url-for').innerHTML;
            $('#modal-title').html('Renovar?')
            $('#action-button').html('Renovar ')
            $("#action-href").prop("href", url)
        }

        $('#action-button').append(`<svg id="action-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check2-all" viewBox="1 0 16 16">
                                <path d="M12.354 4.354a.5.5 0 0 0-.708-.708L5 10.293 1.854 7.146a.5.5 0 1 0-.708.708l3.5 3.5a.5.5 0 0 0 .708 0l7-7zm-4.208 7-.896-.897.707-.707.543.543 6.646-6.647a.5.5 0 0 1 .708.708l-7 7a.5.5 0 0 1-.708 0z"/>
                                <path d="m5.354 7.146.896.897-.707.707-.897-.896a.5.5 0 1 1 .708-.708z"/>
                                </svg>`)

    }

    function verify_data(action){
        var url = document.getElementById('url').innerHTML;
        var method = document.getElementById('method').innerHTML;
    
        update_form(action);

        $.ajax({
            url:url,
            method:method,
            data: $('form#myform').serialize(),
            success:function(data)
            {
                if (data.status == 0){
                    $('#alert_title').html(data.title);
                    $('#alert_subtitle').html(data.subtitle);
                    $('#alert_msg').html(data.msg);
                    $('#alert_modal').modal('show'); 
                } else {
                    $('#action_modal').modal('show'); 
                }
            }
        });
  }

  $('#verify_button').click(function(){verify_data();});
  $('#renew_button').click(function(){verify_data('renew');});
  $('#return_button').click(function(){verify_data('return');});
  
});
