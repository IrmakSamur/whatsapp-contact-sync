<script setup lang="ts"></script>

<template>
  <div class="h-max bg-base-200 py-6 px-12 grid place-content-center">
    <div class="max-w-4xl bg-base-200">
      <h1 class="text-5xl font-bold">Privacy</h1>
      <p>
        WhatsApp Contact Sync is a self-hosted app. It runs on your own
        computer, and there is no central server that receives your data.
      </p>
      <h2 class="text-2xl font-bold pt-4">What the app accesses</h2>
      <ul class="list-disc pl-6">
        <li>
          <strong>WhatsApp:</strong> your contacts' phone numbers and profile
          pictures, through a WhatsApp Web session you link by scanning a QR
          code.
        </li>
        <li>
          <strong>Google Contacts:</strong> your contacts list, to match phone
          numbers and update contact photos, through a Google sign-in you
          approve.
        </li>
      </ul>
      <h2 class="text-2xl font-bold pt-4">What happens with it</h2>
      <p>
        Data only travels between this computer, WhatsApp and Google. Nothing is
        sent anywhere else, and nothing is stored after the app stops: the
        WhatsApp session and Google sign-in are kept in memory only.
      </p>
      <h2 class="text-2xl font-bold pt-4">Revoking access</h2>
      <p>
        Remove the linked device in WhatsApp under
        <em>Settings → Linked devices</em>, and remove the app's access to your
        Google account at
        <a href="https://myaccount.google.com/permissions" target="_blank"
          >myaccount.google.com/permissions</a
        >.
      </p>
      <h2 class="text-2xl font-bold pt-4">Questions</h2>
      <p>
        Open an issue on the
        <a
          href="https://github.com/IrmakSamur/whatsapp-contact-sync"
          target="_blank"
          >GitHub repository</a
        >.
      </p>
    </div>
  </div>
</template>

<style scoped>
p {
  padding-top: 6px;
}
</style>
