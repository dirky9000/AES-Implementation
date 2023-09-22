#include <iostream>
#include <string>
#include <math.h>

using namespace std;

class AEScipher{
    private:
        string plaintext;
        string ciphertext;
        string key;
        int blockSize;

    public:
        AEScipher(string text){
            key = text;
        }

        string encrypt(string plaintext){

        }

        string decrypt(string ciphertext, string key){

        }

        string pad(string plaintext){

        }
};


int main(int argc, char* argv[]){
    
    string encryption_key;

    cout << "Running main function" << endl;
    cout << "Enter the secret key: ";
    cin >> encryption_key;


    return 0;
}
