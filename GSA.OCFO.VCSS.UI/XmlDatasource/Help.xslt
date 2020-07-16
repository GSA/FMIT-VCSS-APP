<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="content">
    <h2>VCSS Training PowerPoints</h2>
    <p>
      <a href="Docs/Training/VCSS Training - 508 Compliant.pptx">
        PowerPoint Presentation (508-Compliant)
      </a>
    </p>
    <p>
      <a href="VCSSTraining.aspx">
        PowerPoint Presentation with Audio
      </a>
    </p>
    <h4>VCSS Training Segments</h4>
    <ul>
      <xsl:for-each select="links2/link">
        <li>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="@url"/>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:value-of select="@description"/>
          </a>
        </li>
      </xsl:for-each>
    </ul>
    <h2>VCSS Reference Documents</h2>
    <ul>
      <xsl:for-each select="links1/link">
        <li>
          <xsl:if test="@isnew">
            <span style="font-weight:bold; font-size:x-small; color:red;">NEW! </span>
          </xsl:if>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="@url"/>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:value-of select="@description"/>
          </a>
        </li>
      </xsl:for-each>
    </ul>
    <h2>Vendor Training</h2>
    <ul>
      <xsl:for-each select="links3/link">
        <li>
          <xsl:if test="@isnew">
            <span style="font-weight:bold; font-size:x-small; color:red;">NEW! </span>
          </xsl:if>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="@url"/>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:value-of select="@description"/>
          </a>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
</xsl:stylesheet>