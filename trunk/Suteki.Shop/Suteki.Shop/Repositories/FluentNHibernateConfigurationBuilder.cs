using System;
using Castle.Core.Configuration;
using Castle.Facilities.NHibernateIntegration;
using FluentNHibernate.Cfg;
using FluentNHibernate.Cfg.Db;
using FluentNHibernate.Conventions;
using FluentNHibernate.Conventions.Helpers;
using FluentNHibernate.Conventions.Instances;
using NHibernate.Cfg;
using Suteki.Common.NHibernate;
using Suteki.Shop.Maps;

namespace Suteki.Shop.Repositories
{
    public class FluentNHibernateConfigurationBuilder : IConfigurationBuilder
    {
        private const string conectionStringKey = "SutekiShopConnectionString";

        public Configuration GetConfiguration(IConfiguration facilityConfiguration)
        {
            return BuildConfiguration(MsSqlConfiguration.MsSql2005.ConnectionString(c => c.FromConnectionStringWithKey(conectionStringKey)));
        }

        public Configuration BuildConfiguration(IPersistenceConfigurer persistenceConfigurer)
        {
            return Fluently.Configure()
                .Database(persistenceConfigurer)
                .Mappings(ConfigureMappings)
                .BuildConfiguration();
        }

        public static void ConfigureMappings(MappingConfiguration mappingConfiguration)
        {
            mappingConfiguration.FluentMappings
                .AddFromAssembly(typeof (ProductMap).Assembly)
                .Conventions.Add(
                    ForeignKey.EndsWith("Id"),
                    PrimaryKey.Name.Is(x => x.EntityType.Name + "Id"),
                    DefaultCascade.None(),
                    new MoneyConvention());
        }
    }

    public class MoneyConvention : UserTypeConvention<MoneyUserType>{}
}