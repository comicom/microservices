# kafka

## Backgroud

### 메시징 시스템

#### 용어 정리

* MOM ( Message Oriented Middleware, 메시지 지향 미들웨어 )
  * 독립된 애플리케이션 간에 데이터를 주고받을 수 있도록 하는 시스템 디자인
    * 함수 호출, 공유메모리 등의 방식이 아닌, 메시지 교환을 이용하는 중간 계층에 대한 인프라 아키텍쳐 개념
    * 분산 컴퓨팅이 가능해지며, 서비스간의 결합성이 낮아짐
  * 비동기로 메시지를 전달하는 것이 특징
  * Queue, Broadcast, Multicast 등의 방식으로 메시지 전달
  * Pub/Sub 구조
    * 메시지를 발행하는 Publisher(Producer), 메시지를 소비하는 Subscribe(Consumer)로 구성
* Message Broker
  * 메시지 처리 또는 메시지 수신자에게 메시지를 전달하는 시스템이며, 일반적으로 MOM을 기반으로 구축됨
* MQ ( Message Queue, 메시지 큐 )
  * Message Broker와 MOM을 구현한 소프트웨어 ( RabbitMQ, ActiveMQ, kafka 등.. )
  * MOM은 메시지 전송 보장을 해야하므로 AMQP를 구현함
* AMQP ( Advanced Message Queueing Protocol )
  * 메시지를 안정적으로 주고받기 위한 인터넷 프로토콜

Kafka, RbbitMQ 등은 **"AMQP를 구현한 MOM 시스템이다"**

Message Queuing Telemetry Transport (MQTT, ISO 20922) 서비스

## 본론

### 아키텍처

## 예제

paypal Kafka example

https://github.com/paypal/couchbasekafka

## Reference

https://kafka.apache.org/

https://victorydntmd.tistory.com/344

https://www.popit.kr/kafka-%EC%9A%B4%EC%98%81%EC%9E%90%EA%B0%80-%EB%A7%90%ED%95%98%EB%8A%94-%EC%B2%98%EC%9D%8C-%EC%A0%91%ED%95%98%EB%8A%94-kafka

https://www.popit.kr/kafka-consumer-group/
