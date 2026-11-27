<script setup lang="ts"></script>

<!--
  Only shown when the backend runs with ENFORCE_PAYMENTS=true, which this
  self-hosted fork does not support. With the default settings the router
  skips this page and goes straight to /whatsapp.
-->
<template>
  <div id="home" class="hero h-full bg-base-200">
    <div class="hero-content text-center">
      <div class="max-w-md">
        <h1 class="text-5xl font-bold">Payments disabled</h1>
        <p class="py-6">
          This self-hosted version is free to use and has no payment step.
          <br /><br />
          Remove <code>ENFORCE_PAYMENTS</code> from <code>server/.env</code> (or
          set it to <code>false</code>) and restart the app to continue.
        </p>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
