using System;
using Microsoft.EntityFrameworkCore;
using FoodBridge.Infrastructure.Data;

namespace FoodBridge.Tests.TestHelpers;

public static class TestDbContextFactory
{
    public static FoodBridgeDbContext Create(string dbName)
    {
        var options = new DbContextOptionsBuilder<FoodBridgeDbContext>()
            .UseInMemoryDatabase(databaseName: dbName)
            .Options;

        return new FoodBridgeDbContext(options);
    }
}