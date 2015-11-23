-- Function: pypgmail(character varying, character varying, character varying, character varying, text)

-- DROP FUNCTION pypgmail(character varying, character varying, character varying, character varying, text);

CREATE OR REPLACE FUNCTION pypgmail(iservidor character varying, iemisor character varying, idestinatario character varying, iasunto character varying, imensaje text)
  RETURNS integer AS
$BODY$

# Importar smtplib
import smtplib
  
# Importamos los m�dulos necesarios
from email.mime.text import MIMEText
  
# Creamos el mensaje
msg = MIMEText(imensaje,'html')
  
# Conexi�n con el server
msg['Subject'] = iasunto
msg['From'] = iemisor
msg['To'] = idestinatario
  
# Autenticamos, si es necesario
mailServer = smtplib.SMTP(iservidor)
  
# Enviamos
mailServer.sendmail(iemisor, idestinatario, msg.as_string())
  
# Cerramos conexi�n
mailServer.quit()
 
return (1)
 
$BODY$
  LANGUAGE plpythonu VOLATILE
  COST 100;
ALTER FUNCTION pypgmail(character varying, character varying, character varying, character varying, text)
  OWNER TO postgres;
