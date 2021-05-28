```
NAME: vault
LAST DEPLOYED: Fri May 28 08:49:35 2021
NAMESPACE: hashicorp-vault
STATUS: deployed
REVISION: 1
NOTES:
Thank you for installing HashiCorp Vault!

Now that you have deployed Vault, you should look over the docs on using
Vault with Kubernetes available here:

https://www.vaultproject.io/docs/


Your release is named vault. To learn more about the release, try:

  $ helm status vault
  $ helm get manifest vault
```

```
Unseal Key 1: kVtUiMB02L/zdbHgMo8dDDKC9EozbkEe0anXniWcwC4=
Initial Root Token: s.iJFgmuZCJkTyoALBuaQrM6F3
```

```
root@minikube:~/stitrace_platform/kubernetes-vault# kubectl exec -n hashicorp-vault -it vault-0 -- vault status
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       1
Threshold          1
Unseal Progress    0/1
Unseal Nonce       n/a
Version            1.7.2
Storage Type       file
HA Enabled         false
```

```
root@minikube:~/stitrace_platform/kubernetes-vault# kubectl exec -n hashicorp-vault -it vault-0 -- vault operator unseal
Unseal Key (will be hidden):
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         1.7.2
Storage Type    file
Cluster Name    vault-cluster-25cbaa5e
Cluster ID      c80730d3-f449-b0b1-9b88-10850d561a3f
HA Enabled      false
```

```
root@minikube:~/stitrace_platform/kubernetes-vault# kubectl exec -n hashicorp-vault -it vault-0 -- vault login
Token (will be hidden):
Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                  Value
---                  -----
token                s.iJFgmuZCJkTyoALBuaQrM6F3
token_accessor       bWSIFO0KFqsU7s78IPw2fpLS
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]
```

```
root@minikube:~/stitrace_platform/kubernetes-vault# kubectl exec -n hashicorp-vault -it vault-0 -- vault read otus/otus-ro/config
Key                 Value
---                 -----
refresh_interval    768h
password            asajkjkahs
username            otus
root@minikube:~/stitrace_platform/kubernetes-vault# kubectl exec -n hashicorp-vault -it vault-0 -- vault kv get otus/otus-rw/config
====== Data ======
Key         Value
---         -----
password    asajkjkahs
username    otus
root@minikube:~/stitrace_platform/kubernetes-vault#
```

```
root@minikube:~/stitrace_platform/kubernetes-vault# kubectl exec -n hashicorp-vault -it vault-0 -- vault auth list
Path           Type          Accessor                    Description
----           ----          --------                    -----------
kubernetes/    kubernetes    auth_kubernetes_cd468fc6    n/a
token/         token         auth_token_5bcb4f66         token based credentials
root@minikube:~/stitrace_platform/kubernetes-vault#
```

```
kubectl exec -n hashicorp-vault -it vault-0 -- vault write pki_int/issue/example-dot-ru common_name="gitlab.example.ru" ttl="24h"

Key                 Value
---                 -----
ca_chain            [-----BEGIN CERTIFICATE-----
MIIDnDCCAoSgAwIBAgIUbeu3MlqgcdZevfzffDV0DKviWEswDQYJKoZIhvcNAQEL
BQAwFTETMBEGA1UEAxMKZXhtYXBsZS5ydTAeFw0yMTAzMjAxMTM5MDJaFw0yNjAz
MTkxMTM5MzJaMCwxKjAoBgNVBAMTIWV4YW1wbGUucnUgSW50ZXJtZWRpYXRlIEF1
dGhvcml0eTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK5ulOSXUsIR
rcAO/reEq5loOyovTnGQB6vWq2JBbv0UQnpdhUkpodDaAlu2eYSgXBM5ZWwAMSrO
yeUs+CgF5KEIESviLa2pj0Tii5H4DzB8MNUwiMLRzwjD2uSAmZ6HNLzWi6sylix6
KD1oJ7ZS7blQJ3mQZVGNeQ0Vzr1/DswxhKsGf2J2ECzA4jKv17C64jud4NDhvbkx
/MbBH13SN3mzWflRBlPOG8Y9HvuyUbPMVdJcGo5D37cOOPQHvEGoUMckfHMNpmG7
tt67LKonMpVKYruyknaCN+lj7QJNEkgYGiDEjrtxtJMkRhBOI9NN7AeBhPtpXul9
dprVwuD/5hUCAwEAAaOBzDCByTAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUw
AwEB/zAdBgNVHQ4EFgQUj6F8h9QrJCqGwX10d4lW6UFgZW4wHwYDVR0jBBgwFoAU
RMdrzphhOLbfubRaESsYDUskHLYwNwYIKwYBBQUHAQEEKzApMCcGCCsGAQUFBzAC
hhtodHRwOi8vdmF1bHQ6ODIwMC92MS9wa2kvY2EwLQYDVR0fBCYwJDAioCCgHoYc
aHR0cDovL3ZhdWx0OjgyMDAvdjEvcGtpL2NybDANBgkqhkiG9w0BAQsFAAOCAQEA
E3AllWt06b5OC7ULhJL1j0trvfTPhF82o+3q4jWnhSDUuDebruq30lPiSDLMsdWz
RQ+nqYP/DJkzaZW8dVYva/SHXsUhdZ1tomdrWLjESB2Ef/yatZ3wxk2q13EnCj/L
kWnbN4rAfOm9djDZSqOefasjPYSAeNE4vWaxmPGVwRbNed7UCDySOsW8q3aN0iRG
0AvlRaQnVENWxOaSqc9b9UV/A6Ag/9kD89pEMmk9mna4LazBD+iuy6Jwy7Z6yDOr
UFENKvCzc/P3nUdMj/qzHNEDKQvEJXwK8VX/Y5sM5srwdCV2tR9sr/ZPMOs640om
pkhK1OLg/G2rrlof5XoTOt==
-----END CERTIFICATE-----]
certificate         -----BEGIN CERTIFICATE-----
MIIDZzCCAk+gAwIBAgIUJR88DPIE0UbidvQGpSfKGtxlX/IwDQYJKoZIhvcNAQEL
BQAwLDEqMCgGA1UEAxMhZXhhbXBsZS5ydSBJbnRlcm1lZGlhdGUgQXV0aG9yaXR5
MB4XDTIxMDMyMDExNDEzNFoXDTIxMDMyMTExNDIwM1owHDEaMBgGA1UEAxMRZ2l0
bGFiLmV4YW1wbGUucnUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDK
ku83/kg94SJ5lzUUJdwzqUHuUdOjulznyScvpfIF9CuxUiBJBZxzapR9wg16MELB
HtoXllT552HJHGsbfW+jHAPSJ5nlDAzFk6iRdLr14mnF0xnzHov6OG53XCSnsnsd
rJxpruBJVwh+Oa6/6n2Hmn0LxOrnKt6y9qIx1JZek/5uI6Q1LHXe4WkwjtGm6+Y+
hrCxhHB9ePr5DEjJKU9NsNNihJyUbhL/d91Ul0mJvtZKuVXYMbNKCE0e6ov8xDuT
Wxc8PYYwur4SaJLxpU73EmwmyN9VKWrsmV5FGsOt4HDXnIMfiV7ViO4oyoKeH/ad
gleR8a59Dy9ru7ao9NkbAgMBAAGjgZAwgY0wDgYDVR0PAQH/BAQDAgOoMB0GA1Ud
JQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjAdBgNVHQ4EFgQU2suSqQReMA+AWGOT
9MMHwWExfPswHwYDVR0jBBgwFoAUj6F8h9QrJCqGwX10d4lW6UFgZW4wHAYDVR0R
BBUwE4IRZ2l0bGFiLmV4YW1wbGUucnUwDQYJKoZIhvcNAQELBQADggEBAAlmbNDv
28KJeLfKrUCPWGAoOOdenbjvxARUOKOVoMewjKYzYsCHBF4aKbXgkZQb0UChmDQx
ZCT79TinBvjTx4k5u9D9SFO7P7uhnNpcYCEESB/Q40zE0BPQ7eeoMBbQX6ce9DUY
TDYN+Q8PHtj3KAie5yVqw27hyGNt0QZ+xgX9K2TPlIbzT64elqrws/GxiDFqgCNX
nARuo6h/rvUfAnTZPUnwc6mCKUKwqRGUpXKR0SBhJ8rAdsCy3mtmRtgJUDi/JQhE
oLC9ZLrbJqmXxk5U1gHS6xyaWdVFa0AqKa9Ycw9FwSCOR0MutywfvLX/Bz2z1Rm/
Zrc+hIAhXgn88oH=
-----END CERTIFICATE-----
expiration          1622206145
issuing_ca          -----BEGIN CERTIFICATE-----
MIIDnDCCAoSgAwIBAgIUbeu3MlqgcdZevfzffDV0DKviWEswDQYJKoZIhvcNAQEL
BQAwFTETMBEGA1UEAxMKZXhtYXBsZS5ydTAeFw0yMTAzMjAxMTM5MDJaFw0yNjAz
MTkxMTM5MzJaMCwxKjAoBgNVBAMTIWV4YW1wbGUucnUgSW50ZXJtZWRpYXRlIEF1
dGhvcml0eTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK5ulOSXUsIR
rcAO/reEq5loOyovTnGQB6vWq2JBbv0UQnpdhUkpodDaAlu2eYSgXBM5ZWwAMSrO
yeUs+CgF5KEIESviLa2pj0Tii5H4DzB9MNUwiMLRzwjD2uSAmZ6HNLzWi6sylix6
KD1oJ7ZS7blQJ3mQZVGNeQ0Vzr1/DswxhKsGf2J2ECzA4jKv17C64jud4NDhvbkx
/MbBH13SN3mzWflRBlPOG8Y9HvuyUbPMVdJcGo5D37cOOPQHvEGoUMckfHMNpmG7
tt67LKonMpVKYruyknaCN+lj7QJNEkgYGiDEjrtxtJMkRhBOI9NN7AeBhPtpXul9
dprVwuD/5hUCAwEAAaOBzDCByTAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUw
AwEB/zAdBgNVHQ4EFgQUj6F8h9QrJCqGwX10d4lW6UFgZW4wHwYDVR0jBBgwFoAU
RMdrzphhOLbfubRaESsYDUskHLYwNwYIKwYBBQUHAQEEKzApMCcGCCsGAQUFBzAC
hhtodHRwOi8vdmF1bHQ6ODIwMC92MS9wa2kvY2EwLQYDVR0fBCYwJDAioCCgHoYc
aHR0cDovL3ZhdWx0OjgyMDAvdjEvcGtpL2NybDANBgkqhkiG9w0BAQsFAAOCAQEA
E3AllWt06b5OC7ULhJL1j0trvfTPhF82o+3q4jWnhSDUuDebruq30lPiSDLMsdWz
RQ+nqYP/DJkzaZW8dVYva/SHXsUhdZ1tomdrWLjESB2Ef/yatZ3wxk2q13EnCj/L
kWnbN4rAfOm9djDZSqOefasjPYSAeNE4vWaxmPGVwRbNed7UCDySOsW8q3aN0iRG
0AvlRaQnVENWxOaSqc9b9UV/A6Ag/9kD89pEMmk9mna4LazBD+iuy6Jwy7Z6yDOr
UFENKvCzc/P3nUdMj/qzHNEDKQvEJXwK8VX/Y5sM5srwdCV2tR9sr/ZPMOs640om
pkhK1OLg/G2rrlof5XoHOt==
-----END CERTIFICATE-----
private_key         -----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAypLvN/5IPeEieZc1FCXcM6lB7lHTo7pc0cknL6XyBfQrsVIg
SQWcc2qUfcINejBCwR7aF5ZU+edhyRxrG31voxwD0ieZ5QwMxZOokXS69eJpxdMZ
8x6L+jhud1wkp7J7Haycaa7gSVcIfjmuv+p9h5p9C8Tq5yresvaiMdSWXpP+biOk
NSx13uFpMI7RpuvmPoawsYRwfXj6+QxIySlPTbDTYoSclG4S/3fdVJdJib7WSrlV
2DGzSghNHuqL/MQ7k1sXPD2GMLq+EmiS8aVO9xJsJsjfVSlq7JleRRrDreBw15yD
H4le1YjuKMqCnh/2nYJXkfGufQ8va7u2qPTZGwIDAQABAoIBADMRu/E3z+qZuWFB
94WuzcbQYui8BEkAkKnqtlBS26MYnXNEqxL9sSV/txPFOjSVuh6Jsp3DroSaCpLy
8SWrB9vtEiGHDksqMIYW5aZV8VRP0i6nO6GJD+zzERZSSoNkgZlHjN8v0SdsI53+
2MlVSnRHREMVT8sbia1AdD9vwsDwxw9gfUmK7Mv4V+BnXhaejyjbY+VCFRlpYV4T
wPP5+r290+RpffiixvXJ/YSWfJldOr6iCl2909dfDGZxaCR5jqa/+redxppQE9Cd
nUgsx943xvgE5OmT+jINPXbJski9WdDWs633UZuFEsX2Ly6nfS0rhaA2XL2edP4p
v7UltjECgYEAzkMfdfzQCXRLK0B/zaoPnKK3j/K0Bb9dA4pWNq3h6q0ftpsqjSot
iohs4yKOKDEsdDAqu30JbEfrt5bMGlrNsZH0F9MGokh/MROHmOXqRnNy0f7Vndxn
I1RWM+KIXIo/LVfqXJqoxqm5vgjvw1rkfoj/mEAtpVnZMyupxbjmKP8CgYEA+2wh
lCxlX8JMjXGio7SFrT9MZ5ts0BWdXU05yffn75YNggQZiQOLAX/MTB8SAXXryOV1
84PH6HkoVR0OEpdelSgg+Imm+VmkSqMw9f1R2yF8oNJkSgRxhqA8O0YLRjjc8Jmw
CQHXJj4c/y1CBAOh69hB4ARTEOqDcsYGIui40+UCgYEAyq/ZLaeGg5Pc/h6+uEqC
VujrOzBDyVYYQA9j0w2h8Gu5u0bVVKz63aRcZAMj8MkJpw9iHqWradVvBBTScp+C
fBkx5WuAnF5jZsWLPSvJwPtX/JXQMvVQAL6yiv/0AgP0O0mmSuPMMJS+qsi7W5xo
5xMXH/UJJfCZ6JfimCKvQd8CgYEAkpJBKR6Qorik5DiA9irBW3RxWF01nEFdkgz5
SZLqdbPmgAtfz45vNRqJwT7DwnI6WM3ca3BB1Hb9WlEr6Q6xpwbT4dBttSPbMV/d
pSpe0/67pw3ARZ49iJxVQMDexbtUojcWdsnJ4ZOIWALMX4a2mMVj8fLTciMlKn3j
CereBTkCgYAb9HJZxAunveua1FnI/P0hawD8RKNwR9IdbNGjDDDKsS9ksC623GTB
iVD4gPvonL38cGIQYE3QIJ7zG7u+sF9r8FxMqDkDocTVdYqmi3MwJB6RgN8c+Wh6
/iiXewxJDBoeC6l/iI+GRoIpMAIXihWkZs+he052iq7kSjC9j9HOqP==
-----END RSA PRIVATE KEY-----
private_key_type    rsa
serial_number       35:1f:3c:0c:f2:14:d1:46:e2:76:f4:06:a5:28:ca:1a:dc:66:5f:f2
```
