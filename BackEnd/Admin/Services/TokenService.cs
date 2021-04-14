using IdentityModel.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace Admin.Services
{
    public class TokenService : ITokenService
    {
        private DiscoveryDocumentResponse _discDocument { get; set; }

        public TokenService()
        {
            using(var client = new HttpClient())
            {
                _discDocument = client.GetDiscoveryDocumentAsync("https://localhost:6001/.well-known/openid-configuration").Result;
            }
        }

        public async Task<TokenResponse> GetToken(string scope)
        {
            using (var client = new HttpClient())
            {
                var tokenResponse = await client.RequestClientCredentialsTokenAsync(new ClientCredentialsTokenRequest
                {
                    Address = _discDocument.TokenEndpoint,
                    ClientId = "oauthClient",
                    Scope = scope,
                    ClientSecret = "godSecret"
                });
                if(tokenResponse.IsError)
                {
                    throw new Exception("Token error");
                }
                return tokenResponse;
            }
        }


    }
}
