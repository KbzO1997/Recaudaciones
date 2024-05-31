<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<listabreve>
			<xsl:for-each select="catalog/cd">

				<libro>
					<titulo>
						<xsl:value-of select="title"/>
					</titulo>
					<año>
						<xsl:value-of select="year"/>
					</año>
					<cualidad>
						<xsl:when test="price &gt; 15">
							barato
						</xsl:when>
						<xsl:otherwise>
							caro
						</xsl:otherwise>
					</cualidad>
				</libro>


			</xsl:for-each>
		</listabreve>
	</xsl:template>

</xsl:stylesheet>