using System.IO;
using System.Threading.Tasks;

namespace FoodBridge.Application.Common.Interfaces;

public interface IFileStorageService
{
    Task<string> SaveFileAsync(Stream fileStream, string fileName, string contentType);
    Task DeleteFileAsync(string fileUrl);
}