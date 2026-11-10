using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using FoodBridge.Application.Common.Interfaces;

namespace FoodBridge.Infrastructure.Services;

public class LocalFileStorageService : IFileStorageService
{
    private readonly IWebHostEnvironment _environment;

    public LocalFileStorageService(IWebHostEnvironment environment)
    {
        _environment = environment;
    }

    public async Task<string> SaveFileAsync(Stream fileStream, string fileName, string contentType)
    {
        var webRoot = _environment.WebRootPath ?? Path.Combine(_environment.ContentRootPath, "wwwroot");
        var uploadsFolder = Path.Combine(webRoot, "uploads", "listings");

        if (!Directory.Exists(uploadsFolder))
        {
            Directory.CreateDirectory(uploadsFolder);
        }

        var extension = Path.GetExtension(fileName);
        if (string.IsNullOrWhiteSpace(extension))
        {
            extension = ".jpg";
        }

        var uniqueFileName = $"{Guid.NewGuid():N}{extension}";
        var filePath = Path.Combine(uploadsFolder, uniqueFileName);

        using (var outputStream = new FileStream(filePath, FileMode.Create))
        {
            await fileStream.CopyToAsync(outputStream);
        }

        return $"/uploads/listings/{uniqueFileName}";
    }

    public Task DeleteFileAsync(string fileUrl)
    {
        if (string.IsNullOrWhiteSpace(fileUrl)) return Task.CompletedTask;

        try
        {
            var relativePath = fileUrl.TrimStart('/', '\\');
            var webRoot = _environment.WebRootPath ?? Path.Combine(_environment.ContentRootPath, "wwwroot");
            var fullPath = Path.Combine(webRoot, relativePath);

            if (File.Exists(fullPath))
            {
                File.Delete(fullPath);
            }
        }
        catch
        {
        }

        return Task.CompletedTask;
    }
}