<%@include file="../taglib/taglib.jsp" %>

<section class="content">
    <div class="container-fluid">
        <div class="row row-clearfix">

            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

                <c:if test="${not empty msg_class}">
                    <div class="alert ${msg_class} alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                            ${msg}
                    </div>
                </c:if>

                <form:form method="POST" class="form-horizontal form-normal" action="qprConsolidatedReport.html"
                           enctype="multipart/form-data">

                    <div class="form-group">
                        <label for="inputFinYear" class="col-sm-4 control-label">Select Financial Year:</label>
                        <div class="col-sm-8">
                            <form:select class="form-control" id="inputFinYear" path="yearId"
                                         onchange="this.form.submit()">
                                <c:forEach var="item" items="${command.yearMap}">
                                    <c:choose>
                                        <c:when test="${item.getKey() == command.yearId}">
                                            <option value="${item.getKey()}"
                                                    selected="selected"> ${item.getValue()} </option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${item.getKey()}"> ${item.getValue()} </option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </form:select>
                        </div>
                    </div>

                    <%--@elvariable id="userPreference" type="gov.in.rgsa.user.preference.UserPreference"--%>

                    <c:if test="${userPreference.isMOPR()}">

                        <div class="form-group">
                            <label for="inputStateCode" class="col-sm-4 control-label">Select State:</label>
                            <div class="col-sm-8">
                                <form:select class="form-control" id="inputStateCode" path="stateCode"
                                             onchange="this.form.submit()">
                                    <c:forEach var="item" items="${command.stateMap}">
                                        <c:choose>
                                            <c:when test="${item.getKey() == command.stateCode}">
                                                <option value="${item.getKey()}"
                                                        selected="selected"> ${item.getValue()} </option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${item.getKey()}"> ${item.getValue()} </option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </form:select>
                            </div>
                        </div>

                    </c:if>

                </form:form>


                <!-- Data Here -->


                <div id="annualPlanBlockPrint">

                    <table
                            class="table table-hover table-bordered dashboard-task-infos"
                            id="annualReportTable">

                        <thead style="background-color: #9071bf; color: white;">
                            <tr>
                                <th rowspan="2" width="5%"></th>
                                <th rowspan="2" width="5%">Sr.No</th>
                                <th rowspan="2" width="22%">Components</th>
                                <th align="center"><b> Q1 </b></th>
                                <th align="center"><b> Q2 </b></th>
                                <th align="center"><b> Q3 </b></th>
                                <th align="center"><b> Q4 </b></th>
                            </tr>
                        </thead>

                        <c:set var="t_fund" value="0"/>
                        <c:set var="t_unit" value="0"/>
                        <tbody>
                            <%--@elvariable id="command" type="gov.in.rgsa.model.QprReportConsModel"--%>
                        <c:forEach items="${command.qprPlanFundsList}" var="pc"  varStatus="pcindex">
                            <c:if test="${pc.yearId != null}">
                                <tr id="main_${pcindex.count}">
                                    <td align="center">
                                        <a id="main_${pcindex.count}_open" onclick="expandRow(${pcindex.count})"><i class="fa fa-plus-circle" aria-hidden="true"></i></a>
                                        <a id="main_${pcindex.count}_close" class="hidden" onclick="collapseRow(${pcindex.count})"><i class="fa fa-minus-circle" aria-hidden="true"></i></a>
                                    </td>
                                    <td><b>${pcindex.count}</b></td>
                                    <td><b>${pc.planComponents.componentName}</b></td>
                                    <td><b>${pc.qtr1Expenditure + pc.qtr1AdditionalFund}</b></td>
                                    <td><b>${pc.qtr2Expenditure + pc.qtr2AdditionalFund}</b></td>
                                    <td><b>${pc.qtr3Expenditure + pc.qtr3AdditionalFund}</b></td>
                                    <td><b>${pc.qtr4Expenditure + pc.qtr4AdditionalFund}</b></td>
                                </tr>
                                <tr id="repeat_${pcindex.count}" class="hidden">
                                    <td></td>
                                    <td></td>
                                    <td>${pc.planComponents.componentName}</td>
                                    <td>${pc.qtr1Expenditure}</td>
                                    <td>${pc.qtr2Expenditure}</td>
                                    <td>${pc.qtr3Expenditure}</td>
                                    <td>${pc.qtr4Expenditure}</td>
                                </tr>
                                <tr id="add_${pcindex.count}" class="hidden">
                                    <td></td>
                                    <td></td>
                                    <td>Additional Requirements</td>
                                    <td>${pc.qtr1AdditionalFund}</td>
                                    <td>${pc.qtr2AdditionalFund}</td>
                                    <td>${pc.qtr3AdditionalFund}</td>
                                    <td>${pc.qtr4AdditionalFund}</td>
                                </tr>
                            </c:if>
                            <c:if test="${pc.yearId == null}">
                                <tr class="table_th">
                                    <th colspan="10"></th>
                                </tr>
                                <tr id="main_${pcindex.count}" class="table_th">
                                    <th></th>
                                    <th></th>
                                    <th><b>${pc.planComponentName}</b></th>
                                    <th><b>${pc.qtr1Expenditure + pc.qtr1AdditionalFund}</b></th>
                                    <th><b>${pc.qtr2Expenditure + pc.qtr2AdditionalFund}</b></th>
                                    <th><b>${pc.qtr3Expenditure + pc.qtr3AdditionalFund}</b></th>
                                    <th><b>${pc.qtr4Expenditure + pc.qtr4AdditionalFund}</b></th>
                                </tr>
                            </c:if>
                        </c:forEach>

                        <!--  -->


                        </tbody>
                    </table>
                </div>

                <!-- Data Complete -->


            </div>


        </div>
    </div>
</section>

<script>

    function Participants(rowNumber) {
        this.rowNumber = rowNumber;
        this.main_open = document.getElementById("main_" + rowNumber + "_open");
        this.main_close = document.getElementById("main_" + rowNumber + "_close");
        this.repeat = document.getElementById("repeat_" + rowNumber);
        this.additional = document.getElementById("add_" + rowNumber);
        this.hiddenClassName = "hidden";
    }

    Participants.prototype.expand = function () {
        this.main_close.classList.remove(this.hiddenClassName);
        this.main_open.classList.add(this.hiddenClassName);
        this.repeat.classList.remove(this.hiddenClassName);
        this.additional.classList.remove(this.hiddenClassName);
    }

    Participants.prototype.collapse = function () {
        this.main_open.classList.remove(this.hiddenClassName);
        this.main_close.classList.add(this.hiddenClassName);
        this.repeat.classList.add(this.hiddenClassName);
        this.additional.classList.add(this.hiddenClassName);
    }

    var ref_map = {};

    // Get cached participant if already available
    function getInstanceForRow(rowNumber) {
        if(!(rowNumber  in ref_map)) {
            ref_map[rowNumber] = new Participants(rowNumber);
        }
        return ref_map[rowNumber];
    }

    function expandRow(rowNumber) {
        getInstanceForRow(rowNumber).expand();
    }

    function collapseRow(rowNumber) {
        getInstanceForRow(rowNumber).collapse();
    }
</script>
