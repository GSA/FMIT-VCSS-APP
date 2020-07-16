<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="content">
    <table style="margin: 5px; text-align: left;">
      <xsl:for-each select="Items/Item">
        <tr style="margin-bottom: 8px;">
          <td>
            <b>
              <xsl:value-of select="@title"/> :
            </b>
          </td>
          <td>
            <xsl:value-of select="@description"/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>
</xsl:stylesheet>