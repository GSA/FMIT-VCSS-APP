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
          Dear VCSS Security:
        </p>
        <p>A User has requested to Change Administrator of account in VCSS and submitted the following</p>
        <p>
          <strong>What are the next steps,</strong><br />
          Requests for accounts already registered in VCSS will be sent to the Account Administrator(s). If you do not receive a response about your account in 5 business days, please follow up with your Account Administrator.
        </p>
        <p>
          Requests for new accounts will be sent to GSA. If you do not receive a response about your accounts in 5 business days, please follow up with GSA: <a href="mailto:VCSS.Security@gsa.gov">VCSS.Security@gsa.gov</a>.
        </p>
        <p>
          <strong>Requests Details</strong>
        </p>
        <div style="border:1px solid Black; padding:10px;">
          <p>
            <strong>
              <div style="border-bottom:1px solid Black; width:100%;">
                Request Type
              </div>
            </strong>
            <br />
            <xsl:value-of select="Type"/>
          </p>
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
          <p>
            <strong>
              <div style="border-bottom:1px solid Black; width:100%;">
                Administrator Information
              </div>
            </strong>
            <br />
            Name : <xsl:value-of select="AccessAccounts/Account/Administrator"/><br/>
            Email : <xsl:value-of select="AccessAccounts/Account/AdministratorEmail"/><br/>
            Phone : <xsl:value-of select="AccessAccounts/Account/AdministratorPhone"/>
          </p>
          <p>
            <strong>
              <div style="border-bottom:1px solid Black; width:100%;">
                Account Information
              </div>
            </strong>
            <br />
            Name  : <xsl:value-of select="AccessAccounts/Account/Name"/><br/>
            DUNS  : <xsl:value-of select="AccessAccounts/Account/Number"/>
          </p>
        </div>
      </div>
      <p style="font-size: x-small;color: #999999;margin:5px 0px 5px 0px;text-align:center;">U.S. General Services Administration</p>
    </div>
  </xsl:template>
</xsl:stylesheet>