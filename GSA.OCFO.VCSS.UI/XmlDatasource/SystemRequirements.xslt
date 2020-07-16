<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="content">
    <xsl:for-each select="sections">
      <p>
        <strong>
          <xsl:value-of select="@header"/>
        </strong>
      </p>
      <p>
        <xsl:value-of select="@subheader"/>
      </p>
      <ul>
        <xsl:for-each select="section">
          <li>
            <xsl:value-of select="@desc"/>
          </li>
        </xsl:for-each>
      </ul>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>