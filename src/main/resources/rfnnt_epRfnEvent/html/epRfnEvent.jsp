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

<div class="event-page">
  <div class="row">
    <div class="border-right col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <h2>
        <c:if test="${not empty eventTitle}">
          ${eventTitle.string}
        </c:if>
      </h2>
      <div class="date">
<!-- TODO Affichage différent des dates -->
        <c:if test="${not empty eventStartDate}">
          <fmt:formatDate pattern="dd.MM.yyyy" value="${eventStartDate.date.time}"/>
        </c:if>
        <c:if test="${not empty eventEndDate}">
          <c:if test="${not empty eventStartDate}">
            &nbsp;-&nbsp;
          </c:if>
          <fmt:formatDate pattern="dd.MM.yyyy" value="${eventEndDate.date.time}"/>
        </c:if>
      </div>
      <c:if test="${not empty eventComplementaryInfo}">
        ${eventComplementaryInfo.string}
      </c:if>
      <c:if test="${not empty eventComplementaryDate}">
        <c:if test="${not empty eventComplementaryInfo}">
          ,&nbsp;
        </c:if>
        <fmt:formatDate pattern="dd.MM.yyyy, hh:mm" value="${eventComplementaryDate.date.time}"/>
      </c:if>
      <div class="place">
        <c:if test="${not empty eventLocation}">
          ${eventLocation.string}
        </c:if>
      </div>
      <div class="event-actions">
        <a class="btn btn-calendar" href="#">
          <span>
            <fmt:message key="label.addToCalendar"/>
          </span>
        </a>
        <c:if test="${not empty eventRsvp}">
          <a class="btn btn-mail" href="mailto:${eventRsvp.string}">
            <span>
              <fmt:message key="label.sendMail"/>
            </span>
          </a>
        </c:if>
        <a class="btn btn-external" href="#">
          <span>
            <fmt:message key="label.externalSite"/>
          </span>
        </a>
      </div>
      
<!-- TODO Appliquer le filtre -->
      <c:if test="${not empty eventDescription}">
        ${eventDescription.string}
      </c:if>
      
<!-- TODO <c:if test=""> -->
      <hr class="dotted">
      
      <div id="event-attached">
<!-- TODO Ajout des fichiers attachés, liens, contacts -->
      </div>
      
      <hr class="dotted">
<!-- TODO </c:if> -->
     
      <a href="javascript:history.go( -1 )" class="back">
        Return
      </a>
    </div>
    
    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
      <div class="sidebar-tools">
        <ul class="tools-top">
          <li>
            <a title="Print event" href="javascript:window.print()" class="print">
              <span>
                <fmt:message key="label.print"/>
              </span>
            </a>
          </li>
          <li>
            <a onclick="" target="_blank" href="#" title="Contextual help" class="help">
              <span>
                <fmt:message key="label.help"/>
              </span>
            </a>
          </li>
        </ul>
        <div class="content-sidebar-tools">
          <ul class="tag">
            <li class="title">
              <fmt:message key="label.category"/>
            </li>
            <c:if test="${not empty eventCategory}">
              <li>
                <a href="#">
                  ${eventCategory.node.displayableName}
                </a>
              </li>
            </c:if>
          </ul>
          
          <hr class="dotted">
          
          <ul class="tag">
            <li class="title">
              <fmt:message key="label.keywords"/>
            </li>
            <c:if test="${not empty eventKeywords}">
              <c:forEach items="${eventKeywords}" var="eventKeyword" varStatus="status">
                <li>
                  <a href="#">
              		${eventKeyword.node.displayableName}
                  </a>
                </li>
              </c:forEach>
            </c:if>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>