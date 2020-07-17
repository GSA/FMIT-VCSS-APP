<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="content">
    <h2>Contact Us</h2>
    <div id="accContacts" class="accordion">
      <xsl:for-each select="contacts">
        <h4>
          <xsl:value-of select="@type"/>
        </h4>
        <div style="padding-left:20px; border:1px solid gray; background-color:#F8F8F8;">
          <xsl:for-each select="section">
            <p>
              <strong>
                <xsl:value-of select="@header"/>
              </strong>
            </p>
            <p style="margin-left: 40px;text-align:left;">
              <xsl:for-each select="contact">
		    <xsl:value-of select="@label"/>
                    <xsl:if test="@IsLink='true'">
                      <a>
                        <xsl:attribute name="href">
                          <xsl:value-of select="@Link"/>
                        </xsl:attribute>
                        <xsl:value-of select="@desc"/>
                      </a>
                    </xsl:if>
                    <xsl:if test="@IsLink='false'">
	                <xsl:value-of select="@desc"/>
                    </xsl:if>
                  <xsl:if test="position()!=last()">
                   <br />
                  </xsl:if>
              </xsl:for-each>
            </p>
          </xsl:for-each>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>
</xsl:stylesheet>