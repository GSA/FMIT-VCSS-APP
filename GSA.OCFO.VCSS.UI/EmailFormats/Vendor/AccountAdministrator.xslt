<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="Request">
    <div style="min-width:650px;max-width:800px;padding:5px 10px 5px 10px;background:#f4f4f4;text-align:left;">
      <p style="font-size: large;color: #999999;margin:8px 0px 8px 5px;">
        <img src="cid:gsalogo"/> Vendor and Customer Self Service
      </p>
      <div style="padding:10px; background:#f9f9f9; border: 1px solid #cccccc;">
        <p>
          Dear <xsl:value-of select="AccessAccounts/Account/Administrator"/>,
        </p>
        <p>A User has submitted the following information to Request Access to Account(s) of which you are the Administrator in VCSS.</p>
        <p>
          Confirmation Code for this request is: <b><xsl:value-of select="Confirmations/Access" />
          </b>
        </p>
        <p>
          <strong>What are the next steps,</strong><br />
          Please forward this email to the VCSS Security (<a href="mailto:VCSS.Security@gsa.gov">VCSS.Security@gsa.gov</a>) and indicate you either approve or disapprove this request.
        </p>
        <p>
          <strong>Requests Details</strong>
          <br />You may print these details for your record.
        </p>
        <div style="border:1px solid Black; padding:10px;">
          <p>
            <strong>
              <div style="border-bottom:1px solid Black; width:100%;">
                User Information
              </div>
            </strong>
            <br/>
            Name  : <xsl:value-of select="UserInfo/FirstName"/>&#160;<xsl:value-of select="UserInfo/LastName"/><br/>
            Email : <xsl:value-of select="UserInfo/EmailAddress"/><br/>
            Phone : <xsl:value-of select="format-number(UserInfo/PhoneNumber,'(###) ###-####')"/>
          </p>
          <p style="border-bottom:1px solid Black">
            <strong>
              Your Accounts
            </strong>
          </p>
          <table width="100%">
            <tr>
              <th width="20%">DUNS</th>
              <th width="15%">DUNS+4</th>
              <th width="65%">Account name</th>
            </tr>
            <xsl:apply-templates select="AccessAccounts"/>
          </table>
        </div>
      </div>
      <p style="font-size: x-small;color: #999999;margin:5px 0px 5px 0px;text-align:center;">U.S. General Services Administration</p>
    </div>
  </xsl:template>
  <xsl:template match="AccessAccounts">
    <xsl:for-each select="Account">
      <tr>
        <td align="center">
          <xsl:value-of select="Number"/>
        </td>
        <td align="center">
          <xsl:value-of select="Number4"/>
        </td>
        <td style="padding-left:100px;">
          <xsl:value-of select="Name"/>
        </td>
      </tr>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>