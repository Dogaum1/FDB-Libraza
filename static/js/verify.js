$(document).ready(function(){

    function verifyData(){
        var url = document.getElementById('url').innerHTML;
        var method = document.getElementById('method').innerHTML;
    
        $.ajax({
            url:url,
            method:method,
            data: $('form#myform').serialize(),
            success:function(data){
                switch(data.status) {
                    case 0:
                        $('#alert_title').html(data.title);
                        $('#alert_subtitle').html(data.subtitle);
                        $('#alert_msg').html(data.msg);
                        $('#alert_modal').modal('show'); 
                        break;
                    case 1:
                        $('#action_modal').modal('show'); 
                        break;
                    case 2:
                        $('#remove-erro-msg').html(data.subtitle); 
                        break;
                    case 3:
                        $('#myform').submit(); 
                        break;
                    default:
                        break;
                }
            }
        });
    }

    $('#verify_button').click(function(){verifyData();});


    function updateForm(action){

        var action_button_icon = (`<svg id="action-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check2-all" viewBox="1 0 16 16">
                                <path d="M12.354 4.354a.5.5 0 0 0-.708-.708L5 10.293 1.854 7.146a.5.5 0 1 0-.708.708l3.5 3.5a.5.5 0 0 0 .708 0l7-7zm-4.208 7-.896-.897.707-.707.543.543 6.646-6.647a.5.5 0 0 1 .708.708l-7 7a.5.5 0 0 1-.708 0z"/>
                                <path d="m5.354 7.146.896.897-.707.707-.897-.896a.5.5 0 1 1 .708-.708z"/>
                                </svg>`)

        switch(action) {
            case 'return':
                var verify_url = document.getElementById('verify-return-url').innerHTML;
                var action_url = document.getElementById('form-return-url').innerHTML;
                $('#modal-title').html('Devolver?')
                $('#action-button').html('Devolver ' + action_button_icon)
                break;
            case 'renew':
                var verify_url = document.getElementById('verify-renew-url').innerHTML;
                var action_url = document.getElementById('form-renew-url').innerHTML;
                $('#modal-title').html('Renovar?')
                $('#action-button').html('Renovar ' + action_button_icon)
                break;
            
            default:
                break;
        }

        return {
            'verify_url' : verify_url,
            'action_url': action_url
        };

    }


    function renewReturn(action){

        let { verify_url, action_url } = updateForm(action);

        $.ajax({
            url: verify_url,
            success: function (data) {
                switch(data.status) {
                    case 0:
                        $('#alert_title').html(data.title);
                        $('#alert_subtitle').html(data.subtitle);
                        $('#alert_msg').html(data.msg);
                        $('#alert_modal').modal('show'); 
                        break;
                        case 1:
                        $("#action_href").prop("href",  action_url)
                        $('#action_modal').modal('show'); 
                        break;
                   
                    default:
                        break;
                }
            }
        });
    }

  $('#renew_button').click(function(){renewReturn('renew');});
  $('#return_button').click(function(){renewReturn('return');});
  
});
