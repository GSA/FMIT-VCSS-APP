<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!--<xsl:import href="Test.xslt"/>-->
  <xsl:output method="html"/>
  <xsl:template match="Request">
    <!--<div style="border: solid red">
      <xsl:apply-imports/>
    </div>-->
    <div style="min-width:650px;max-width:800px;padding:5px 10px 5px 10px;background:#f4f4f4;text-align:left;">
      <p style="font-size: large;color: #999999;margin:8px 0px 8px 5px;">
        <img src="cid:gsalogo"/> Vendor and Customer Self Service
      </p>
      <div style="padding:10px; background:#f9f9f9; border: 1px solid #cccccc;">
        <p>
          Dear VCSS Registration:
        </p>
        <p>A User has registered New Account(s) in VCSS and submitted following information.</p>
        <p>
          Confirmation Code for this Request is: <b>
            <xsl:value-of select="Confirmations/Registration" />
          </b>
        </p>
        <p>
          <strong>Requests Details</strong>          
        </p>
        <div style="border:1px solid Black; padding:10px;">
          <p>
            <strong>
              <div style="border-bottom:1px solid Black; width:100%;">
                Requestor Information
              </div>
            </strong>
            <br/>
            Name  : <xsl:value-of select="UserInfo/FirstName"/>&#160;<xsl:value-of select="UserInfo/LastName"/><br/>
            Email : <xsl:value-of select="UserInfo/EmailAddress"/><br/>
            Phone : <xsl:value-of select="format-number(UserInfo/PhoneNumber,'(###) ###-####')"/>
          </p>
          <p style="border-bottom:1px solid Black">
            <strong>
              Account Requests
            </strong>
          </p>
          <p style="border-bottom:1px solid Black">
            <strong>
              Registration accounts
            </strong>
          </p>
          <table width="100%">
            <tr>
              <th width="20%">ALC</th>
              <th width="10%">Account Code</th>
              <th width="70%">Account name</th>
            </tr>
            <xsl:apply-templates select="RegistrationAccounts"/>            
          </table>
        </div>
      </div>
      <p style="font-size: x-small;color: #999999;margin:5px 0px 5px 0px;text-align:center;">U.S. General Services Administration</p>
    </div>
  </xsl:template>
  <xsl:template match="UserInfo">
    <xsl:value-of select="FirstName"/>&#160;<xsl:value-of select="UserInfo/LastName"/>
  </xsl:template>
  <xsl:template match="RegistrationAccounts">
    <xsl:for-each select="Account">
      <tr>
        <td align="center">
          <xsl:value-of select="ALC"/>
        </td>
        <td align="center">
          <xsl:value-of select="AccountCode"/>
        </td>
        <td style="padding-left:100px;">
          <xsl:value-of select="Name"/>
        </td>
      </tr>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>