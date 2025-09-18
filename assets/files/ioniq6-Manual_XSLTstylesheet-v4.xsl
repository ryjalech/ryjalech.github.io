<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<html>
	<head> <title><xsl:value-of select="document/title" /></title> </head>

<body style="font-family:Arial;font-size:10pt;line-height:1.5"> <!-- TRY ADDING a table of contents: 3 columns for the sections, and use a query to generate the list with links to each section-->

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

<!-- OLD STRUCTURE ... numbers are not generating properly on this, retain for reference, test new below -->
<xsl:template match="orderedlist"> 
	<xsl:apply-templates select="feature" />
</xsl:template>

<xsl:template match="feature">
	<li> 
		<div> <xsl:apply-templates select="para" /> 
		<xsl:apply-templates select="emphasis" /> 
		<xsl:apply-templates select="itemizedlist"/> </div>
	</li>
</xsl:template>


<!-- NEW STRUCTURE, trying to solve for broken list numbers
<xsl:template match="orderedlist"> 
	<li> <xsl:for-each select="feature" >
		<xsl:apply-templates select="para" /> 
		<xsl:apply-templates select="emphasis" /> 
		<xsl:apply-templates select="itemizedlist"/>
	</xsl:for-each>
	</li> 
</xsl:template> 
-->
	
<xsl:template match="itemizedlist">
	<!-- <xsl:apply-templates select="listitem" /> *** remove if new para code successful-->
	<xsl:apply-templates select="para" /> <!-- if featureset style not coming out right: try to build the styling for the featureset here , maybe gives better control? -->
</xsl:template>

<!-- <xsl:template match="listitem"> (ORIGINAL NOTE: best way to target the ids? can a template match apply all attribute variations, or do they need to match precisely - or maybe different span somehow? - or try test logic description: more standard paragraph, slight indent ; controls: unordered list may be fine still? indent more from description ; location: maybe light border below the controls)
	<li>
	<xsl:apply-templates select="para" /> 
	<xsl:apply-templates select="emphasis" /> 
	</li>
</xsl:template>
 -->

<xsl:template match="para"> <!-- controls needs a little spacing above line; redo the NOTE to be a new element -->
	<xsl:choose>
		<xsl:when test="@id='description'"> <span style="padding-left:30px"> <xsl:apply-templates /> </span> <!--slight indent, line break--> </xsl:when>
		<xsl:when test="@id='controls'"> <span style="margin-left:50px;padding-top:1em;display:list-item;list-style-position:inside;list-style-type:disc"> <xsl:apply-templates /> </span> <!-- bullet, double indent --> </xsl:when>
		<xsl:when test="@id='location'"> <span style="margin-left:50px;line-height:.5;border-width:1px;border-style:solid;border-color:#b4b7ae" > <xsl:apply-templates /> </span> <br /><br /> </xsl:when>
		<xsl:when test="@id='note'"> <span style="margin-left:50px;border-width:2px;border-style:solid;border-color:cc0000">  <xsl:apply-templates /> </span> </xsl:when>
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