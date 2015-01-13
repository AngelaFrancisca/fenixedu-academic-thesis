<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

${portal.toolkit()}


<div class="page-header">
  <h1>
    <spring:message code="title.thesisProposal.management"/>
    <small><spring:message code="title.thesisProposal.create"/></small>
  </h1>
</div>


<c:if test="${!empty unexistentConfigurationException}">
<p class="text-danger"><spring:message code="error.thesisProposal.create.unexistentConfigurationException"/></p>
</c:if>

<c:if test="${!empty unequivalentThesisConfigurationsException}">
<p class="text-danger"><spring:message code="error.thesisProposal.create.unequivalentThesisConfigurationsException"/></p>
</c:if>

<c:if test="${!empty illegalParticipantTypeException}">
<p class="text-danger"><spring:message code="error.thesisProposal.create.illegalParticipantTypeException"/></p>
</c:if>

<c:if test="${!empty createMaxNumberThesisProposalsException}">
<p class="text-danger"><spring:message code="error.thesisProposal.create.maxNumberThesisProposalsException"/></p>
</c:if>

<c:if test="${!empty unexistentThesisParticipantException}">
<p class="text-danger"><spring:message code="error.thesisProposal.unexistentThesisParticipantException"/></p>
</c:if>

<form:form role="form" method="POST" action="${pageContext.request.contextPath}/proposals/create" class="form-horizontal" commandname="thesisProposalBean" id="thesisProposalCreateForm">

<spring:message code='label.title' var='title'/>
<spring:message code='label.observations' var='observations'/>
<spring:message code='label.requirements' var='requirements'/>
<spring:message code='label.goals' var='goals'/>
<spring:message code='label.localization' var='localization'/>
<spring:message code='label.executionDegrees' var='executionDegrees'/>
<spring:message code='label.participants' var='participants'/>
<spring:message code='label.participantType.select' var='selectParticipantType'/>
<spring:message code='label.user' var='user'/>
<spring:message code='label.thesisProposal.participant.add' var='addParticipant'/>
<spring:message code='label.thesisProposal.participant.remove' var='removeParticipant'/>
<spring:message code='button.create' var='createButton'/>

<div class="form-group">
 <form:label for="thesisProposalTitle" path="title" class="col-sm-2 control-label">${title}</form:label>
 <div class="col-sm-10">
   <form:input type="text" class="form-control" id="thesisProposalTitle" path="title" placeholder="${title}" required="required"/>
 </div>
</div>

<div class="form-inline">
  <label class="col-sm-2 control-label">${participants}</label>
  <div id="tableBody">
    <div class="col-sm-offset-2 col-sm-10">
      <div class="tableRow">
        <div class="form-group">
          <div class="col-sm-10">
            <input type="text" class="form-control" id="UserExternalId" bennu-user-autocomplete placeholder="${user}" required="required"/>
          </div>
        </div>
        <div class="form-group">
          <div class="col-sm-10">
            <select id="selectParticipantType" class="form-control">
              <option value="" label="${selectParticipantType}"/>
              <c:forEach var="participantType" items="${participantTypeList}">
              <option value="${participantType.externalId}" label="${participantType.name.content}"/>
            </c:forEach>
          </select>
        </div>
      </div>
      <div class="form-group">
        <div class="col-sm-12">
          <a href="#" class="removeParticipant">${removeParticipant}</a>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="col-sm-offset-2 col-sm-10">
  <a href="#" id="addParticipant">${addParticipant}</a>
</div>
</div>

<div class="form-group">
  <form:label for="thesisProposalGoals" path="goals" class="col-sm-2 control-label">${goals}</form:label>
  <div class="col-sm-10">
    <form:textarea rows="5" class="form-control" id="thesisProposalGoals" path="goals" placeholder="${goals}"/>
  </div>
</div>

<div class="form-group">
  <form:label for="thesisProposalRequirements" path="requirements" class="col-sm-2 control-label">${requirements}</form:label>
  <div class="col-sm-10">
    <form:textarea rows="5" class="form-control" id="thesisProposalRequirements" path="requirements" placeholder="${requirements}"/>
  </div>
</div>

<div class="form-group">
  <form:label for="thesisProposalLocalization" path="localization" class="col-sm-2 control-label">${localization}</form:label>
  <div class="col-sm-10">
    <form:input type="text" class="form-control" id="thesisProposalLocalization" path="localization" placeholder="${localization}"/>
  </div>
</div>

<input type="hidden" name="participantsJson" id="participantsJson"/>

<div class="form-group">
  <form:label for="thesisProposalObservations" path="observations" class="col-sm-2 control-label">${observations}</form:label>
  <div class="col-sm-10">
    <form:textarea rows="5" class="form-control" id="thesisProposalObservations" path="observations" placeholder="${observations}"/>
  </div>
</div>

<div class="form-group">
  <label class="col-sm-2 control-label">${executionDegrees}</label>
  <div class="col-sm-10" id="configurationsSelect">
    <c:forEach items="${configurations}" var="configuration">
    <form:checkbox path="thesisProposalsConfigurations" value="${configuration.externalId}" onClick="checkboxListener(this)" name="thesisProposalsConfigurations"/>${configuration.executionDegree.presentationName}
    <br>
  </c:forEach>
</div>
</div>

<br>
<br>
<div class="col-sm-offset-2 col-sm-10">
  <button type="submit" class="btn btn-default" id="submitButton" disabled="true">${createButton}</button>
</div>

</form:form>

<script type="text/html" id="participantRowTemplate">
  <div class="col-sm-offset-2 col-sm-10">
    <div class="tableRow">
     <div class="form-group">
       <div class="col-sm-10">
         <input type="text" class="form-control" id="UserExternalId" bennu-user-autocomplete placeholder="${user}" required="required"/>
       </div>
     </div>
     <div class="form-group">
       <div class="col-sm-10">
        <select id="selectParticipantType" class="form-control">
          <option value="NONE" label="${selectParticipantType}"/>
          <c:forEach var="participantType" items="${participantTypeList}">
          <option value="${participantType.externalId}" label="${participantType.name.content}"/>
        </c:forEach>
      </select>
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-12">
      <a href="#" class="removeParticipant">${removeParticipant}</a>
    </div>
  </div>
</div>
</div>
</script>

<script type="text/javascript">
  var onRemoveParticipant = function(e) {
    $(this).closest(".tableRow").remove();
  };
  $("#addParticipant").on("click", function(e) {
    var addedRow = $("#tableBody").append($("#participantRowTemplate").html());
    $(".removeParticipant", addedRow).on("click", onRemoveParticipant);
  });
  $(".removeParticipant").on("click", onRemoveParticipant);
  $("#submitButton").on("click", function(e) {
    var participantsJSON = {
      participants: []
    };
    var participants = $("#tableBody").find(".tableRow");

    for (index=0; index < participants.length; index++) {
      participant = participants.eq(index)
      user = participant.find("#UserExternalId").val()
      participantType = participant.find("#selectParticipantType").val()
      participantsJSON.participants.push({
        "userId" : user,
        "userType" : participantType
      });
    }
    $("#participantsJson").val(JSON.stringify(participantsJSON.participants));
  });
  function checkboxListener(e) {
    if($("#configurationsSelect").children(":checked").size() > 0) {
      $("#submitButton").attr("disabled", false);
    }
    else {
      $("#submitButton").attr("disabled", true);
    }
  }
  $(document).ready(checkboxListener(null));
</script>
