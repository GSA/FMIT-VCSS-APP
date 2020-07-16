<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="Content">
    <div>
      <xsl:value-of select="WelcomeNote"/>
    </div>
    <div>
      <p>
        <strong>
          <xsl:value-of select="Feature/Heading"/>
        </strong>
      </p>
      <ul>
        <xsl:for-each select="Feature/ItemsList/Item">
          <li>
            <xsl:value-of select="@Text"/>
          </li>
        </xsl:for-each>
      </ul>
    </div>
    <div>
      <div class="infoblock" id="left" style="width: 48%; min-height: 300px;">
        <div class="head">
          <xsl:value-of select="InfoBlocks/Vendor/Heading"/>
        </div>
        <div class="content">
          <xsl:value-of select="InfoBlocks/Vendor/Lines/Line1"/>
          <p>
            <xsl:value-of select="InfoBlocks/Vendor/Lines/Line2/Part1"/>
            <a href="http://sam.gov" target="_blank">www.sam.gov</a>
            <xsl:value-of select="InfoBlocks/Vendor/Lines/Line2/Part2"/>
          </p>
          <p>
            <xsl:value-of select="InfoBlocks/Vendor/Lines/Line3"/>
            <a href="http://ccr.dnb.com/ccr/pages/CCRSearch.jsp" target="_blank">
              here
            </a>.
          </p>
        </div>
      </div>
      <div class="infoblock" id="right" style="width: 48%; min-height: 300px;">
        <div class="head">
          <xsl:value-of select="InfoBlocks/Customer/Heading"/>
        </div>
        <div class="content">
          <xsl:value-of select="InfoBlocks/Customer/Line"/>
          <ul>
            <xsl:for-each select="InfoBlocks/Customer/ItemsList/Item">
              <li>
                <xsl:value-of select="@Text"/>
              </li>
            </xsl:for-each>
          </ul>
        </div>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>