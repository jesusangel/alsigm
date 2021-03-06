<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/taglibs/displaydepositotags.tld" prefix="archivo"%>
<%@ taglib uri="/WEB-INF/taglibs/securityTag.tld" prefix="security"%>

<bean:struts id="actionMapping" mapping="/busquedaTareasDigitalizacion" />

<script>

function buscar(){
	var form = document.forms['<c:out value="${actionMapping.name}"/>'];
	form.method.value="buscar";
	form.submit();
}
</script>
<c:set var="estadosTareas" value="${requestScope[appConstants.documentos.ESTADOS_TAREAS_KEY]}"/>



<div id="contenedor_ficha" style="-moz-box-sizing: border-box;">

<html:form action="/busquedaTareasDigitalizacion">
<input type="hidden" name="method" value=""/>

<tiles:insert template="/pages/tiles/PABoxLayout.jsp">

	<tiles:put name="boxTitle" direct="true">
		<bean:message key="archigest.archivo.documentos.digitalizacion.registroTareasDigitalizacion"/>
	</tiles:put>

	<tiles:put name="buttonBar" direct="true">		
		<table>
		<tr>	
			<td nowrap>
				<c:url var="urlBuscar" value="/action/busquedaTareasDigitalizacion">
					<c:param name="method" value="buscar"/>
				</c:url>
				<a class="etiquetaAzul12Bold"  href="javascript:buscar();">
					<html:img page="/pages/images/buscar.gif" styleClass="imgTextMiddle" titleKey="archigest.archivo.buscar" altKey="archigest.archivo.buscar"/>&nbsp;<bean:message key="archigest.archivo.buscar"/>
				</a>
			</td>
			<td width="10px">&nbsp;</td>
			<td>
				<script>
					function clean()
					{
						var form = document.forms["<c:out value="${actionMapping.name}" />"];
						form.titulo.value = "";
						form.referencia.value = "";
						deseleccionarCheckboxSet(form.estados);
				
						form.fechaComp.value = "=";
						form.fechaFormato.value = "AAAA";
						form.fechaD.value = "";
						form.fechaM.value = "";
						form.fechaA.value = "";
						checkFechaComp(document.forms[0])
					}
				</script>
			
				<a class="etiquetaAzul12Bold" href="javascript:clean();">
					<html:img page="/pages/images/clear0.gif" styleClass="imgTextMiddle" titleKey="archigest.archivo.limpiar" altKey="archigest.archivo.limpiar"/>&nbsp;<bean:message key="archigest.archivo.limpiar"/>
				</a>
			</td>
			<c:if test="${appConstants.configConstants.mostrarAyuda}">
				<td width="10">&nbsp;</td>
				<td>
					<c:set var="requestURI" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}" />
					<c:set var="carpetaIdioma" value="${sessionScope[appConstants.commonConstants.LOCALEKEY]}" />
					<a class="etiquetaAzul12Bold" href="javascript:popupHelp('<c:out value="${requestURI}" escapeXml="false"/>/help/<c:out value="${carpetaIdioma}"/>/digitalizacion/BuscarTareaDigitalizacion.htm');">
					<html:img page="/pages/images/help.gif" 
					altKey="archigest.archivo.ayuda" 
					titleKey="archigest.archivo.ayuda" 
					styleClass="imgTextMiddle"/>
					&nbsp;<bean:message key="archigest.archivo.ayuda"/></a>
				</td>
			</c:if>
			<td width="10px">&nbsp;</td>
			<td nowrap>
				<c:url var="cancelURI" value="/action/gestionTareasDigitalizacion">
					<c:param name="method" value="goBack"  />
				</c:url>
				<a  class="etiquetaAzul12Bold"  href="<c:out value="${cancelURI}" escapeXml="false"/>">
				<html:img  page="/pages/images/close.gif" styleClass="imgTextMiddle" titleKey="archigest.archivo.cerrar"  altKey="archigest.archivo.cerrar"/>
				&nbsp;<bean:message key="archigest.archivo.cerrar"/>
				</a>
			</td>
		</tr>
		</table>
	</tiles:put>

	<tiles:put name="boxContent" direct="true">

		<div class="bloque">
		<table class="formulario">					
			<tr>
				<td class="tdTitulo" width="200px"><bean:message key="archigest.archivo.referencia"/>:&nbsp;</td>
				<td class="tdDatos"><html:text property="referencia" size="60" /></td>
			</tr>
			<tr>
				<td class="tdTitulo"><bean:message key="archigest.archivo.titulo"/>:&nbsp;</td>
				<td class="tdDatos"><html:text property="titulo" styleClass="input90" /></td>
			</tr>		
			<tr>
				<td class="tdTitulo" colspan="2">&nbsp;</td>
			</tr>
			<%-- Filtro por estado--%>
					<tr>
						<td class="tdTitulo"><bean:message key="archigest.archivo.eliminacion.buscar.estado"/>:&nbsp;</td>
						<td>
							<table class="formulario">
									<tr>
										<td align="right">
											<a class="etiquetaAzul12Bold" href="javascript:seleccionarCheckboxSet(document.forms['<c:out value="${actionMapping.name}" />'].estados);" 
								 			><html:img page="/pages/images/checked.gif" 
												    border="0" 
												    altKey="archigest.archivo.selTodos" 
												    titleKey="archigest.archivo.selTodos" 
												    styleClass="imgTextBottom" />&nbsp;<bean:message key="archigest.archivo.selTodos"/></a>
											&nbsp;
											<a class="etiquetaAzul12Bold" href="javascript:deseleccionarCheckboxSet(document.forms['<c:out value="${actionMapping.name}" />'].estados);" 
								 			><html:img page="/pages/images/check.gif" 
												    border="0" 
												    altKey="archigest.archivo.quitarSel" 
												    titleKey="archigest.archivo.quitarSel" 
												    styleClass="imgTextBottom" />&nbsp;<bean:message key="archigest.archivo.quitarSel"/></a>
											&nbsp;&nbsp;
									   </td>
									</tr>
							</table>
						<table cellpadding="0" cellspacing="0">
							<c:forEach var="estado" items="${estadosTareas}" varStatus="rowNum">
							<c:if test="${rowNum.count % 3 == 1}"><tr></c:if>
								<td>
									<html:multibox style="border:0" property="estados">
										<c:out value="${estado.id}"/>
									</html:multibox>
								</td>
								<td class="tdDatos">
									<c:out value="${estado.description}"/>
								</td>
								<td width="10px">&nbsp;</td>
							<c:if test="${rowNum.count % 3 == 0}"></tr></c:if>
							</c:forEach>
						</table>
						</td>
					</tr>
			<%-- Filtro por estado--%>
			<tr>
				<td class="separador5" colspan="2">&nbsp;</td>
			</tr>
					
			<tr>
				<td class="tdTitulo">Fecha Estado:&nbsp;</td>
				<td class="tdDatos">
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<html:select styleId="fechaComp" property="fechaComp" onchange="javascript:checkFechaComp(document.forms[0])" styleClass='input'>
											<html:option key="archigest.archivo.simbolo.igual" value="="/>
											<html:option key="archigest.archivo.simbolo.mayor" value=">"/>
											<html:option key="archigest.archivo.simbolo.menor" value="&lt;"/>
											<html:option key="archigest.archivo.simbolo.mayoroigual" value=">="/>
											<html:option key="archigest.archivo.simbolo.menoroigual" value="<="/>
											<html:option key="archigest.archivo.simbolo.rango" value="[..]"/>
										</html:select>
									</td>
								    <td width="10">&nbsp;</td>
									<td id="idFecha" style="display:none;">
										<table cellpadding="0" cellspacing="0">
											<tr>
												<td>
													<html:select property="fechaFormato" styleId="fechaFormato" onchange="javascript:checkFechaFormato(this, 'idFecha')" styleClass="input">
														<html:option key="archigest.archivo.formato.AAAA" value="AAAA"/>
														<html:option key="archigest.archivo.formato.MMAAAA" value="MMAAAA"/>
														<html:option key="archigest.archivo.formato.DDMMAAAA" value="DDMMAAAA"/>
													</html:select>
											    </td>
											    <td width="10">&nbsp;</td>
											    <td id="idFechaDValor" style="display:none;" nowrap="true">
											    	<html:text property="fechaD" maxlength="2" size="2"/>-
											    </td>
											    <td id="idFechaMValor" style="display:none;" nowrap="true">
											    	<html:text property="fechaM" maxlength="2" size="2"/>-
											    </td>
											    <td id="idFechaAValor" style="display:none;">
											    	<html:text property="fechaA" maxlength="4" size="4"/>
											    </td>
											    <td id="idFechaSValor" style="display:none;">
											    	<html:text property="fechaS" maxlength="5" size="5"/>
											    </td>
										    </tr>
									    </table>
									</td>
									<td id="idRangoFechas" style="display:none;">
										<table cellpadding="0" cellspacing="0">
											<tr>
											    <td class="user_data">Desde</td>
											    <td width="5">&nbsp;</td>
												<td>
												<html:select property="fechaIniFormato" styleId="fechaIniFormato" onchange="javascript:checkFechaFormato(this, 'idFechaIni')" styleClass="input">
													<html:option key="archigest.archivo.formato.AAAA" value="AAAA"/>
													<html:option key="archigest.archivo.formato.MMAAAA" value="MMAAAA"/>
													<html:option key="archigest.archivo.formato.DDMMAAAA" value="DDMMAAAA"/>
												</html:select>
											    </td>
											    <td width="10">&nbsp;</td>
											    <td id="idFechaIniDValor" style="display:none;" nowrap="true">
											    	<html:text property="fechaIniD" maxlength="2" size="2" value=""/>-
											    </td>
											    <td id="idFechaIniMValor" style="display:none;" nowrap="true">
											    	<html:text property="fechaIniM" maxlength="2" size="2" />-
											    </td>
											    <td id="idFechaIniAValor" style="display:none;">
											    	<html:text property="fechaIniA" maxlength="4" size="4"/>
											    </td>
											    <td id="idFechaIniSValor" style="display:none;">
											    	<<html:text property="fechaIniS" maxlength="5" size="5" />
											    </td>
											    <td width="10">&nbsp;</td>
											    <td class="user_data">Hasta</td>
											    <td width="5">&nbsp;</td>
												<td>
												<html:select property="fechaFinFormato" styleId="fechaFinFormato" onchange="javascript:checkFechaFormato(this, 'idFechaFin')" styleClass="input">
													<html:option key="archigest.archivo.formato.AAAA" value="AAAA"/>
													<html:option key="archigest.archivo.formato.MMAAAA" value="MMAAAA"/>
													<html:option key="archigest.archivo.formato.DDMMAAAA" value="DDMMAAAA"/>
												</html:select>
											    </td>
											    <td width="10">&nbsp;</td>
											    <td id="idFechaFinDValor" style="display:none;" nowrap="true">
											    	<html:text property="fechaFinD" maxlength="2" size="2" />-
											    </td>
											    <td id="idFechaFinMValor" style="display:none;" nowrap="true">
											    	<html:text property="fechaFinM" maxlength="2" size="2" />-
											    </td>
											    <td id="idFechaFinAValor" style="display:none;">
											    	<html:text property="fechaFinA" maxlength="4" size="4" />
											    </td>
											    <td id="idFechaFinSValor" style="display:none;">
											    	<html:text property="fechaFinS" maxlength="5" size="5" />
											    </td>
										    </tr>
									    </table>
									</td>
								</tr>
							</table>
							<script>checkFechaComp(document.forms[0]);</script>
				</td>
			</tr>

		</table>


		</div> <%-- bloque --%>

	</tiles:put>
</tiles:insert>
	</html:form>

</div> <%-- contenedor_ficha --%>	
