from django.contrib.auth.models import User
from django.contrib.auth.password_validation import validate_password
from rest_framework import serializers
from rest_framework.validators import UniqueValidator


class RegisterSerializer(serializers.ModelSerializer):
    username = serializers.CharField(
        required=True, validators=[UniqueValidator(queryset=User.objects.all())]
    )
    password = serializers.CharField(
        required=True,
        write_only=True,
        validators=[validate_password],
    )
    password_repeat = serializers.CharField(
        required=True,
        write_only=True,
    )

    class Meta:
        model = User
        fields = ("username", "password", "password_repeat")

    def validate(self, attrs):
        if attrs["password"] != attrs["password_repeat"]:
            raise serializers.ValidationError(
                {
                    "password": "Password fields do not match.",
                }
            )

        return attrs

    def create(self, validated_data):
        user = User(
            username=validated_data["username"],
        )
        user.set_password(validated_data["password"])
        user.save()
        return user
