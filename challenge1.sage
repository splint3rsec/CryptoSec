from sage.crypto.util import ascii_to_bin
from sage.crypto.util import bin_to_ascii

# Variables declaration - the variables (key, message and cipher) have to be 128 bits
key = "secre2txkeyczvsa"
neptun_code = "A2T4CV"
message = "This is a num, 1"

digits = ['0','1','2','3','4','5','6','7','8','9']

# Variables (key and message) transformation to binary - exactly 128 bits
binkey = ascii_to_bin(key)
binmes = ascii_to_bin(message)

# Padding function
def pad(s):
    while len(s)%8 != 0:
        s += 0
    return s

# Break down the key to blocks
def breakDown(key):
    x = [key[i:i+8] for i in range(0, len(key), 8)]
    return x

# Break down neptun code
def breakNeptun(nep):
    neptun = [c for c in nep]
    return neptun

# Cipher method
def enc(message, key, neptun):
    result, resultOld, cipher = '', '', ''
    blox = breakDown(key)
    nep = breakNeptun(neptun)
    y = [((int(str(blox[i]), base=2)+i^^2) % 256) for i in range(len(blox))]
    for j in nep:
        if j not in digits:
            y[neptun_code.find(j)] = (y[neptun_code.find(j)] + 3) % 256
            y[neptun_code.find(j)+6] = (y[neptun_code.find(j)+6] + 7) % 256
    for i in range(len(y)):
        result += y[i].binary()
    resultOld = result
    while len(result) != 128:
        result += '0'
    for i in range(128):
        cipher += str(Integer(str(message)[i]) ^^ Integer(str(result)[i])) # This is a dumb solution but it does the job :p
    return cipher

# Printing for test cases
print(f"Encryption method: {enc(binmes, binkey, neptun_code)}")