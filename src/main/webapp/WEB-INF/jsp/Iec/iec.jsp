<%@include file="../taglib/taglib.jsp" %>
<html>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/multiselect/slimselect.min.css"
      type="text/css"/>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/plugins/multiselect/slimselect.min.js"></script>
<style>
    .form-group .form-control.normalbox{
        border: 1px solid #ccc;
        border-radius: 4px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
        box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
        -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
        -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
        transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    }
</style>
<section class="content">
    <script type="text/javascript">
        var delTrainingIdArr = [];
        $(document).ready(function () {
            $("#mytable").on('input', '.txtCal', function () {
                var calculated_total_sum = 0;

                $("#mytable .txtCal").each(function () {
                    var get_textbox_value = $(this).val();
                    if ($.isNumeric(get_textbox_value)) {
                        calculated_total_sum += parseFloat(get_textbox_value);
                    }
                });
                document.getElementById("grandtotal").value = calculated_total_sum;
            });

            new SlimSelect({
                select: '.the-multiselect'
            });
        });

        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }

        $('document').ready(function () {
            $(".reset").bind("click", function () {
                $("input[type=text]").val('');
            });
            /* calculateGrandTotal(); */
            // markAdded();
        });

        function addRow(userType) {
            var rowCount = $('#mytable tr').length;
            var i = rowCount - 1;
            var tds = '<tr>';
            var genId = 'selectDropDownId_' + i;
            tds += '<td><select  name="iecActivity.iecActivityDetails[' + i + '].iecActivityDropedown.iecId" class="the-multiselect" data-live-search="true" id="' + genId + '"  multiple="multiple"><option data-placeholder="true">SELECT ACTIVITY</option>'+
                '<c:forEach items="${NATURE_IEC_LIST}" var="IEC_ACTIVITIES"><option value="${IEC_ACTIVITIES.iecId}" > ${IEC_ACTIVITIES.natureIecActivity}</option></c:forEach></select></td>';
            tds += '<td><input  type="number" name="iecActivity.iecActivityDetails[' + i + '].totalAmountProposed" min="1" max="99999999" onchange="findTotal"  Class=" active123 form-control txtCal validate "  placeholder="Total Amount Proposed" style="text-align: right;" required /></td>';
            /* tds+='<td><input  type="text" name="iecActivity.iecActivityDetails['+i+'].totalAmountProposed" min="1"   onchange="findTotal"  Class=" active123 form-control txtCal Align-Right" onkeypress="return isNumber(event)"  placeholder="Total Amount Proposed" required/></td>'; */
            if (userType == "M") {
                tds += '<td><input type="textarea" name="iecActivity.iecActivityDetails[' + i + '].remarks" Class=" active123 form-control" rows="2" cols="4" required /></td>';
            }
            if (userType == "C") {
                tds += '<td><input type="textarea" name="iecActivity.iecActivityDetails[' + i + '].remarks" Class=" active123 form-control" rows="2" cols="4" required /></td>';
            }
            tds += '<td><input type="button" value="Delete" onclick = "removeRow()" class=" activedelete btn btn-danger waves-effect"/></td>';
            tds += '</tr>';
            $('#mytable tr:last').after(tds);
            i = i++;
            markAdded(genId);
        }

        function removeRow() {
            if ($('#mytable tr').length > 2) {
                $('#mytable tr:last').remove();
                i--;
                // markDeleted();
            }
        }

        function toDelete(idToDelete, disabledID) {

            if (!delTrainingIdArr.includes(idToDelete)) {
                delTrainingIdArr.push(idToDelete);

                $("#delete" + idToDelete).val('Undo');
                $("#selectDropDownId_" + disabledID).prop('disabled', true);
                $("#getTotal" + disabledID).prop('disabled', true);


            } else {
                var index = delTrainingIdArr.indexOf(idToDelete);
                if (index > -1) {
                    delTrainingIdArr.splice(index, 1);
                }
                $("#delete" + idToDelete).val('Delete');
                $("#selectDropDownId_" + disabledID).prop('disabled', false);
                $("#getTotal" + disabledID).prop('disabled', false);
            }

            if (delTrainingIdArr.length > 0) {
                document.getElementById("idToDeleteStr").value = delTrainingIdArr.toString();
            }
        }

        function freezeAndUnfreeze(obj) {
            if (obj == "unfreeze") {
                $('.activedrop').attr('disabled', false);

                $('.active123').attr('disabled', false);
            }
            document.getElementById("dbFileName").value = obj;
            document.IecName.method = "post";
            document.IecName.action = "freezAndUnfreezIEC.html?<csrf:token uri='freezAndUnfreezIEC.html'/>";
            document.IecName.submit();
        }

        function validateForm() {
            var rowCount = $('#mytable tr').length;
            var index = rowCount - 1;
            for (var j = 0; j < index; j++) {
                if ($("#selectDropDownId_" + j).val() === "" || $("#selectDropDownId_" + j).val() === null) {
                    alert("Please select an activity from the list.");
                    return false;
                }
            }
            return true;
        }

        var alreadyAdded = [];

        function markAdded() {
            $('select.the-multiselect').each(function(){
                var sid = $(this).attr('id');
                if(!sid)
                    return;
                if(!(sid in alreadyAdded)){
                    var sidSelector = '#'+sid;
                    var slimSelect = new SlimSelect({
                        select: sidSelector
                    });
                }
            });
        }

        function markDeleted(delId) {
            if(delId in alreadyAdded) {
                delete alreadyAdded[delId];
            }
        }
    </script>
    <div class="container-fluid">
        <div class="row clearfix">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="card">
                    <div class="header">
                        <h2><spring:message code="Label.ProposalForIEC" htmlEscape="true"/></h2>
                    </div>

                    <div class="body">


                    <form:form method="POST" name="IecName" action="iec.html"
                               id="iecId" modelAttribute="IEC_ACTIVITY" path="iec" onsubmit="return validateForm()">

                        <form:input path="iecId" type="hidden"/>

                        <div class="form-group">
                            <label><spring:message code="Label.NatureOfTheIECActivity" htmlEscape="true"/>:</label>
                            <form:select multiple="true" path="selectedId"
                                         items="${iecActivityComponents}" itemValue="iecId" itemLabel="natureIecActivity"
                                         class="the-multiselect" disabled="${ IEC_ACTIVITY.getFreeze() ? 'true' : 'false'}"/>
                            <%--<form:select
                                    path="iecActivity.iecActivityDetails[0].iecActivityDropedown.iecId"
                                    class="the-multiselect"
                                    data-live-search="true"  multiple="multiple">
                                <option data-placeholder="true">SELECT ACTIVITY</option>
                                <c:forEach items="${NATURE_IEC_LIST}"
                                           var="IEC_ACTIVITIES1">
                                    <form:option value="${IEC_ACTIVITIES1.iecId}">
                                        ${IEC_ACTIVITIES1.natureIecActivity}
                                    </form:option>
                                </c:forEach>
                            </form:select>--%>
                        </div>
                        <div class="form-group">
                            <label for="amount_box"><spring:message code="Label.AmountProposed" htmlEscape="true"/>:</label>
                            <form:input type="number"
                                        path="amount"
                                        min="1"
                                        max="99999999"
                                        class="no-scroll normalbox form-control"
                                        placeholder="Total Amount Proposed"
                                        disabled="${ IEC_ACTIVITY.getFreeze() ? 'true' : 'false'}"
                                        id="amount_box"/>
                        </div>
                        <c:if test="${ !IEC_ACTIVITY.getFreeze() }"><input type="submit" name="action" value="SAVE" class="btn bg-green waves-effect"/></c:if>
                        <input type="submit" name="action" value="${ IEC_ACTIVITY.getFreeze() ? 'UNFREEZE':'FREEZE'}" class="btn bg-green waves-effect"/>
                        <button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')" class="btn bg-orange waves-effect">
                            <spring:message code="Label.CLOSE" text="Close" htmlEscape="true"/>
                        </button>


                        <%--
                        <input type="hidden" name="<csrf:token-name/>"
                               value="<csrf:token-value uri="iec.html"/>"/>
                        <input type="hidden" name="iecActivity.userType" value="${IEC_LIST.userType}"/>

                        <div class="body">
                            <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'S'}">
                                <div align="right">
                                    <c:if test="${IEC_LIST.isFreez eq true}">
                                        <button type="button"
                                                onclick="addRow('${sessionScope['scopedTarget.userPreference'].userType}')"
                                                class="activeadd btn bg-green waves-effect" disabled="disabled">
                                            <i class="fa fa-plus"></i><spring:message code="Label.AddNewRow"
                                                                                      htmlEscape="true"/>
                                        </button>
                                    </c:if>
                                    <c:if test="${IEC_LIST.isFreez eq false}">
                                        <button type="button"
                                                onclick="addRow('${sessionScope['scopedTarget.userPreference'].userType}')"
                                                class="activeadd btn bg-green waves-effect">
                                            <i class="fa fa-plus"></i><spring:message code="Label.AddNewRow"
                                                                                      htmlEscape="true"/>
                                        </button>
                                    </c:if>

                                </div>
                            </c:if>
                            <div class="card">
                                <div>
                                    <table class="table table-bordered" id="mytable">
                                        <thead>
                                        <tr>
                                            <th scope="col">
                                                <div align="center">
                                                    <strong><spring:message code="Label.NatureOfTheIECActivity"
                                                                            htmlEscape="true"/></strong>
                                                </div>
                                            </th>
                                            <th scope="col">
                                                <div align="center">
                                                    <strong><spring:message code="Label.AmountProposed"
                                                                            htmlEscape="true"/></strong>
                                                </div>
                                            </th>
                                            <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
                                                <th><spring:message code="Label.IsApproved" htmlEscape="true"/></th>
                                                <th scope="col">
                                                    <div align="center">
                                                        <strong><spring:message code="Label.Remarks"
                                                                                htmlEscape="true"/></strong>
                                                    </div>
                                                </th>
                                            </c:if>
                                            <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
                                                <th><spring:message code="Label.IsApproved" htmlEscape="true"/></th>
                                                <th scope="col">
                                                    <div align="center">
                                                        <strong><spring:message code="Label.Remarks"
                                                                                htmlEscape="true"/></strong>
                                                    </div>
                                                </th>
                                            </c:if>
                                        </tr>
                                        </thead>
                                        <tbody id="newBody">
                                        <c:forEach items="${IEC_LIST.iecActivityDetails}" var="iecActivityDetails"
                                                   varStatus="count">
                                            <c:set var="totalFundToCalc"
                                                   value="${totalFundToCalc + iecActivityDetails.totalAmountProposed}"></c:set>
                                            <input type="hidden"
                                                   name="iecActivity.iecActivityDetails[${count.index}].idMain"
                                                   value="${iecActivityDetails.idMain}"/>

                                            <tr id="newRow">
                                                <td><form:select
                                                        path="iecActivity.iecActivityDetails[${count.index}].iecActivityDropedown.iecId"
                                                        id="selectDropDownId_${count.index}"
                                                        class="the-multiselect"
                                                        disabled="${IEC_LIST.isFreez eq true}" multiple="multiple">
                                                    <c:forEach items="${NATURE_IEC_LIST}" var="IEC_ACTIVITIES1">
                                                        <c:choose>
                                                            <c:when test="${iecActivityDetails.iecActivityDropedown.iecId == IEC_ACTIVITIES1.iecId}">
                                                                <form:option value="${IEC_ACTIVITIES1.iecId}"
                                                                             selected="true">${IEC_ACTIVITIES1.natureIecActivity}</form:option>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:if test="${iecActivityDetails.iecActivityDropedown.iecId eq null || iecActivityDetails.iecActivityDropedown.iecId eq 0}">
                                                                    <option data-placeholder="true">SELECT ACTIVITY</option>
                                                                </c:if>
                                                                <form:option
                                                                        value="${IEC_ACTIVITIES1.iecId}">${IEC_ACTIVITIES1.natureIecActivity}</form:option>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </form:select></td>
                                                <c:choose>
                                                    <c:when test="${IEC_LIST.isFreez eq true}">
                                                        <td><input type="number"
                                                                   value="${iecActivityDetails.totalAmountProposed}"
                                                                   name="iecActivity.iecActivityDetails[${count.index}].totalAmountProposed"
                                                                   min="1"
                                                                   Class="  active123 form-control txtCal Align-Right"
                                                                   placeholder="Total Amount Proposed"
                                                                   id="getTotal${count.index}"
                                                                   onchange="findTotal();" required
                                                                   oninvalid="this.setCustomValidity('Entered value greater than 99999999')"
                                                                   oninput="setCustomValidity('')"
                                                                   onkeypress="return isNumber(event)" max="99999999"
                                                                   readonly="readonly"/></td>
                                                        <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
                                                            <c:choose>
                                                                <c:when test="${iecActivityDetails.isApproved eq true}">
                                                                    <td><input type="checkbox"
                                                                               name="iecActivity.iecActivityDetails[${count.index}].isApproved"
                                                                               Class=" active123 " checked="checked"
                                                                               disabled="disabled"/></td>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <td><input type="checkbox"
                                                                               name="iecActivity.iecActivityDetails[${count.index}].isApproved"
                                                                               readonly="readonly"/></td>
                                                                </c:otherwise>
                                                            </c:choose>

                                                            <td><input type="text"
                                                                       name="iecActivity.iecActivityDetails[${count.index}].remarks"
                                                                       value="${iecActivityDetails.remarks}"
                                                                       Class=" active123 form-control"
                                                                       placeholder="remarks"
                                                                       required disabled="disabled"/></td>
                                                        </c:if>
                                                        <td><input id="delete${iecActivityDetails.idMain}" type="button"
                                                                   value="Delete"
                                                                   class=" activedelete btn btn-danger waves-effect"
                                                                   onclick='toDelete("${iecActivityDetails.idMain}","${count.index}");'
                                                                   disabled="disabled"/></td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td><input type="number"
                                                                   value="${iecActivityDetails.totalAmountProposed}"
                                                                   name="iecActivity.iecActivityDetails[${count.index}].totalAmountProposed"
                                                                   min="1"
                                                                   Class="  active123 form-control txtCal Align-Right"
                                                                   placeholder="Total Amount Proposed"
                                                                   id="getTotal${count.index}"
                                                                   onchange="findTotal();" required
                                                                   oninvalid="this.setCustomValidity('Entered value greater than 99999999')"
                                                                   oninput="setCustomValidity('')"
                                                                   onkeypress="return isNumber(event)" max="99999999"/>
                                                        </td>
                                                        <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
                                                            <c:choose>
                                                                <c:when test="${iecActivityDetails.isApproved eq true}">
                                                                    <td><input type="checkbox"
                                                                               name="iecActivity.iecActivityDetails[${count.index}].isApproved"
                                                                               checked="checked"/></td>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <td><input type="checkbox"
                                                                               name="iecActivity.iecActivityDetails[${count.index}].isApproved"/>
                                                                    </td>
                                                                </c:otherwise>
                                                            </c:choose>

                                                            <td><input type="text"
                                                                       name="iecActivity.iecActivityDetails[${count.index}].remarks"
                                                                       value="${iecActivityDetails.remarks}"
                                                                       Class=" active123 form-control"
                                                                       placeholder="remarks"
                                                                       required/></td>
                                                        </c:if>
                                                        <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
                                                            <c:choose>
                                                                <c:when test="${iecActivityDetails.isApproved eq true}">
                                                                    <td><input type="checkbox"
                                                                               name="iecActivity.iecActivityDetails[${count.index}].isApproved"
                                                                               checked="checked"/></td>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <td><input type="checkbox"
                                                                               name="iecActivity.iecActivityDetails[${count.index}].isApproved"/>
                                                                    </td>
                                                                </c:otherwise>
                                                            </c:choose>

                                                            <td><input type="text"
                                                                       name="iecActivity.iecActivityDetails[${count.index}].remarks"
                                                                       value="${iecActivityDetails.remarks}"
                                                                       Class=" active123 form-control"
                                                                       placeholder="remarks"
                                                                       required/></td>
                                                        </c:if>
                                                        <td><input id="delete${iecActivityDetails.idMain}" type="button"
                                                                   value="Delete"
                                                                   class=" activedelete btn btn-danger waves-effect"
                                                                   onclick='toDelete("${iecActivityDetails.idMain}","${count.index}");'/>
                                                        </td>
                                                    </c:otherwise>
                                                </c:choose>

                                            </tr>
                                        </c:forEach>

                                        <c:if test="${empty IEC_LIST}">
                                            <tr>
                                                <td><form:select
                                                        path="iecActivity.iecActivityDetails[0].iecActivityDropedown.iecId"
                                                        class="the-multiselect"
                                                        data-live-search="true"  multiple="multiple">
                                                     <option data-placeholder="true">SELECT ACTIVITY</option>
                                                    <c:forEach items="${NATURE_IEC_LIST}"
                                                               var="IEC_ACTIVITIES1">
                                                        <form:option value="${IEC_ACTIVITIES1.iecId}">
                                                            ${IEC_ACTIVITIES1.natureIecActivity}
                                                        </form:option>
                                                    </c:forEach>
                                                </form:select></td>

                                                <td id="totalSum"><input type="number"
                                                                         name="iecActivity.iecActivityDetails[0].totalAmountProposed"
                                                                         oninvalid="this.setCustomValidity('Entered value greater than 0')"
                                                                         oninput="setCustomValidity('')" max="99999999"
                                                                         Class=" active123  txtCal  form-control Align-Right"
                                                                         min="1"
                                                                         placeholder="Total Amount Proposed"
                                                                         onkeypress="return isNumber(event)"></td>
                                                <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
                                                    <td><input type="checkbox"
                                                               name="iecActivity.iecActivityDetails[0].isApproved"
                                                               value="${iecActivityDetails.isApproved}"/></td>
                                                    <td><input type="text"
                                                               name="iecActivity.iecActivityDetails[0].remarks"
                                                               Class=" active123 form-control" required></td>
                                                </c:if>
                                                <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'C'}">
                                                    <td><input type="checkbox"
                                                               name="iecActivity.iecActivityDetails[0].isApproved"
                                                               value="${iecActivityDetails.isApproved}"/></td>
                                                    <td><input type="text"
                                                               name="iecActivity.iecActivityDetails[0].remarks"
                                                               Class=" active123 form-control" required></td>
                                                </c:if>
                                            </tr>
                                        </c:if>
                                        </tbody>
                                    </table>
                                    <table class="table table-bordered" id="TotalTable">
                                        <tr>
                                            <th><label><spring:message code="Label.TotalAmountProposed"
                                                                       htmlEscape="true"/></label></th>
                                            <td>
                                                <div style="margin-left: 31%" class="col-sm-4">
                                                    <input type="text" style="background: #dddddd;"
                                                           class="form-control Align-Right" id="grandtotal"
                                                           value="${totalFundToCalc}" disabled="disabled">
                                                </div>
                                            </td>
                                        </tr>
                                    </table>

                                </div>
                            </div>

                        </div>
                        <c:if test="${sessionScope['scopedTarget.userPreference'].userType eq 'M'}">
                            <div class="col-md-4  text-left" style="margin-bottom: 5px">
                                &nbsp;&nbsp;<button type="button"
                                                    onclick="onClose('viewPlanDetails.html?<csrf:token
                                                            uri='viewPlanDetails.html'/>&stateCode=${STATE_CODE}')"
                                                    class="btn bg-orange waves-effect">
                                <i class="fa fa-arrow-left" aria-hidden="true"></i>
                                <spring:message code="Label.BACK" htmlEscape="true"/>
                            </button>
                                <br>
                            </div>
                        </c:if>
                        <div class="text-right">
                            <c:if test="${Plan_Status eq true}">
                                <c:if test="${IEC_LIST.isFreez eq false || empty IEC_LIST}">

                                    <button type="submit" class="btn bg-green waves-effect" id="save"><spring:message
                                            code="Label.SAVE" text="Save" htmlEscape="true"/></button>
                                    <c:if test="${IEC_LIST.isFreez  != undefined}">
                                        <button type="button" onclick='freezeAndUnfreeze("freeze")'
                                                class="btn bg-green waves-effect" id="FREEZE"><spring:message
                                                code="Label.FREEZE" text="Freeze" htmlEscape="true"/></button>
                                    </c:if>
                                    <button type="button" class="btn bg-light-blue waves-effect reset" id="clearId"
                                            onclick="onClear(this)"><spring:message code="Label.CLEAR" text="Clear"
                                                                                    htmlEscape="true"/></button>
                                </c:if>


                                <c:if test="${IEC_LIST.isFreez eq true}">
                                    <button type="button" onclick='freezeAndUnfreeze("unfreeze")'
                                            class="btn bg-green waves-effect" id="UNFREEZE"><spring:message
                                            code="Label.UNFREEZE" text="Unfreeze" htmlEscape="true"/></button>
                                </c:if>
                            </c:if>

                            <button type="button" onclick="onClose('home.html?<csrf:token uri='home.html'/>')"
                                    class="btn bg-orange waves-effect"><spring:message code="Label.CLOSE" text="Close"
                                                                                       htmlEscape="true"/></button>
                            <input type="hidden" name="iecActivity.dbFileName" id="dbFileName"/>
                            <input type="hidden" name="iecActivity.id" value="${IEC_LIST.id}"/>
                            <input type="hidden" name="idToDelete" id="idToDelete"/>
                            <input type="hidden" name="idToDeleteStr" id="idToDeleteStr"/>
                            <input type="hidden" name="iecActivity.isfreez" id="isfreez"/>
                        </div>
                        --%>
                    </form:form>
                    </div>


                </div>
            </div>
        </div>
        <%-- </c:when>
        <c:otherwise>
        </c:otherwise>
        </c:choose> --%>
    </div>
</section>
</html>
<!-- <script>
$('document').ready(function(){
if( '${readOnlyEnabled}' == 'true'){
$('.active123').prop('readonly',true);
$('.activedrop').attr('disabled',true);
$('.activeadd').prop('disabled',true);
$('.activedelete').prop('disabled',true);
$('#save').prop('disabled',true);
$('#CLEAR').prop('disabled',true);
$('#FREEZE').hide();
$('#UNFREEZE').show();
}
else{
$('.active123').prop('readonly' ,false);
$('.activedrop').attr('disabled',false);
$('.activeadd').prop('disabled',false);
$('.activedelete').prop('disabled',false);
$('#UNFREEZE').hide();
$('#FREEZE').show();
}
});
</script> -->
<style>
    .Align-Right {
        text-align: right;
    }
</style>
<script type="text/javascript">
    $(document).ready(function () {

        $(".validate").keypress(function (e) {
            //if the letter is not digit then display error and don't type anything
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                /*   //display error message */
                $("#errmsg").html("Digits Only").show().fadeOut("slow");
                return false;
            }
        });
    });
</script>
