using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace plataforma_ecp.domain.Validators
{
    public class RutValidadorAttribute : ValidationAttribute
    {

        public string GetErrorMessage(string mensaje) => mensaje;

        protected override ValidationResult? IsValid(
            object? value, ValidationContext validationContext)
        {
            var rut = (string)value;
            string msg = string.Empty;

            if (!ValidaRut(rut, ref msg))
            {
                return new ValidationResult(GetErrorMessage(msg));
            }

            return ValidationResult.Success;
        }

        public static bool ValidaRut(string rut, ref string msg)
        {
            rut = rut.Replace(".", "").ToUpper();
            if (rut.Length != 10)
            {
                msg = "La longitud del rut no es correcta";
                return false;
            }
            Regex expresion = new Regex("^([0-9]+-[0-9K])$");
            string dv = rut.Substring(rut.Length - 1, 1);
            if (!expresion.IsMatch(rut))
            {
                msg = "Formato de rut incorrecto";
                return false;
            }
            char[] charCorte = { '-' };
            string[] rutTemp = rut.Split(charCorte);
            if (dv != Digito(int.Parse(rutTemp[0])))
            {
                msg = "El digito verificador es incorrecto";
                return false;
            }
            return true;
        }

        public static string Digito(int rut)
        {
            int suma = 0;
            int multiplicador = 1;
            while (rut != 0)
            {
                multiplicador++;
                if (multiplicador == 8)
                    multiplicador = 2;
                suma += (rut % 10) * multiplicador;
                rut = rut / 10;
            }
            suma = 11 - (suma % 11);
            if (suma == 11)
            {
                return "0";
            }
            else if (suma == 10)
            {
                return "K";
            }
            else
            {
                return suma.ToString();
            }
        }

    }



}
