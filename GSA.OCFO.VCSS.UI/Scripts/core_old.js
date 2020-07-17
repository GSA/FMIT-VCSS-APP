function DisableHiddenValidators() {
    for (var i = 0; i < Page_Validators.length; i++) {
        var visible = $('#' + Page_Validators[i].controltovalidate).is(':visible');
        ValidatorEnable(Page_Validators[i], visible)
    }
    return Page_ClientValidate();
}

function DunsNumber(sender, args) {
    var textbox = $find(document.getElementById(sender.controltovalidate).id);

    if (!(/^.{9}$/.test(textbox.get_value()))) {
        args.IsValid = false;
        textbox._invalid = true;
    }
    else {
        textbox._invalid = false;
        args.IsValid = true;
    }

    textbox.updateCssClass();
}

function ZipCode(sender, args) {
    var textbox = $find(document.getElementById(sender.controltovalidate).id);

    if (!(/^.{5}$/.test(textbox.get_value()))) {
        args.IsValid = false;
        textbox._invalid = true;
    }
    else {
        textbox._invalid = false;
        args.IsValid = true;
    }

    textbox.updateCssClass();
}

function RequiredField(sender, args) {
    var textbox = $find(document.getElementById(sender.controltovalidate).id);
    if (args.Value == "") {
        textbox._invalid = true;
        args.IsValid = false;
    }
    else {
        textbox._invalid = false;
        args.IsValid = true;
    }
    textbox.updateCssClass();
}

function RequiredFieldRBTN(sender, args) {
    var radio = document.getElementById(sender.controltovalidate).getElementsByTagName("input");
    var isChecked = false;
    radio[0].parentNode.style.backgroundColor = "#FFFFFF";

    for (var i = 0; i < radio.length; i++) {
        if (radio[i].checked) {
            isChecked = true;
            break;
        }
    }

    if (!isChecked) {
        radio[0].parentNode.style.backgroundColor = "#FFD9D9";
        //        sender.show();
    }
    //    else { sender.hide(); }

    return isChecked;
}

function RequiredFieldLSBX(sender, args) {
    var listbox = $find(document.getElementById(sender.controltovalidate).id);
    args.IsValid = listbox.get_selectedItems().length > 0;
}

function RequiredFieldComboBox(sender, args) {
    var ddl = $find(document.getElementById(sender.controltovalidate).id);
    var inputArea = ddl.get_inputDomElement();

    if (ddl.get_value() == "0") {
        inputArea.style.backgroundColor = "#FFD9D9"
        args.IsValid = false;
    }
    else {
        inputArea.style.backgroundColor = "#FFFFFF"
        args.IsValid = true;
    }
}


function RequiredFieldCustomerNumber(sender, args) {
    var textbox = $find(document.getElementById(sender.controltovalidate).id);

    var text = textbox.get_value();

    if (args.Value == "") {
        textbox._invalid = true;
        args.IsValid = false;
    }
    else {
        textbox._invalid = false;
        args.IsValid = true;
    }
    textbox.updateCssClass();
}

function RequiredEmail(sender, args) {
    var textbox = $find(document.getElementById(sender.controltovalidate).id);
    if (args.Value == "") {
        textbox._invalid = true;
        args.IsValid = false;
    }
    else if (!(/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(args.Value))) {
        textbox._invalid = true;
        args.IsValid = false;
    }
    else {
        textbox._invalid = false;
        args.IsValid = true;
    }

    textbox.updateCssClass();
}

function RequiredPhoneNumber(sender, args) {
    var textbox = $find(document.getElementById(sender.controltovalidate).id);

    if (!(/^.{10}$/.test(textbox.get_value()))) {
        args.IsValid = false;
        textbox._invalid = true;
    }
    else {
        textbox._invalid = false;
        args.IsValid = true;
    }

    textbox.updateCssClass();
}


function PhoneNumber(sender, args) {
    var textbox = $find(document.getElementById(sender.controltovalidate).id);

    if (textbox.get_value() != null && textbox.get_value() != "") {
        if (!(/^.{10}$/.test(textbox.get_value()))) {
            args.IsValid = false;
            textbox._invalid = true;
        }
        else {
            textbox._invalid = false;
            args.IsValid = true;
        }
    }
    else {
        textbox._invalid = false;
        args.IsValid = true;
    }

    textbox.updateCssClass();
}

function RequiredCompare(sender, args) {
    var textbox = $find(document.getElementById(sender.controltovalidate).id);
    var ptextbox = $find(document.getElementById(sender.controltovalidate.replace('txtConfirm', 'txt')).id);
    if (args.Value == "") {
        textbox._invalid = true;
        args.IsValid = false;
    }
    else if (textbox.get_value() != ptextbox.get_value()) {
        textbox._invalid = true;
        args.IsValid = false;
    }
    else {
        textbox._invalid = false;
        args.IsValid = true;
    }

    textbox.updateCssClass();
}

function RequiredFieldDropDown(sender, args) {
    var textbox = $find(document.getElementById(sender.id.replace('cv', 'ddl')).id);
    if (args.Value == "0") {
        textbox._invalid = true;
        textbox.updateCssClass();
        args.IsValid = false;
    }
    else {
        textbox._invalid = false;
        textbox.updateCssClass();
        args.IsValid = true;
    }
}

function EmailCharactersOnly(sender, args) {
    var text = sender.get_value() + args.get_keyCharacter();
    if (!text.match('[a-zA-Z0-9.@_-]+$'))
        args.set_cancel(true);
}

function IntegersOnly(sender, args) {
    var text = sender.get_value() + args.get_keyCharacter();
    if (!text.match('^[0-9]+$'))
        args.set_cancel(true);
}

function AlphabetsOnly(sender, args) {
    var text = sender.get_value() + args.get_keyCharacter();
    if (!text.match('[a-zA-Z]+$'))
        args.set_cancel(true);
}

function AlphaNumericOnly(sender, args) {
    var text = sender.get_value() + args.get_keyCharacter();
    if (!text.match('^[a-zA-Z0-9]+$'))
        args.set_cancel(true);
}

function AlphaNumericAndHyphen(sender, args) {
    var text = sender.get_value() + args.get_keyCharacter();
    if (!text.match('^[a-zA-Z0-9-]+$'))
        args.set_cancel(true);
}

function TitleCase(sender, args) {
    var myValue = sender.get_value();
    var htext = myValue;
    htext = htext.toLowerCase();
    htext = htext.substr(0, 1).toUpperCase() + htext.substring(1, htext.length);
    for (var i = 1; i < htext.length; i++) {
        if (htext.substr(i, 1) == "-") {
            while (htext.substr(i, 1) == "-")
                i++;
            if (i + 1 < htext.length)
                htext = htext.substr(0, i) + htext.substr(i, 1).toUpperCase() + htext.substring(i + 1, htext.length);
            else
                htext = htext.substr(0, i) + htext.substr(i, 1).toUpperCase();
        }
    }

    return sender.set_value(htext);
}

function ShowDetails() {
    $(".details").click(function (e) {
        e.preventDefault();

        var id = '#' + $(this).attr('id');
        var divId = '#div' + $(this).attr('id');

        if ($(id).text() == '+ SHOW DETAILS')
            $(id).text('- HIDE DETAILS');
        else
            $(id).text('+ SHOW DETAILS');

        $(divId).slideToggle('fast');
    });
}

$(document).ready(function () {
    ShowDetails();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(ShowDetails);
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endRequest);

});

function beginRequest(sender, args) {
    // show the popup
    $find('mdlPopup').show();
}

function endRequest(sender, args) {
    //  hide the popup
    $find('mdlPopup').hide();
}
