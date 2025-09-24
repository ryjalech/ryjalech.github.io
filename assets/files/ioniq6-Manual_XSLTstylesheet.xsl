<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<html>
	<head> <title><xsl:value-of select="document/title" /></title> </head>

<body style="font-family:Arial;font-size:10pt;line-height:1.5"> <!-- IMPROVEMENTS FOR V2
		ADD a table of contents: 3 columns for the sections, and use a XML-query to generate the list with links to each section
		
		TRY different fonts
		-->

	<h1><xsl:value-of select="document/title" /></h1>
	<xsl:apply-templates select="document/introduction" />
	<xsl:apply-templates select="document/section" />

</body>
</html>

</xsl:template>

<xsl:template match="introduction">
<div>
<p style="border-width:3px;border-style:solid;border-color:#047521;border-radius:10px;padding:1em;"> <xsl:apply-templates /> </p>
</div>
</xsl:template>

<xsl:template match="section">
	<div> <xsl:apply-templates select="info" />
	<p> <xsl:apply-templates select="para" /> </p>
	<ol> <xsl:apply-templates select="orderedlist" /> </ol>
	</div>
</xsl:template>
 
<xsl:template match="info">
	<h2> <xsl:value-of select="title" /> </h2>
</xsl:template>

<xsl:template match="orderedlist"> 
	<div> <xsl:apply-templates select="feature" /> </div>
</xsl:template>

<xsl:template match="feature">

		<li  style="padding-top:1em"> <xsl:apply-templates select="para" /> 
		<xsl:apply-templates select="emphasis" /> 
		<xsl:apply-templates select="itemizedlist"/> </li>

</xsl:template>
	
<xsl:template match="itemizedlist">
	<xsl:apply-templates select="para" /> 
</xsl:template>

<xsl:template match="para">
	<xsl:choose>
		<xsl:when test="@id='description'"> <br /> <div style="padding-left:25px"> <xsl:apply-templates /> </div> </xsl:when>
		<xsl:when test="@id='controls'"> <ul style="padding-top:5px"> <li style="display:list-item;list-style-position:inside;list-style-type:disc"> <xsl:apply-templates /> </li>  </ul> </xsl:when>
		<xsl:when test="@id='location'"> <div> <span style="margin-left:40px;border-width:1px;border-style:solid;border-color:#b4b7ae" > <xsl:apply-templates /> </span> </div> </xsl:when>
		<xsl:when test="@id='note'"> <div> <span style="margin-left:40px;border-width:2px;border-style:solid;border-color:#cc0000">  <xsl:apply-templates /> </span> </div> </xsl:when>
		<xsl:otherwise>	<xsl:apply-templates /> </xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="emphasis">
	<xsl:choose>
		<xsl:when test="@role='bold'"> <b> <xsl:apply-templates /> </b> </xsl:when>
		<xsl:when test="@role='underline'"> <u> <xsl:apply-templates /> </u> </xsl:when>
		<xsl:when test="@role='italic'"> <br />  <i> <xsl:apply-templates /> </i> </xsl:when>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet> 