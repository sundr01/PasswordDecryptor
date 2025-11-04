namespace PasswordStealler.Factories
{
    public interface ICryptoProviderFactory
    {
        ICryptographyProvider Build();
    }
}