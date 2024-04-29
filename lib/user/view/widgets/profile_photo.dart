import 'package:climate_confluence/user/data/models/user.dart';
import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    required this.user,
    this.size = 100,
    this.onTap,
    super.key,
  });

  final User user;
  final double size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: user.photoUrl != null && user.photoUrl!.isValid()
          ? CircleAvatar(
              radius: size / 2,
              child: Image(
                image: NetworkImage(user.photoUrl!.getOrCrash()),
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
            )
          : Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: user.photoUrl == null || !user.photoUrl!.isValid()
                    ? Text(
                        user.name.getOr(' ')[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: size / 2,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    : null,
              ),
            ),
    );
  }
}
