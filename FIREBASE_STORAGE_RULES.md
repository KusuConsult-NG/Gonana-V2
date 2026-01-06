# Firebase Storage Rules Configuration

## Required Action
You need to manually configure Firebase Storage rules in the Firebase Console for the `gonana-v2` project.

## Steps to Configure

1. **Go to Firebase Console**
   - Visit: https://console.firebase.google.com/
   - Select project: `gonana-v2`

2. **Navigate to Storage Rules**
   - Click on "Storage" in the left sidebar
   - Click on the "Rules" tab

3. **Update the Rules**
   - Replace the existing rules with the rules below
   - Click "Publish" to apply the changes

## Firebase Storage Rules

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    
    // Allow authenticated users to upload product images
    // Public can read product images
    match /products/{allPaths=**} {
      allow read: if true;  // Anyone can view product images
      allow write: if request.auth != null;  // Only authenticated users can upload
    }
    
    // Allow users to upload their own profile photos only
    match /profiles/{userId}/{allPaths=**} {
      allow read: if true;  // Anyone can view profile photos
      allow write: if request.auth != null && request.auth.uid == userId;  // Only owner can upload
    }
    
    // Deny all other access by default
    match /{allPaths=**} {
      allow read, write: if false;
    }
  }
}
```

## What These Rules Do

1. **Product Images** (`/products/`):
   -  Anyone can READ (view) product images
   - ✓ Only authenticated users can WRITE (upload) images
   - This allows the marketplace to display products publicly while preventing unauthorized uploads

2. **Profile Photos** (`/profiles/{userId}/`):
   - ✅ Anyone can READ (view) profile photos
   - ✓ Only the profile owner can WRITE (upload) their own photo
   - Uses Firebase Auth UID to ensure users can only modify their own profiles

3. **Everything Else**:
   - ❌ No access by default for security

## Verification

After publishing the rules:
1. Try creating a product with images in the app
2. Verify the upload succeeds (no "Storage configuration error")
3. Check Firebase Console > Storage to confirm the images appear in `/products/` folder
4. Try viewing the product images in the app (should work publicly)

## Security Notes

- These rules are production-ready and follow Firebase security best practices
- Authenticated users are verified via Firebase Auth tokens
- Profile photo uploads are restricted to the owning user only
- All file paths outside defined patterns are denied by default
