<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<jcr:nodeProperty node="${currentNode}" name="type" var="eventCategory"/>
<jcr:nodeProperty node="${currentNode}" name="tags" var="eventKeywords"/>
<jcr:nodeProperty node="${currentNode}" name="location" var="eventLocation"/>
<jcr:nodeProperty node="${currentNode}" name="startDate" var="eventStartDate"/>
<jcr:nodeProperty node="${currentNode}" name="endDate" var="eventEndDate"/>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="eventTitle"/>
<jcr:nodeProperty node="${currentNode}" name="complementaryInfo" var="eventComplementaryInfo"/>
<jcr:nodeProperty node="${currentNode}" name="complementaryDate" var="eventComplementaryDate"/>
<jcr:nodeProperty node="${currentNode}" name="displayTime" var="eventDisplayTime"/>
<jcr:nodeProperty node="${currentNode}" name="rsvp" var="eventRsvp"/>
<jcr:nodeProperty node="${currentNode}" name="description" var="eventDescription"/>
<jcr:nodeProperty node="${currentNode}" name="multimediaTag" var="eventMultimediaTag"/>

<div class="event-list-entry">
  
  <!-- ELEMENT MULTIMEDIA -->
  <div class="multimedia-element">
<%-- TODO : Filtre qui récupère le tag multimedia et affiche l'élément --%>
    <c:if test="${not empty eventMultimediaTag}">
      ${eventMultimediaTag.string}
  	</c:if>
  </div>
  
  <!-- PARTIE DROITE -->
  <div class="event-list-description">
    
    <!-- TITRE -->
    <h2>
      <c:if test="${not empty eventTitle}">
        <c:url var="eventDetailUrl" value="${currentNode.url}" />
        <a title="${eventTitle.string}" href="${eventDetailUrl}">
          ${eventTitle.string}
        </a>
      </c:if>
    </h2>
    
    <!-- DATE -->
<!-- TODO Quid même heure de début et de fin le même jour ? -->
    <c:set var="datePattern" value="dd.MM.yyyy" />
    <c:set var="hourPattern" value="hh:mm" />
    
    <c:if test="${not empty eventStartDate}">
      <c:set var="formattedEventStartDate">
        <fmt:formatDate pattern="${datePattern}" value="${eventStartDate.date.time}"/>
      </c:set>
      <c:set var="formattedEventStartHour">
        <fmt:formatDate pattern="${hourPattern}" value="${eventStartDate.date.time}"/>
      </c:set>
    </c:if>
    
    <c:if test="${not empty eventEndDate}">
      <c:set var="formattedEventEndDate">
        <fmt:formatDate pattern="${datePattern}" value="${eventEndDate.date.time}"/>
      </c:set>
      <c:set var="formattedEventEndHour">
        <fmt:formatDate pattern="${hourPattern}" value="${eventEndDate.date.time}"/>
      </c:set>
    </c:if>
    
    <c:set var="sameDate" value="false" />
    <c:if test="${not empty eventStartDate and not empty eventEndDate}">
      <c:if test="${formattedEventStartDate == formattedEventEndDate}">
        <c:set var="sameDate" value="true" />
      </c:if>
    </c:if>
    
    <c:if test="${not empty eventStartDate or not empty eventEndDate}">
      <div class="date">
        <c:if test="${not empty eventStartDate}">
          ${formattedEventStartDate}
          <c:if test="${sameDate == true}">
            <c:if test="${not empty eventDisplayTime and eventDisplayTime.boolean == true}">
              , ${formattedEventStartHour} - ${formattedEventEndHour}
            </c:if>
          </c:if>
          <c:if test="${not empty eventDisplayTime and eventDisplayTime.boolean == true}">
            <c:if test="${sameDate == false}">
              &nbsp;${formattedEventStartHour}
            </c:if>
          </c:if>
        </c:if>
        <c:if test="${sameDate == false}">
          <c:if test="${not empty eventEndDate}">
            <c:if test="${not empty eventStartDate}">
              &nbsp;-&nbsp;
            </c:if>
            ${formattedEventEndDate}
            <c:if test="${not empty eventDisplayTime and eventDisplayTime.boolean == true}">
              &nbsp;${formattedEventEndHour}
            </c:if>
          </c:if>
        </c:if>
      </div>
    </c:if>
    
    <!-- INFORMATIONS COMPLEMENTAIRES -->
    <div class="complementary">
      <c:if test="${not empty eventComplementaryInfo}">
        ${eventComplementaryInfo.string}
      </c:if>
      <c:if test="${not empty eventComplementaryDate}">
        <c:if test="${not empty eventComplementaryInfo}">
          ,&nbsp;
        </c:if>
        <fmt:formatDate pattern="dd.MM.yyyy, hh:mm" value="${eventComplementaryDate.date.time}"/>
      </c:if>
    </div>
    
    <!-- LIEU -->
    <div class="place">
      <c:if test="${not empty eventLocation}">
        ${eventLocation.string}
      </c:if>
    </div>
    
<!-- TODO : Appliquer le filtre -->
    <!-- DESCRIPTION -->
    <c:if test="${not empty eventDescription}">
      ${eventDescription.string}
    </c:if>
    
    <!-- CATEGORIE - MOTS CLE -->
    <div class="category">
      <fmt:message key="label.category"/>&nbsp;:&nbsp;
      <c:if test="${not empty eventCategory}">
<!-- TODO : Lien de recherche, facet ? -->
        <a href="#">
          ${eventCategory.node.displayableName}
        </a>
      </c:if>
      <fmt:message key="label.keywords"/>
      <c:if test="${not empty eventKeywords}">&nbsp;:&nbsp;
        <c:forEach items="${eventKeywords}" var="eventKeyword" varStatus="status">
<!-- TODO : Lien de recherche, facet ? -->
          <c:if test="${status.count > 1}">
            &nbsp;-&nbsp;
          </c:if>
          <a href="#">
            ${eventKeyword.node.displayableName}
          </a>
        </c:forEach>
      </c:if>
    </div>
    
    <!-- ACTIONS -->
    <div class="event-actions">
      <c:if test="${not empty eventRsvp}">
        <a class="btn btn-mail" href="mailto:${eventRsvp.string}">
          <span>
            <fmt:message key="label.sendMail"/>
          </span>
        </a>
      </c:if>
      <a class="btn btn-calendar" href="#">
        <span>
          <fmt:message key="label.addToCalendar"/>
        </span>
      </a>
      <a class="btn btn-external" href="#">
        <span>
          <fmt:message key="label.externalSite"/>
        </span>
      </a>
    </div>
    
  </div>
</div>