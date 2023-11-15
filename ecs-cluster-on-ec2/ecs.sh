#!/bin/bash
echo ECS_CLUSTER=${ECS_CLUSTER} >> /etc/ecs/ecs.config
echo ECS_AVAILABLE_LOGGING_DRIVERS=[\"awslogs\",\"fluentd\"] >> /etc/ecs/ecs.config