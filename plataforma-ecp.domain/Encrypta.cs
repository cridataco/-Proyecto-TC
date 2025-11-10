using System;
using System.Text;

namespace plataforma_ecp.domain
{
    public static class Encrypta

    {
        private static readonly int lngALPKeyLength = 8;

        public static string EncriptarCadena(string strData)

        {
            string retorno = string.Empty;

            try

            {
                if (!string.IsNullOrEmpty(strData))

                {
                    int lngHex = 0;

                    int lngIterator = 0;

                    bool blnOscillator = false;

                    Random random = new Random();

                    string strOutput = string.Empty;

                    string strALPKey = string.Empty;

                    string strALPKeyMask = string.Empty;

                    for (lngIterator = 1; lngIterator <= lngALPKeyLength; lngIterator++)

                    {
                        strALPKey += Convert.ToString(random.Next(0, 16), 16).Trim().ToUpper();

                        strALPKeyMask += Convert.ToString(random.Next(0, 2)).Trim();
                    }

                    lngIterator = 0;

                    do

                    {
                        blnOscillator = !blnOscillator;

                        lngIterator += 1;

                        if (lngIterator > lngALPKeyLength) { lngIterator = 1; }

                        lngHex = blnOscillator ? Convert.ToInt32(Encoding.ASCII.GetBytes(strData.Substring(0, 1))[0]) + Convert.ToInt32(Encoding.ASCII.GetBytes(strALPKey.Substring(lngIterator - 1, 1))[0]) : Convert.ToInt32(Encoding.ASCII.GetBytes(strData.Substring(0, 1))[0]) - Convert.ToInt32(Encoding.ASCII.GetBytes(strALPKey.Substring(lngIterator - 1, 1))[0]);

                        if (lngHex > 255) { lngHex -= 255; }
                        else if (lngHex < 0) { lngHex += 255; }

                        strOutput += (new string('0', 2) + Convert.ToString(lngHex, 16)).Substring((new string('0', 2) + Convert.ToString(lngHex, 16)).Length - 2).ToUpper();

                        strData = strData.Substring(strData.Length - (strData.Length - 1));
                    } while (strData.Length > 0);

                    for (lngIterator = 1; lngIterator <= lngALPKeyLength; lngIterator++)

                    {
                        if (strALPKeyMask.Substring(lngIterator - 1, 1) == "1")

                        {
                            strOutput = strALPKey.Substring(lngIterator - 1, 1) + strOutput.ToUpper();
                        }
                        else

                        {
                            strOutput = strOutput.ToUpper() + strALPKey.Substring(lngIterator - 1, 1);
                        }
                    }

                    retorno = new string('0', 2) + Convert.ToString(Convert.ToInt32(BinaryToDouble(strALPKeyMask)), 16);

                    retorno = retorno.Substring((new string('0', 2) + Convert.ToString(Convert.ToInt32(BinaryToDouble(strALPKeyMask)), 16)).Length - 2) + strOutput.ToUpper();

                    retorno = retorno.ToUpper();
                }
            }
            catch (Exception e)

            {
                throw e;
            }

            return retorno;
        }

        public static string DesencriptarCandena(string strData)

        {
            string strOutput = string.Empty;

            try

            {
                if (!string.IsNullOrEmpty(strData))

                {
                    string strALPKey = string.Empty;

                    string strALPKeyMask = string.Empty;

                    int lngIterator = 0;

                    bool blnOscillator = false;

                    int lngHex = 0;

                    strALPKeyMask = new string('0', lngALPKeyLength) + Convert.ToString(Convert.ToInt32(strData.Substring(0, 2), 16), 2);

                    strALPKeyMask = strALPKeyMask.Substring(strALPKeyMask.Length - lngALPKeyLength);

                    strData = strData.Substring(strData.Length - (strData.Length - 2));

                    for (lngIterator = lngALPKeyLength; lngIterator >= 1; lngIterator--)

                    {
                        if (strALPKeyMask.Substring(lngIterator - 1, 1) == "1")

                        {
                            strALPKey = strData.Substring(0, 1) + strALPKey;

                            strData = strData.Substring(strData.Length - (strData.Length - 1));
                        }
                        else

                        {
                            strALPKey = strData.Substring(strData.Length - 1) + strALPKey;

                            strData = strData.Substring(0, strData.Length - 1);
                        }
                    }

                    lngIterator = 0;

                    do

                    {
                        blnOscillator = !blnOscillator;

                        lngIterator += 1;

                        if (lngIterator > lngALPKeyLength)

                        {
                            lngIterator = 1;
                        }

                        lngHex = blnOscillator ? Convert.ToInt32(strData.Substring(0, 2), 16) - Convert.ToInt32(Encoding.ASCII.GetBytes(strALPKey.Substring(lngIterator - 1, 1))[0]) : Convert.ToInt32(strData.Substring(0, 2), 16) + Convert.ToInt32(Encoding.ASCII.GetBytes(strALPKey.Substring(lngIterator - 1, 1))[0]);

                        if (lngHex > 255)

                        {
                            lngHex = lngHex - 255;
                        }
                        else if (lngHex < 0)

                        {
                            lngHex = lngHex + 255;
                        }

                        strOutput = strOutput + (char)lngHex;

                        strData = strData.Substring(strData.Length - (strData.Length - 2));
                    } while (strData.Length > 0);
                }
            }
            catch (Exception e)

            {
                throw e;
            }

            return strOutput;
        }

        private static double BinaryToDouble(string strData)

        {
            double dblOutput = 0;

            try

            {
                int lngIterator = 0;

                do

                {
                    dblOutput = dblOutput + (strData.Substring(strData.Length - 1) == "1" ? Math.Pow(2, lngIterator) : 0);

                    strData = strData.Substring(0, strData.Length - 1);

                    lngIterator = lngIterator + 1;
                } while (strData.Length > 0);
            }
            catch (Exception e)

            {
                throw e;
            }

            return dblOutput;
        }
    }
}