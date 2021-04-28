using FoodOrder.Core.Models;
using IdentityServer4.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FoodOrder.IdentityServer
{
    public class Config
    {
        internal class Clients
        {
            public static IEnumerable<Client> Get()
            {
                return new List<Client>
            {
                new Client
                {
                    ClientId = "oauthClient",
                    ClientName = "Example client",
                    AllowedGrantTypes = GrantTypes.ClientCredentials,
                    ClientSecrets = new List<Secret>{new Secret("godSecret".Sha256())},
                    AllowedScopes = new List<string>{"api1.read"}
                }
            };
            }
        }

        internal class Resources
        {
            public static IEnumerable<IdentityResource> GetIdentityResources()
            {
                return new[]
                {
                new IdentityResources.OpenId(),
                new IdentityResources.Profile(),
                new IdentityResources.Email(),
                new IdentityResource
                {
                    Name = "role",
                    UserClaims = new List<string> {"role"}
                }
            };
            }

            public static IEnumerable<ApiResource> GetApiResources()
            {
                return new[]
                {
                new ApiResource
                {
                    Name = "api1",
                    DisplayName = "API #1",
                    Description = "Allow the application to access API #1",
                    Scopes = new List<string> {"api1.read", "api1.write"},
                    ApiSecrets = new List<Secret> {new Secret("scopeSecret".Sha256())},
                    UserClaims = new List<string>{"role"}
                }
            };
            }

            public static IEnumerable<ApiScope> GetApiScopes()
            {
                return new[]
                {
                new ApiScope("api1.read", "Read access to api 1"),
                new ApiScope("api1.write", "Write access to api 1")
            };
            }
        }

        internal class Users
        {
            public static List<AppUser> Get()
            {
                return new List<AppUser>
            {
                new AppUser
                {
                    //SubjectId = "5BE86359-073C-434B-AD2D-A3932222DABE",
                    //Username = "scott",
                    //Password = "password",
                    //Claims = new List<Claim>
                    //{
                    //    new Claim(JwtClaimTypes.Email, "scott@scott.com"),
                    //    new Claim(JwtClaimTypes.Role, "admin")
                    //}
                }
            };
            }
        }
    }
}
