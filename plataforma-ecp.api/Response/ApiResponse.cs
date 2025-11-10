using plataforma_ecp.domain.CustomEntities;

namespace plataforma_ecp.api.Response
{
    public class ApiResponse<T>
    {
        public ApiResponse(T data)
        {
            Data = data;
        }
        public T Data { get; set; }
        public Metadata ? Meta { get; set; }
    }
}
