Return-Path: virtio-dev-return-5698-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0591598434E
	for <virtio-dev@lists.oasis-open.org>; Sun, 28 Apr 2019 22:22:44 +0000 (UTC)
From: Marco Martinelli - 13Byte srl <marco@13byte.com>
Message-ID: <abe4bd97-8010-8fd0-8ded-f9e847a4fdb3@13byte.com>
Date: Mon, 29 Apr 2019 00:22:41 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------2936571D3BB5FA8550ED4B92"
Content-Language: en-US
Subject: [virtio-dev] Request for a new device number for a virtio-audio device.
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--------------2936571D3BB5FA8550ED4B92
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,

my name is Marco, from Italy. I'm a developer that recently got an 
interest in improving the current situation of audio in qemu/kvm.

I've been working successfully on multiple patches for Scream 
(https://github.com/duncanthrax/scream 
<https://github.com/duncanthrax/scream> ), a virtual sound card for 
Microsoft Windows, that allow to transfer audio from a Windows VM to a 
Linux host. The project initially supported only stereo sound over the 
network, but with my patches now it support up to 7.1 surround and it 
can transfer the audio samples using shared memory between the VM and 
the host (based on IVSHMEM), for lower latency.

Now that was a good project, but I want to do more. I dream of an 
virtio-audio device that can handle multichannel audio in and out of the 
VM, to be used with more guest OSs than just Windows.

I know I have a long way to go to reach this goal, but I'm motivated and 
willing to learn. I admit I don't have much experience with the qemu 
source code or the virtio source code, but I learn fast.

My work on Scream was to familiarize with Windows driver development, 
VM-to-host communication and low latency audio processing.
My idea is to start with small self-contained projects to familiarize 
with the source codes of the various projects and gain the experience I 
lack, then moving on the real virtio-audio project.
This way I can both obtain more knowledge on the subjects and help the 
open source community that over the years have done so much for many.

As we speak I'm reading the VirtIO documentation, where I've found out 
that I need to require a new device number for this project (Appendix 
B.3). So, here I am.

I'm not quite sure if this email is enough to obtain a new number or if 
I need to follow some process I'm not aware of. In the meantime I'm 
using the device number 65535 as documented in the specifications.

Looking around I've seen there is a recent issue on GitHub to reserve a 
virtio-audio device id, and a patch was submitter to assign id 25 to 
audio devices.

I'm not sure how this works, is that number already assigned and I 
should use that or should I get a new one?

For last, I have a question to clear the things up for me. It is my 
understanding that in this mailing list you discuss about the 
specifications, not the actual code. What's the usual process when 
writing a new virtio device?
Should I start with writing the code and then document how it works or 
is it the opposite? Should I document it and have it approved and then 
implement the specifications?

I know that this may sound like a stupid question, but please be patient 
with me, it's my first time.


Best Regards,

Marco

--------------2936571D3BB5FA8550ED4B92
Content-Type: text/html; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-15">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi everyone,</p>
    <p>my name is Marco, from Italy. I'm a developer that recently got
      an interest in improving the current situation of audio in
      qemu/kvm.</p>
    <p>I've been working successfully on multiple patches for Scream (<a
        href="https://github.com/duncanthrax/scream">
        https://github.com/duncanthrax/scream</a> ), a virtual sound
      card for Microsoft Windows, that allow to transfer audio from a
      Windows VM to a Linux host. The project initially supported only
      stereo sound over the network, but with my patches now it support
      up to 7.1 surround and it can transfer the audio samples using
      shared memory between the VM and the host (based on IVSHMEM), for
      lower latency.<br>
    </p>
    <p>Now that was a good project, but I want to do more. I dream of an
      virtio-audio device that can handle multichannel audio in and out
      of the VM, to be used with more guest OSs than just Windows.</p>
    <p>I know I have a long way to go to reach this goal, but I'm
      motivated and willing to learn. I admit I don't have much
      experience with the qemu source code or the virtio source code,
      but I learn fast.</p>
    <p>My work on Scream was to familiarize with Windows driver
      development, VM-to-host communication and low latency audio
      processing.<br>
      My idea is to start with small self-contained projects to
      familiarize with the source codes of the various projects and gain
      the experience I lack, then moving on the real virtio-audio
      project.<br>
      This way I can both obtain more knowledge on the subjects and help
      the open source community that over the years have done so much
      for many.</p>
    <p>As we speak I'm reading the VirtIO documentation, where I've
      found out that I need to require a new device number for this
      project (Appendix B.3). So, here I am.</p>
    <p>I'm not quite sure if this email is enough to obtain a new number
      or if I need to follow some process I'm not aware of. In the
      meantime I'm using the device number 65535 as documented in the
      specifications.<br>
    </p>
    <p>Looking around I've seen there is a recent issue on GitHub to
      reserve a virtio-audio device id, and a patch was submitter to
      assign id 25 to audio devices.</p>
    <p>I'm not sure how this works, is that number already assigned and
      I should use that or should I get a new one?</p>
    <p>For last, I have a question to clear the things up for me. It is
      my understanding that in this mailing list you discuss about the
      specifications, not the actual code. What's the usual process when
      writing a new virtio device?<br>
      Should I start with writing the code and then document how it
      works or is it the opposite? Should I document it and have it
      approved and then implement the specifications?<br>
      <br>
      I know that this may sound like a stupid question, but please be
      patient with me, it's my first time.<br>
    </p>
    <p><br>
    </p>
    <p>Best Regards,</p>
    Marco
  </body>
</html>

--------------2936571D3BB5FA8550ED4B92--
