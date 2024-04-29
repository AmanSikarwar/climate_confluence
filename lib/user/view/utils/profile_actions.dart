enum ProfileAction {
  create,
  edit,
  view;

  String get action => toString();

  ProfileAction fromString(String action) {
    switch (action) {
      case 'create':
        return ProfileAction.create;
      case 'edit':
        return ProfileAction.edit;
      case 'view':
        return ProfileAction.view;
      default:
        return ProfileAction.create;
    }
  }
}
