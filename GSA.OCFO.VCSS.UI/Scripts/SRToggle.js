function DisableHiddenValidators() {
    for (var i = 0; i < Page_Validators.length; i++) {
        var visible = $('#' + Page_Validators[i].controltovalidate).is(':visible');
        ValidatorEnable(Page_Validators[i], visible)
    }
    return Page_ClientValidate();
}

function ToggleControls() {
    var topic = $find('<%=lbTopic.ClientID %>').get_selectedItem().get_value();
    var actType = $('#<%=rbtnAccountType.ClientID %> input:checked').val();
    var updateType = $('#<%=rbtnUpdateType.ClientID %> input:checked').val();

    if (topic == "1" || topic == "2") {
        $('#utype').hide('fast');
        $('#newemail').hide('fast');

        if (actType == "V")
        { $('#vendact').show('fast'); }
        else if (actType == "C")
        { $('#custact').show('fast'); }
    }
    else if (topic == "3") {
        $('#utype').hide('fast');
        $('#vendact').hide('fast');
        $('#custact').hide('fast');
        $('#newemail').hide('fast');
    }
    else if (topic == "4") {
        $('#vendact').hide('fast');
        $('#custact').hide('fast');

        $('#utype').show('fast');
        if (updateType == "E")
        { $('#newemail').show('fast'); }
    }
}
