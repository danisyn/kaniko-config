# kaniko-config
Configuración de kaniko para la creación de imágenes rootless

Para subir imágenes a docker hub necesitaremos configurar un secret en kubernetes con los credenciales de docker

**kubectl create secret docker-registry regcred --docker-username="docker username" 
 --docker-password="Personal access tocken" --docker-email="email"** 
 
Para adaptar kaniko a sus necesidades debe modificar el apartado de **args**

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


 

