# kaniko-config
Configuración de kaniko para la creación de imágenes rootless



## kaniko para docker hub

Para subir imágenes a docker hub necesitaremos configurar un secret en kubernetes con los credenciales de docker

**kubectl create secret docker-registry regcred --docker-username="docker username" 
 --docker-password="Personal access tocken" --docker-email="email"** 
 
Modifique los siguientes argumentos para subir la imágen a su docker hub

- **--dockerfile** debe especificar donde se encuentra el dockerfile
- **--context** debe especificar la fuente del dockerfile **ex: repositorio de github danisyn/kaniko-test.git**
- **--destination** debe especificar el destino de la imágen de docker **ex: daniels7/test:v0.1**
 
```apiVersion: v1
kind: Pod
metadata:
 name: kaniko
spec:
 containers:
 - name: kaniko
   image: aisuko/kaniko-project-executor:latest
   args: ["--dockerfile=./Dockerfile","--context=git://{personal access token}@github.com/{git repository}"
   ,"--destination={docker hub user}/test:v0.1"] 
   volumeMounts:
     - name: kaniko-secret
       mountPath: /kaniko/.docker
 restartPolicy: Never
 volumes:
   - name: kaniko-secret
     secret:
       secretName: regcred
       items:
         - key: .dockerconfigjson
           path: config.json

```

## kaniko para GCP

Modifique los siguientes argumentos para subir la imágen a su repositorio de GCP

- **--dockerfile** debe especificar donde se encuentra el dockerfile
- **--context** debe especificar la fuente del dockerfile **ex: repositorio de github danisyn/kaniko-test.git**
- **--destination** debe especificar el destino de la imágen de docker **ex: gcr.io/su-repositorio/nombre-de-la-imagen:tag-de-la-imagen**

```apiVersion: v1
kind: Pod
metadata:
 name: kaniko
spec:
 containers:
 - name: kaniko
   image: aisuko/kaniko-project-executor:latest
   args: ["--context=git://{user access token}@github.com{repository}.git","--dockerfile={Dockerfile path}","--destination={GCP repository}:{image tag}"] 
 restartPolicy: Never



```
 

