### HW 5

* Скачал манифесты по ссылкам

* Создал Opaque secret с двумя ключами значениями "зашифрованными" в base64:
```
base64 | minio
base64 | minio123
```

* Применил манифест secret'a.
```
kubectl apply -f minio-secret.yaml
```

* Изменил значения полей обьявнения переменных окружения в поде StatefulSet, таким образом, чтобы они брались из secret.

* Применил манифесты StatefulSet и PV/PVC
```
$ kubectl apply -f minio-statefulset-secret.yaml
statefulset.apps/minio created
$ kubectl apply -f minio-headless-service.yaml
service/minio created
```

* Проверил созданные ресурсы.
```
$ kubectl get statefulsets
NAME    READY   AGE
minio   1/1     30s
$ kubectl get pods
NAME      READY   STATUS    RESTARTS   AGE
minio-0   1/1     Running   0          39s
$ kubectl get pvc
NAME           STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
data-minio-0   Bound    pvc-23dfbcbd-47c4-44d5-8583-e5e52ba7874a   10Gi       RWO            standard       48s
$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                  STORAGECLASS   REASON   AGE
pvc-23dfbcbd-47c4-44d5-8583-e5e52ba7874a   10Gi       RWO            Delete           Bound    default/data-minio-0   standard                59s
```

* Исследовал созданные ресурсы с помощью kubectl describe.

